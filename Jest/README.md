# jestで単体テストを書こう

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recd8ipJrExld4qtS?blocks=hide)

## 課題1

[Jest ドキュメント](https://jestjs.io/ja/docs/getting-started)

### Jestとは？（テストフレームワーク）

JavaScriptのテストフレームワークは主に、`Jest・jasmine・Mocha`。

- Mocha

  アサーション機能を持っていない。柔軟性が高い。テストライブリと組み合わせて使う。

- jasmine

   Matcherというアサーションライブラリを持つ。

- Jest

  jasmineベースらしい。アサーションなどテストをするための機能が揃っている。

[JavaScript でテストを書く時のライブラリについて調べた](https://starhoshi.hatenablog.com/entry/2017/12/14/JavaScript_%E3%81%A7%E3%83%86%E3%82%B9%E3%83%88%E3%82%92%E6%9B%B8%E3%81%8F%E6%99%82%E3%81%AE%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E8%AA%BF%E3%81%B9%E3%81%9F)

[2017年JavaScriptのテスト概論](https://postd.cc/a-complete-guide-to-testing-javascript-in-2017/)

### Mock/Stub/Spyとは？

[xUnit Test PatternsのTest Doubleパターン](https://goyoki.hatenablog.com/entry/20120301/1330608789)

## 課題2

[課題：jestのテストを作成](https://github.com/shun57/praha-challenge-templates/tree/feature/jest_practice/jestSample)

- mockとspyOnをテストコードを使わない場合の例を見て学ぶ

[js-mocking-fundamentals](https://github.com/kentcdodds/js-mocking-fundamentals)

- mockとspyOnの違い

> jest.spyOn()は、オブジェクトを引数に指定するのに対し、 jest.mock()は、モジュールを引数に指定します。
> つまり、mockの対象が引数に指定したオブジェクトだけなのか、モジュールそのものなのかという違いがあります。

[mockとspyOnの違い](https://qiita.com/m-yo-biz/items/e9b6298d111ff6d03a5e#:~:text=%E7%9A%84%E3%81%AA%E4%BD%BF%E3%81%84%E6%96%B9-,jest.,%E3%81%AE%E3%81%8B%E3%81%A8%E3%81%84%E3%81%86%E9%81%95%E3%81%84%E3%81%8C%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99%E3%80%82)


## 課題3

### 依存性の注入とモック化

- なぜカバレッジ100%にならないのか？

対象テスト内の依存モジュール部分のテストができなかったため。

- 依存性の注入とは？

モジュールAを動かすために、モジュールBが必要な状態を依存関係にあるという。
そのモジュール間の依存関係をなくすために、外部から依存モジュールを与えることを依存性の注入という。
依存性の注入を行うことで、モジュールA単独でも動かせるようになる。

- 依存性の注入で結合度の強さはどうなった？

モジュール間で与える影響が少なくなったため、2つのモジュール間の結合度は弱くなった。

### 外部サービスとの通信

#### 単体テストで外部サービスと通信するデメリット

- テストをするたびに毎回外部サービスが実行されてしまい、無駄なデータができてしまう。そして毎回削除するなどの手間がかかる。
- 外部サービスが落ちていたらテストも失敗するなど依存性が高い

#### 単体テストや統合テストの違い

- 単体テスト

  モジュール単位で要件・機能を満たしているかを確認

- 統合(結合)テスト

  モジュールを結合した際に意図通りに動作するかを確認
  また、外部システムと結合した際の確認

- システム(総合)テスト
  
  システム全体として機能や性能を満たしているかを確認する

- 受け入れテスト 
  
  開発されたシステムが要件通りかをお客様が判断する

- 負荷テスト

### sumOfArrayに配列を渡すと例外が発生するので修正

- コード、単体テストを修正
[コード修正](https://github.com/shun57/praha-challenge-templates/tree/feature/jest_practice/jestSample)

### 単体テストで補償すること

- Property Based Testingとは？

  テストデータをランダムに半自動生成して、
  生成された値が仕様を満たしているかをテストする。
  Property=テスト仕様のこと。

- なぜコード品質が向上する？

  テスト対象が複雑な場合にさまざまなパターンのデータが必要になる。
  その場合、人間がテストケース（サンプルデータ）を考えて用意することになるが、
  その特定の値にしか正当性を保証できない。<br>
  さらにテスト対象に対して必要なデータが増えたりするとさらにテストデータを追加するなど、影響範囲が大きくなってしまう。
  そのようなテストデータ生成方法だけを定義するのが、プロパティベーステストの考え方。
  仕様変更や改修でデータが増えても生成方法だけ変えれば良くなる。

[Property Based Testingでドメインロジックをテストする](https://gakuzzzz.github.io/slides/property_based_testing_for_domain/#1)

## 課題4

### 関数を3つ作成

[quiz.ts](https://github.com/shun57/praha-challenge-templates/blob/feature/jest_practice/jestSample/quiz.ts)

### jestに関するクイズ

1. --runInBandオプションの意味
2. MatcherのtoBeとtoEqualの違いは？
3. Mock Service Workerとは？

## 任意課題

[type-challenges
](https://github.com/type-challenges/type-challenges/blob/master/README.ja.md)

## 参照

[フロントエンドにテストを導入](https://qiita.com/howdy39/items/cdd5b252096f5a2fa438)

[DI (依存性の注入)っていったいなんだ？](https://jpdebug.com/p/2334077)
