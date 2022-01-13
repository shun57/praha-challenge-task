# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/reckrvr9nBhbP9N5P?blocks=hide)

## 課題1

- NULL = 0 (式ではNULL)
結果なし

- NULL = NULL (式ではNULL)
結果なし

- NULL <> NULL (式ではNULL)
結果なし

- NULL AND TRUE (式ではNULL)
結果なし

- NULL AND FALSE (式ではFALSE)
結果なし

- NULL OR TRUE (式ではTRUE)
全件取得

## 課題2

[ダイアグラム](https://dbdiagram.io/d/61d1ae323205b45b73d3c592)

### NULLの是非

- 外部キー等Whereで指定されやすいものに関してはNULLはNGかと考えるが、テーブルとして重要度が低いカラムであればNULLを許容してもいい気がする(textやvarcharなどwhereで指定されづらい）。

## 課題3

### クイズ

- NULL OR FALSEの結果は？
- カラム <=> NULLの結果は？

## 参照

[SQLアンチパターン-13章 恐怖のunknown-まとめ](https://qiita.com/aaaaanochira/items/c0e8cdec5a8044bfe2eb)