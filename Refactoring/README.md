# リファクタリング

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recKUo7Rl1riLj7Pq?blocks=hide)

## 課題1

### 選んだプロジェクト

- https://github.com/shun57/collect-rent

### システム構成

- Scrap
https://zenn.dev/shun57/scraps/a5fe2762bc9a36

### 前提
- mpywさんの記事を参考にして構成しているのでリファクタリングというよりはLaravelでDDDという落とし所で検討する
※mpywさんの記事ではほとんどのプロジェクトでDDDはオーバースペックなんじゃないかということ

## リファクタリング方針

### アーキテクチャ

- オニオンアーキテクチャ+DDDとする

### ディレクトリ構成

* src/app
  * Console
  * Enums
  * Exceptions
  * Domain (ドメイン層)
    * Entity
    * Interface
    * Service
  * Http (プレゼンテーション層)
    * Controllers 
  * Infra(インフラ層)
  * Logging
  * Models
  * Providers
  * UseCase(ユースケース層)

※ドメインごとにディレクトリを区切ってもいいかも

### モデリング

- ユーザー集約（ユーザー、ユーザー認証、ソーシャルプロバイダ）
- 貸出情報集約（貸出履歴）

### 処理の流れ

1. Controler
2. UseCase(Entityに変換)
3. Repository(Interface) 依存性逆転
4. Infra(implements Repository) EloquentではなくEntityを返す

### 実装の具体例

#### UseCase

- 初期ファイル
Laravelだと認証の仕組みを自動で作ってくれるが、Controller側でModelの呼び出しとかしちゃっている。楽ではあるが全て修正が必要。


- indexAction
ページネーションを入れる

- storeAction
有料プランを作ろうとしているのでユーザーを会員として有料/無料のフラグを持たせる。会員Entity側で貸出の件数チェックを行う。会員Entityを作るときにバリデーションした方がいい？

### 感想

- 綺麗にやるならEloquentモデルを使わずにEntityを作るべきだが、Laravelの利点を活かせない
- ただその場合Modelを残してEntitiyも使うということになる。ModelはInfra層でのみ利用する（ソースでは縛れないか？）

## 参考

[Laravelでドメイン駆動設計(DDD)を実践し、Eloquent Model依存の設計から脱却する](https://qiita.com/mejileben/items/302a9f502ca0801b1efb)

[Laravel × オニオンアーキテクチャで始めるテスト駆動開発](https://speakerdeck.com/canon1ky/laravel-x-onionakitekutiyadeshi-merutesutoqu-dong-kai-fa?slide=40)