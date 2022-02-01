## SQL10本ノック

[SQL10本ノック](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recFl7p6z8GdsGTYa?blocks=hide)

## 課題1
[SQL:1~10](./1~10.sql)

## 課題2

### WHEREとHAVINGの違い
- どちらも抽出条件を指定できるが、評価順序が異なる。GROUP BYがある場合、WHEREはグループ化前に実行され、HAVINGはグループ化後に実行される。
- 集約関数を使えるかどうかが異なる。WHEREは集計前に実行するため使えず、HAVINGは使える。
- 集約関数を使いたい場合やGROUP BYに対して抽出条件を指定したい場合はHAVINGを使う。それ以外はWHEREの方がレスポンスが速いためWHEREを使う。

#### 参考
SQLコマンドの実行順
1. FROM
2. ON
3. JOIN
4. WHERE
5. GROUP BY
6. HAVING
7. SELECT
8. DISTINCT
9. ORDER BY
10. LIMIT

[SELECT分の評価順序の話](https://qiita.com/suzukito/items/edcd00e680186f2930a8)

### DDL~TCL
SQL命令の種類

- DDL
データ定義言語：
データベースへ行う操作。テーブルの作成・削除・各種設定などを命令する言語。

- DCL
データ制御言語：
データベースへ行う操作。DDLやDMLの利用に関する許可を命令する言語。

- DML
データ操作言語：
データベース内のテーブルへ行う操作。データ取得・登録・更新・削除などを命令する言語。

- TCL
トランザクション制御言語：
データベース内のテーブルへ行う操作。トランザクションの開始や終了などを命令する言語。

## 課題3

### SQLクエリクイズ

1. LIKE句のワイルドカード文字について説明してください。
2. Addressに「.」と「,」を含まないCustomerを抽出してください。
https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all
3. COALESCEとは？どのような時に使うか説明してください。


