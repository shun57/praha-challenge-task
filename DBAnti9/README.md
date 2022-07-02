# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recNGM3rfpw1qAp5x?blocks=hide)

## 課題1

1. Check
メールアドレスの特定のドメインを変えたいということがあり得る。その場合、過去データの洗い替えが必要になるため、Checkを使うべきではない。

2. Trigger
ログとして使いたい場合（アプリ為替は見ない）は、Triggerを使って「WithdrawnUser」テーブルにデータを挿入してもいい。

3. Enum
後からgenderの定義を追加・変更したいという可能性がある。その場合、定義の変更により、過去データの洗い替えが必要になるため、Enumを使うべきではない。

4. Domain
特定制約を変える場合にDomainの定義し直しが必要なため使うべきではない。

## 課題2

- どのケースでも、値が確実に決まっていて変わらないことが保証される場合はデータベース側で制約を課し、そうでない場合はアプリケーション側で課すアプローチとすべき。

## 課題3

- 在庫管理をするシステムで、商品コードが決まっているということでDomainで形式の制御をつける。また、削除した商品のデータも画面上から見たいということでTriggerを使って別テーブルに保持することにした。在庫のステータス（販売済みなど）は固定のためEnumを持たせた。

## 参照情報

[3分でわかるトリガー -使い所と問題点を考える-
](https://qiita.com/wanko5296/items/fa3620c48196acbd3ab6)

[ALTER DOMAIN
](https://www.postgresql.jp/document/9.2/html/sql-alterdomain.html)