# lintを使おう

## 課題1

### なぜlintが必要

- 誰がコードを書いても一定の質・一貫性を担保できる
- 潜在的なバグの原因や文法の誤りを事前に発見することができる


#### lintとは

文法上の誤りやバグの原因となりうるコードに対して警告をしてくれる静的解析ツール

### ESLintルール

- eqeqeq : 厳密等価演算子を利用するよう強制する
- no-unused-vars : 未使用の定義(変数、関数)は削除する ※プラグインの方が良さそう
- quotes : クォートを統一
- semi : セミコロンを統一
- camelcase : キャメルケースにする

### shareable config(eslint-config-airbnb)導入

https://github.com/shun57/praha-challenge-ddd/pull/19

### 参考

https://typescriptbook.jp/tutorials/eslint#shareable-config%E3%82%92%E5%B0%8E%E5%85%A5%E3%81%99%E3%82%8B

## 課題2

### 実装

https://github.com/shun57/praha-challenge-ddd/pull/19

### 問題点

- ローカルなので無効にすることができる
- 修正を急いでいるときなどにスキップされる可能性がある
※git commit --no-verifyをつければスキップできる