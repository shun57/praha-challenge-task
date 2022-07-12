# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/rec5ou3KuBzpEnP5Y?blocks=hide)

## 課題1

### スナップショットテストとは？

変更前の出力結果(スナップショット)と変更後の出力結果を比較し、2つの出力結果に差分があるかどうかをテストする手法のこと。

### スナップショットで防げること

- 差分がわかるため、意図しない変更を防げる
- 何度も手動で画面確認をすることを防げる
- 大量のアサーションを書くことを防げる

### スナップショットで防げないこと

- 差分はわかるが、変更(ロジック)が正しいかどうかの間違いは防げない
- 変更が多すぎる場合に見落とす可能性があり、防げない
- 結果が逐一変わるものは防げない

## 課題2

### snapshot testの導入

https://github.com/shun57/react-tutorial

### スナップショットの情報

ストーリーごとにレンダリングされたDOM要素が出力されている

### 文言の変更

https://github.com/shun57/react-tutorial/pull/1/files

src/Game.jsx 71行目


## 課題3

1. Jestにおけるスナップショットテストで`--testNamePattern`フラグをつけるとどうなるでしょうか？
2. スナップショットテストとビジュアルリグレッションテストの違いはなんでしょうか？またビジュアルリグレッションテストと比べてスナップショットテストにしかできないことはなんでしょうか？
3. Storyshots以外のスナップショットのツールを１つ以上挙げてください。

## 任意課題

- css-in-js emotionを導入
  https://github.com/shun57/react-tutorial/pull/1/files
  

### 参考

[世はReact with CSS 戦国時代...!](https://zenn.dev/irico/articles/d0b2d8160d8e63)