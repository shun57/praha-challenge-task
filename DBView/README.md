# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recica9F8d3kaCUWx?blocks=hide)

## 課題1

### ビューの仕組み

ビューは リレーショナルデータベースにおける仕組みの一つで、データベースに定義したテーブルを複数組み合わせて作ることができる、実態のない「仮想的なテーブル」のことです。
ただし、「仮想的なテーブル」の実態は「SQLのSELECT文」です。簡単に言えばSQLのSELECT文をテーブルっぽく表現できます。
なので、作られたビュー(仮想的なテーブル)にアクセスすると、あらかじめ定義されたSQLのSELECT文が実行されるイメージです。
ビューは`CREATE VIEW ビュー名 AS SELECT文;`で作ることができ、`SELECT * FROM ビュー名`で、テーブルのように参照することができます。
動きとしては、参照されるたびに一時的な仮想テーブルが作成されます。

### ビューの用途・メリット

- 複雑なクエリをシンプルにできる
何度も利用する複雑なクエリがある場合、ビューとして定義しておけば、シンプルなSQL文で記載できる。

- アクセス制御が可能
ビューへのアクセス制御が可能である。
例えば、実テーブルに書き込み・参照させたくないが、一部書き込み・参照をさせたいデータがある場合に、そのデータだけを取得するビューを定義して、アクセス制御を行うことができる。

- インデックスが定義できないため、ビューに対するwhere条件やビュー同士や他テーブルとの結合をすると、パフォーマンスが低下する可能性もある。

- 更新は制限があるため注意（集約関数を使っているなど）

### Materialized View（体現ビュー)とは？
SQLの一時点での結果を仮想テーブルとして保持するビュー。そのため、参照ごとに再検索を行わない。（スナップショットのイメージ）

#### Viewとの違い

- ViewはSELECT文だけ保持しているが、MaterializedViewはデータ自体を保持している。そのため実際の結果データをそのまま返すので、パフォーマンスが高い。※ただしストレージ容量を消費する
- MaterializedViewは作成時のテーブル情報を保持するので、最新に更新したい場合は、リフレッシュする必要がある。
- MaterializedViewは主キーやインデックスを定義できる。

## 課題2

- ViewにするSQL文

```
SELECT E.first_name, E.last_name FROM employees.employees AS E INNER JOIN employees.salaries AS S ON E.emp_no = S.emp_no WHERE S.salary > 90000;
時間：1.7 sec
```

- VIEW  
 クエリのパフォーマンスは変わらず
```
// View作成
CREATE VIEW high_salary_employees AS ~
// クエリ
SELECT * FROM high_salary_employees;
時間：1.7 sec
```

## 参照

[マテリアライズド・ビューの概要とアーキテクチャ](https://docs.oracle.com/cd/E57425_01/121/REPLN/repmview.htm#BABIIDJC)

[マテリアライズドビューの機能（PostgreSQL）](https://qiita.com/jiyu58546526/items/84182206f9c908b47d38)

## 確認事項

- 実務ではどういうケースでViewやMaterialized Viewの利用を検討するか？  
※Materialized Viewに関してはMySQLだと使えないので、ほとんど検討には入らないか？