# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recgLm7k5dB2OVsRl?blocks=hide)

## 課題1


### デッドロックとは？

２つのトランザクションが、お互いにロック解除待ち状態となり、処理が止まってしまう現象。
例えば、処理１はテーブルAを更新した後にテーブルBを更新する、処理2はテーブルBを更新した後にテーブルAを更新するとする。
処理１がテーブルAをロックしてテーブルBの処理に移った時、処理２がテーブルBをロックしていたら、処理１は処理２を待つ。
しかし、その状態で処理２がテーブルAの処理に進もうとすると、テーブルAがロックされているため処理２は処理１を待つ。
結果、処理１と処理２はお互いのロック解除待ちになってしまう。


#### 実際のデッドロック例

1. 原因：行ロックのつもりが、インデックスを正しく貼れておらず、テーブルロックになってしまっていた。そのテーブルロックがデッドロックの原因だった。<br>
解決：インデックスを貼って行ロックにしたことで解決

[DBがデッドロックした話](https://www.w2solution.co.jp/tech/2020/04/24/db%E3%81%8C%E3%83%87%E3%83%83%E3%83%89%E3%83%AD%E3%83%83%E3%82%AF%E3%81%97%E3%81%9F%E8%A9%B1/)

1. 原因：トランザクション順がたすき掛けになってしまっていた。(1)出品者情報を更新し、(2)購入者情報を更新する処理があった。Aさんが出品者、Bさんが購入者/Bさんが出品者、 Aさんが購入者の時にデッドロックが発生してしまう。<br>
解決：ユーザーidで並び替えして書き込み順を揃えた。

[デッドロックおじさん戦記](https://engineering.mercari.com/blog/entry/2017-12-18-deadlock/)


### ISOLATION LEVEL(トランザクション分離レベル)

データベース管理システム上でトランザクションが複数同時に行われた場合の、分離性の度合いを4段階で定義したもの。<br>
※独立性阻害要因
- ダーティーリード
- ノンリピータブルリード
- ファントムリード

| 分離レベル | 分離性の度合い |
| :--- | :--- |
| SERIALIZABLE（直列化可能） | 最も分離レベルが強く、安全性が高いが性能は低い。複数トランザクションの影響を受けない（追加、更新、削除されない） |
| REPEATABLE READ（読み取り対象のデータを常に読み取る） | トランザクション中に、読み取り対象のデータが別トランザクションにより途中で変更されない。ただし、ファントムリードが発生し得る。（別トランザクションのデータ追加・削除により、処理結果が変わる可能性がある）。 |
| READ COMMITTED（確定した最新データを常に読み取る）| トランザクションは、まだコミットされていない変更を参照できない。ただし、ファントムリード、非再現リードが発生し得る（同じトランザクション中、別トランザクションの更新によって、データを読み込むたびに別の結果データを読み取ってしまう可能性）。 |
| READ UNCOMMITTED（確定していないデータまで読み取る）| 最も分離レベルが弱く、性能が高いが安全性は低い。トランザクションは他トランザクションによるコミット前のデータも読み取ってしまう（ダーティーリード）。ファントムリード、非再現リードも発生し得る。 |


#### トランザクションの性質（ACID)

- Atomicity(原子性)

  トランザクションはそれ以上細かい単位に分割できない

- Consistency（一貫性）

  トランザクションでデータの整合性が保たれる

- Isolation（分離性）

  トランザクション同士が影響を与えない

- Durability（永続性）

  トランザクション結果が保たれる


### 行レベルのロックとテーブルロックの違い

- 行レベルのロック

レコード単位のロックのこと。ロックされている場合、行ロック中のレコードは更新できず、それ以外のレコードは更新が可能。

*※注意点*  
インデックスを利用している場合のみ行ロックとなり、利用していない場合はテーブルロックとなってしまう。

- テーブルロック

テーブル単位のロックのこと。ロックされている場合、全レコードがロック待ちになり、更新できない。


### 悲観ロックと楽観ロックの違い

- 悲観ロック

同時アクセスによるデータの不整合が起きる可能性が高い、またはそうなったら不味いという悲観的な前提に基づく排他制御。
更新対象のデータに対して取得時にロックをかけることで、他トランザクションによるアクセスを防ぎ、更新が完了したらロックを解除することでデータの整合性を保証する。他トランザクションはロックが解除されたら処理を開始する。
同時に2つ以上のリクエストが来る可能性が高かったり、競合発生時にエラーにしたくない場合などに選択する。
楽観ロックとの違いはデータをロックするか否か（データベースが行うか、アプリが行うか）。

- 楽観ロック

同時アクセスによるデータの不整合は滅多に起きないだろうという楽観的な前提に基づく排他制御。
データそのものに対してロックを行わずに、更新対象のデータが取得時のデータと同じ状態であることを確認してからデータを更新することでデータの整合性を保証する。
例えば、バージョンカラム(ロックキー)を用意し、更新時の条件として、取得時のバージョン値と一致した時のみ更新する。
バージョンが異なる場合は、他の更新が被った時なので、更新は失敗する。
同時に２つ以上のリクエストが来る可能性が低かったり、競合発生してもやり直せば済む場合に選択する。


#### 排他制御とは？

共有資源（データやファイル）に対して、複数のアクセスが見込まれる場合に、同時アクセスによるデータの不整合の発生を防ぐために制御を行うこと。


### 共有ロックと排他(占有)ロックの違い

悲観ロックは、共有ロックと排他ロックに分けられる?

- 共有ロック(LOCK IN SHARE MODE/FOR SHARE)
  
  レコード更新を禁止するロック。
  参照は可能なため同時に同一レコードにアクセスできる。

- 排他ロック(FOR UPDATE)

  レコードの更新と参照を禁止するロック。
  ロックが終わるまで他のトランザクションは参照もできない。

- select for updateは排他ロック。


### fuzzy-readとphantom-readの違い

fuzzy-readは更新処理に対するもので、ファントムリードは追加処理に対するもの。

- fuzzy-read

  あるトランザクション1がレコードを読み取った後、他トランザクションによって更新されることで、同トランザクション1内で再度そのレコードを読み取った際にデータが異なってしまうこと。

- phantom-read

  あるトランザクション1がレコードを読み取った後、他トランザクションによって追加されることで、同トランザクション1内で再度そのレコードを読み取った際にデータが異なってしまうこと。

## 課題2


### 分離レベル確認SQLクエリ

[サンプルSQLクエリ](sample_query.sql)


### 　映画チケット販売システムのロック

- 多重予約の可能性が低い
- 10台なので同時の更新が少ない
- チケット予約なので高速な方がユーザーにとってはいい
- 同じ席を取ろうとしてエラーになったら微妙だけどまあ早い者勝ちで許容できるか、、、？
- 上記から楽観ロックを利用する。


#### 楽観ロックの実装

```
// ①DBからチケット情報とバージョンを取得
seat = getEmptyMovieSeat(movieId) 

// ②①で取得した条件で検索し、シートを確保。バージョンを+1する。
save seat, version + 1 where version = seat.varsion
   -> throw('その席は既に購入されていますよ!')　// ③②のデータが無ければエラ

// ③(まだ席が購入されていない場合の処理に進む)
make payment // 外部APIを用いて決裁を行う
```


#### 外部APIと内部処理どちらを先に実施するか？

- 内部処理を先に実施すべき

外部API(例えば決済)が成功した後に、内部処理が失敗した場合、ロールバックが難しい。外部APIが元に戻せる処理があるならいいがそれも大変だし、ない場合もある。
内部処理が成功し、外部APIが失敗したとき、内部処理は容易にロールバックできる。
また、トランザクションがない場合、決済は成功したのに、内部のデータベースでは決済していないことになってしまうことがありえる・

- 元々の処理コードだと決済後にチケットを確保しているので、チケットの確保が失敗したら決済したのにチケットが確保できていない状態になってしまう。


## 課題3(クイズ)

1. NoSQLではトランザクションは実現できるでしょうか？
2. MySQL(InnoDB)のギャップロックとはなんでしょうか？
3. MySQLとPostgreSQLのトランザクションにおける違いはなんでしょうか？


## 参照

[リレーショナルデータベース　デッドロックの具体例](https://qiita.com/Black_Kite/items/8795d03aacfe9d35ceaf)

[トランザクション分離レベルについて](https://techracho.bpsinc.jp/kotetsu75/2018_12_14/66410)

[楽観ロックと悲観ロック](https://e-words.jp/w/%E6%A5%BD%E8%A6%B3%E3%83%AD%E3%83%83%E3%82%AF-%E6%82%B2%E8%A6%B3%E3%83%AD%E3%83%83%E3%82%AF.html)

[Railsの楽観的ロックと悲観的ロックの違い](https://zenn.dev/shuhei_takada/books/3ff66325f45adc/viewer/2bf43c)

[MySQL の InnoDB でトランザクション分離レベルの違いを試す](https://blog.amedama.jp/entry/mysql-innodb-tx-iso-levels)