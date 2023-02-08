# オニオンアーキテクチャを学ぶ

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recCneTjC0Ws8VVh1?blocks=hide)

## 課題1

### 図解

[図解](./onion.drawio)

### ドメインモデル層独立のメリット

UI、インフラ、アプリケーションロジックの都合に影響を受けにくくなるため複雑さが減る。ドメインモデルがカプセル化でき、データの整合性を担保できる。

#### 参考

https://little-hands.hatenablog.com/entry/2018/04/04/layer-obligation

### 層を跨いだ依存関係が発生するときにインターフェースに対する依存のみ許可するメリット

レイヤー(層)間の結合度が低くなることで、外部レイヤー(層)の詳細をする必要がなくなり、それぞれのモジュールの役割が分離される  
そのため、テストのしやすさやモジュールの変更/移行のしやすさなど保守性の高い開発をすることができる


### 依存性の逆転の使われ方

インフラ層とビジネスロジック/ドメイン層との依存関係が密にならないように、依存性の逆転を用いることで、インフラ層の変更がビジネスロジック/ドメイン層に影響を与えなくする

### ユーザのアクセス制限機能はどの層に記述するか？

- ユーザインターフェース層
参考記事にあるように、認可(アクセス制限)は外部クライアントとのインターフェースであるため

#### 参考

https://blog.itsjavi.com/target-software-architectures-the-onion-architecture

### DBMSを変更する場合どの層を変更する？

インフラ層を変更する

## 参考

https://medium.com/expedia-group-tech/onion-architecture-deed8a554423

## 課題2

1. レイヤードアーキテクチャとはなんでしょうか？またオニオンアーキテクチャとレイヤードアーキテクチャの違いはなんでしょうか？
https://qiita.com/Jazuma/items/cae61c78f240ed013598

2. オニオンアーキテクチャのデメリットはなんでしょうか？デメリットを踏まえるとどのようなサービスには向いていないでしょうか？

https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/amp/

3. オニオンアーキテクチャのレイヤーで、ドメインサービスとアプリケーションサービスの役割の違いはなんでしょうか？

https://little-hands.hatenablog.com/entry/2018/04/04/layer-obligation