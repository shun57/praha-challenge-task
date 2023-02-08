# DDDを学ぶ（基礎）

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/rec7UTLVNAdjzu2sQ?blocks=hide)

## 課題1

### ドメイン駆動設計とは？

- ドメインの中核となる複雑さと機会に焦点を当てる
- ドメイン専門家とソフトウェア専門家のコラボレーションでモデルを探求する
- 明示的ににそれらのモデルを表現するソフトウェアを書く
- 境界づけられたコンテキストの中のユビキタス言語で話す

#### まとめると

ソフトウェア開発者、ドメインエキスパートと共に常に同じ言語で認識を合わせ、ドメインモデルについて常に探求を続ける。
そして最終的にモデルと言語をソフトウェアにまで落としこむことを目指す開発手法のこと。

#### DDDリファレンス

https://www.domainlanguage.com/ddd/reference/

### エンティティ

- ライフサイクルのあるドメインオブジェクトのこと
- 識別子によって区別され、可変という性質を持つ

### 値オブジェクト（バリューオブジェクト）

- システム固有の値を表現するドメインオブジェクトのこと
- 保持する属性によって区別され、不変という性質を持つ

### 集約

- 整合性を持った複数のドメインオブジェクトをひとまとまりにしたもののこと、それにより一つの意味を持ったオブジェクトが構築される
- 集約には境界とルートが存在する。境界は集約に何が含まれるかを定義するものであり、ルートは外部からの操作の窓口となる特定のオブジェクトを指す

### ユビキタス言語

- プロジェクトチーム全体の共通言語として定義されるもの
- 認識齟齬や翻訳にコストをかけないために必要とされる

### 境界づけられたコンテキスト

- 同じユビキタス言語を使う範囲(コンテキスト)のこと
- 同じ単語でもコンテキストが異なれば概念が異なる

#### 参考

https://little-hands.hatenablog.com/entry/2017/11/28/bouded-context-concept

### ドメイン

- アプリケーションの対象となる業務領域のこと
- 現実の概念・事象を抽象化する作業をモデリングと呼び、ドメインの概念をモデリングして得られたモデルをドメインモデルと呼ぶ

### ドメインサービス

- エンティティや値オブジェクトの責務ではない(不自然さを解消する)ドメインモデルのロジックのこと
- 自身の振る舞いを変更するような状態を持たないオブジェクト
- 例えばユーザの重複確認をエンティティに持たせると、自分自身に問い合わせることになってしまい不自然になってしまうため、ユーザサービスというドメインサービスに記述するようなこと。


### リポジトリ

- オブジェクトの永続化や再構築を担う
- データストアを操作する処理を抽象的に扱えるようにすることで、データストアの差し替えを実現できる
- 永続化などを行う場合、直接データストアに書き込みを行う処理を実行するのではなく、リポジトリに永続化を依頼する


### アプリケーション（ユースケース層と呼ばれることも）

- ドメインオブジェクトが行うタスクの進行を管理し、利用者の課題を解決するためのユースケースを実現する
- ドメインをコードで表現しただけでは利用者の問題を解決できなく、ドメインを組み合わせる必要があり、その役割を担う

### CQS/CQRS

#### CQS(コマンド・クエリ分離原則)

オブジェクトのメソッドを２つに分類する原則であり、分類を守ることで副作用を最小限にするためのもの

- コマンド：オブジェクトの状態を変更するが、値を返さない
- クエリ：結果を返すが、オブジェクトの状態を変更しない

#### CQRS(コマンド・クエリ責務分離原則)

- CQSをアーキテクチャとして定義したもの
- データストアに対する更新操作を集めた「コマンド処理」と、読み取り操作を集めた「クエリ処理」を完全に分離するアーキテクチャパターン

##### 参考

