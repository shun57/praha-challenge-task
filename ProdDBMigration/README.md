# 本番稼働中のデータベースをマイグレーションしよう

## 課題1

### expand and contract pattern

マイグレーションの際に移行フェーズを設けることでダウンタイムを回避する手法。
移行開始、移行中、移行終了のタイミングを持ち、移行中は新旧両方の状態を維持する。
例えばnameを消して、first nameとlast nameにしたい場合も、移行中まではnameを残しておく。
これによって後方互換性を維持しながら移行できる。

参考：npx prisma migrate dev --name add_post

### マイグレーションが開発環境ではうまくいったのに本番環境ではうまくいかないのはなぜ？

- 既存のデータが入っているため、NOT NULL制約のカラムにデフォルト値を入れないとエラーになってしまう
- 大量データの場合、すべてのNOT NULL制約対象カラムのデータを更新する必要があり、時間がかかったりロックされたり既存運用に影響を与える
- アプリケーションロジックをNOT NULLに対応させる必要がある(NULLを入れているロジックを探すなど)

=> 段階的に実施する ex.) 1.nullを入れているロジックを更新して値を入れ、バリデーションを設定する、2.カラムに値を入れる（大量なら夜間バッチを作るなど）、3.NOT NULL制約のマイグレーションをする

参考：
https://gitlab-docs.creationline.com/ee/development/database/not_null_constraints.html
https://nulab.com/ja/blog/typetalk/change-postgresql-schema-with-safety-and-non-stop

## 課題2

参考：https://www.prisma.io/docs/orm/prisma-migrate/workflows/data-migration

### 本番マイグレーション作業手順書

前提：ユーザーとペアが１対１

#### テーブルを作成

##### ユーザー所属ペアテーブル（中間テーブル）を作成するマイグレーションを作る

1. prisma/schema.prismaに以下を追記

```
model PairMember {
  id                     String       @id
  participant            Participant  @relation(fields: [participantId], references: [id])
  pair                   Pair         @relation(fields: [pairId], references: [id])
  participantId          String
  pairId                 String
}

model Participant {
    pairMembers          PairMember[] ←追加
}

model Pair {
  pairMembers            PairMember[] ←追加
}
```

2. ローカル環境でマイグレーションファイルを作成する

```
npx prisma migrate dev --name add-pair-member
```

#### データ移行ファイルを作成する

prisma/migrations/20230417131956_add-pair-member/data-migration.ts

```
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  await prisma.$transaction(async (tx) => {
    const participants = await tx.participant.findMany()
    for (const participant of participants) {
      await tx.pairMember.create({
        data: {
            participantId: participant.id,
            pairId: participant.pairId,
        },
      })
    }
  })
}

main()
  .catch(async (e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => await prisma.$disconnect())
```

#### ローカル環境で試す

1. マイグレーションとデータ移行が実行できるかをローカル環境で試しておく
2. ロールバックできるか確認しておく

#### DBバックアップを取る

1. 検証環境のDBのバックアップを取ります

#### 検証環境でマイグレーションを実施する

1. stageブランチにマージしてリリースします

2. 検証環境に入り、下記のコマンドを実施します
```
$ prisma migrate deploy
$ prisma generate
```

#### データ移行を実施

1. 移行を実施するコマンドを追加します

package.json

```
"scripts": {
    "data-migration:add-pair-member": "ts-node ./prisma/migrations/20230417131956_add-pair-member/data-migration.ts"
  },
```

2. stageブランチにマージしてリリースします

3. 検証環境で下記のコマンドを実施します

```
npm run data-migration:add-pair-member
```

#### アプリのペア作成機能を修正

1. ペアを取得する際に、pairMemberから参照するように修正
2. ペア作成の場合にpairMemberにデータを登録するように修正
3. 検証環境にリリースする
4. 動作確認を行う

- 発生しうる問題、対処法

データの不整合が発生した場合、アプリロジックを元に戻し、DBバックアップを適用する

#### 不要な列を削除

1. prisma/schema.prismaから削除

```
model Participant {
    pairId ←削除
}
```

1. マイグレーションファイルを作成

```
npx prisma migrate dev --name drop-pairId-column
```

#### 検証環境でマイグレーションを実施

1. stageブランチにマージしてリリースします

2. 検証環境に入り、下記のコマンドを実施します

```
prisma migrate deploy
```

- 発生しうる問題、対処法

アプリ側のロジックが変わっていない箇所がありエラーとなる場合は、ロジックの修正を行う
ロックがかかるため

#### 本番環境で上記と同じ手順を行う

#### 参考

MySQLにはオンラインDDLという機能があり、弱いロックでUPDATEなど実施できるらしい
https://dev.mysql.com/doc/refman/8.0/ja/innodb-online-ddl-operations.html#online-ddl-column-operations
