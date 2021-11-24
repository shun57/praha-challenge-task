# 課題1

[ダイアグラム](https://dbdiagram.io/d/619c9a7202cf5d186b639e73)

## テーブル構成概要

|テーブル名|説明|
|:--|:--|
|users|ユーザー管理|
|articles|記事の管理|
|article_histories|記事変更履歴の管理|

## 要望

[要望内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recjOqZmJIYx5eKIc?blocks=hide)

## 要望への対応

1. 記事

- textカラムで1000字程度の本文を記入できる

2. 記事の履歴

- 記事の履歴はarticle_historiesテーブルで管理する
- article_historiesにarticles.idを持たせることで、記事の履歴を一覧表示できる
- aritcle_historiesの履歴を参照することで過去の記事に戻すことが可能

3. 最新記事

- articlesが最新記事となる

## 参照情報

[履歴テーブルについて](https://user-first.ikyu.co.jp/entry/history-table)  

[変更履歴をもつテーブルの設計](https://qiita.com/ak-ymst/items/2e8e92f212c807bb09a1)


# 課題2

## 要望

1. 分析の用途でも履歴データをデータベースに保存する必要はあるか？

- アプリケーション内で利用しないデータであれば保存する必要はなさそう(パフォーマンスに影響がある無駄データになる)
- 保持したい場合は、別DBを用意するなどはありか
- お金があるならBIツールなどの選択肢もありえる。BigQueryなども。
- データ量が少なかったりアプリでも利用したりするなら保存してもいいか

2. 課題1とは別パターンで表現する

[ダイアグラム](https://dbdiagram.io/d/619cfffe02cf5d186b648011)