[CQRS パターン]
(https://learn.microsoft.com/ja-jp/azure/architecture/patterns/cqrs)

##### メリット

- コマンド処理とクエリ処理を切り離すことで、読み取りによる負荷が減り、更新処理のパフォーマンスを上げることができる
- コマンド処理とクエリ処理を切り離すことで、データストアに対するロック競合を減らすことができる
- 書き込み側では更新用に最適化されたスキーマ（例えば、リレーショナルデータベース）を使用し、読み取り側ではクエリ用に最適化されたスキーマ（例えば、ドキュメント型データベース）を使用することができる
- 具体化されたビューを読み取りデータストアに格納することで、クエリ時の複雑な結合を回避することができる
- データの読み込みや書き込みに対するアクセス制限の設計が容易になりセキュリティを上げることができる

### DTO

- データ転送オブジェクトのことで、UI(プレゼンテーション)層にドメインオブジェクトを渡すために差し替えられたデータのこと
- 差し替えることで直接ドメインオブジェクトを公開しなくて済む、それにより不要なメソッドやプロパティを呼べなくすることができ、意図しないバグを防ぐことができる


### 参考

[Domain Driven Design（ドメイン駆動設計） Quickly 日本語版
](https://www.infoq.com/jp/minibooks/domain-driven-design-quickly/)


## 課題2

### 境界づけられたコンテキストの実例

販売チームと仕入れチームでは「商品」を意味するものが異なり、販売チームだと売るものとして扱い、仕入れチームだと仕入れるものとして扱う。そのため商品の属性が異なってしまう。<br>
- 販売チームの考える「商品」<br>
商品名、価格、在庫数、割引率など

- 仕入れチームの考える「商品」<br>
商品名、原価、仕入れ先など

### 「Human」エンティティと値オブジェクト

[TS playground](https://www.typescriptlang.org/play?#code/MYGwhgzhAEASCuBbMA7aBvAUNH0AWSqAkgCYBc0KSARgKYBOA3NrtSAPbskAqAngA60KEAC70AligDmzXNGrj6IvCTC8KAETAjas3CjCIh0UROnMWOYOxSn4wEe3oAKAshSkKVRHXoAaeQ4uPkEKACEgngFaAIUlFTVwxWVVXgCDIwoEdwA5Q1oASgxLXGVxCAA6N2ISaABefEIPEj05Msq2TijBesCukNoKgDcwEHhdEpx2iriUtV7ZhN5h0fHW0rxyiozaXp2VsYm5AF9MU8xQSBhs1DyjYrl+CRGdaHpaMBIbEF5oAH0RodhGJJDIStZbGJ7I4XIDxsCzFIilg5HJxAAzaDOOGDEC0aTKaAAPgaACYAAzIyaoqZ4ejsADulFoTIAovR6S4AOSAWBVALJKgHsGCmAcNNAOragCpzQABdoBzBkAtFGALO1AOoMgDMGQDyDIADBkAqgyAEQZAEAMXIK6xO1NpWwBq12DRx63OciktBE0BxzmRbwd8HoaGm5sOjGgp3Olyg0DCySWD1wT3EL1270+31+Pvh0C0OnWELsDic2Itmm0hQjNIxWPtIgAgvac4cigAeaAUqk0mnKelMlAs6DsznOLkUwDO1oBTuUAUHKAOwZAPiugBc9QAQ5oBT00ASQyAbzdAEzJKo1Ov1hpN-q33pxvWtJVtuFLTotLowbpEHq9m0qSd02-O6PgKAc4hs0FLFdozkWqTzOiNk2GaOo4qR7B2qY-puTbQCB0AkBi6LcOImSUDQDC9GBagVKWKFGOeAC08hhqkuEOvh0FbvBYD2r0ACy2h4BU6JBC4iHoshqG7AA9FiACM5JCdAABU0AAGzkqJElSWJpIACzSQAzOJACsBQwU27xXp60C0bQZyYJgIjRCGkQDAAMuUjoNNAABEYB2dAAA+9nUE5rkOe5Ln2ewdkWEGMARP0pkopGzz5m68YoD8-w4uE5nRFZogWHIIH0NC2bxWZIWCMlIhAc2t4VPe+4WjaRl2g6p6HOe6CXte0C7uVj5GXijrVCgdyWsyTI3F1+TOHZIhgPSdmbhm7B4hUHBSK4TTdZu7UkfE4ENO2TKhqtajOBtKb5j2FLkqShH8SdCkGhNNgQFNuLsHNf5qEt1WdMEpnrR2wVvYIQ2OVdti3TN92-olgibpgy2dRBfVNM4-GxKDMQrXMaSNLk+QFBc12A7N83uJuQA)


## 課題3

- Q1: 軽量DDDとはなんでしょうか？
- Q2: DDDにおいてファクトリとはなんでしょうか？
- Q3: UserIDをUUIDで生成する処理をファクトリで表現してみてください。


### Answer

[軽量DDD](https://qiita.com/syu0325/items/600422a2aa1816641c92)
[ファクトリ](https://codezine.jp/article/detail/10903)