# データベース設計のアンチパターンを学ぶ3

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recUWyprfKVRDA777?blocks=hide)

## 課題1

- 今後、「絵本」などのリソースができたときに、コメントにtypeを追加するかテーブル構成の変更が必要となる。さらに重くなったり、変更の影響が大きくなったりする。
- 外部キー制約を持たせられないためbelongs_to_idに入っているIDがNovelやMangaに存在することを担保できない。
- 運用を経て、typeが増えたり減ったりした場合にtypeにある値がテーブルと整合しているのかが保証できなくなる。

## 課題2

親テーブルで解決
[ダイアグラム](https://dbdiagram.io/d/61a634608c901501c0d98fbc)

- 理由：絵本とか新書とか増える可能性あるため

## 課題3

- 履修を管理するようなサービスで大学生ユーザーに対して履修が紐づいていた。サービスを拡張することになり、大学院生ユーザーの履修も管理することになり、履修にidと学生typeを持たせた。


## 参照情報

[複数のテーブルに対して多対一で紐づくテーブルの設計アプローチ](https://spice-factory.co.jp/development/has-and-belongs-to-many-table/)

[SQLアンチパターン勉強会　第6回：ポリモーフィック関連](https://qiita.com/dai329/items/1db8fbe37f43a465d801)