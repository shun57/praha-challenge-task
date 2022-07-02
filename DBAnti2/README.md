# データベース設計のアンチパターンを学ぶ2

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recMnulhLBbmkuY8y?blocks=hide)

## 課題1

- タグの登録・削除のときにPostテーブルの更新も必要になってしまう。忘れた場合に不整合が生じる。
- タグが255個以内しか追加できない。
- タグが1つしかないのにタグが100スペースあった場合に、使われないカラム（null）が多く発生してしまい効率が悪い。
- SELECTでタグ名を取得するときにめんどくさい。
{code}
select * from Post where tag1id = 1 and tag1id = 2 and ・・・
{code}

## 課題2

※アンチパターン１と同じ内容
[ダイアグラム](https://dbdiagram.io/d/61a1e7738c901501c0d4eec9)

## 課題3

- レストラン予約サービスでレストランのカテゴリは１つだけとしていた（日本食など）が、カテゴリの英名・中国語名・韓国語名も入れたいとなり、カラムを増やした。ex. category_en、category_chなど。


## 参照情報

[マルチカラムアトリビュート](https://qiita.com/mizunokura/items/a9be12e0eddcf5d90f07)  
