# OAuth2.0を図解してみよう

## 課題1

### 認証と認可

- 認証

ユーザーやデバイスが本物かどうかを検証するプロセスのこと。
例えばユーザーIDとパスワードや生体情報など。


- 認可

認証後に、どのユーザーやデバイスがアクセスできるか、どのアクションを実行できるか（アクセス権限）を検証するプロセスのこと。
システムで設定したロールなど。

### OAuth2.0は認証の仕組みと呼ぶとNG?

- 「OAuth2.0」は認可の仕組み、ユーザーのリソースに対する制限付きアクセスを第三者アプリケーションに許可することを目的とする
ユーザーの身元を確認するためではなく、アプリケーション間でリソースへのアクセスを共有するために設計された。
トークンにはユーザーの身元を特定するために十分な情報が含まれていない。
認証が必要な場合は「OpenID Connect」などと一緒に使う。

#### 参考

https://auth0.com/jp/intro-to-iam/what-is-oauth-2

### OAuth2.0

#### Authorization grant type

grant typeとはアプリケーションがアクセス トークンを取得する方法を指す。

https://oauth.net/2/grant-types/

|grant type|違い|メリット|デメリット|
| ---- | ---- | ---- | ---- |
| Authorization Code | 認可エンドポイントに認可リクエストを行い、レスポンスとして認可コードを受け取り、トークンエンドポイントでその認可コードとアクセストークンを交換する | セキュリティが高い | 実装が複雑でユーザの手間も多い |
| Client Credentials | トークンエンドポイントにトークンリクエストを行い、レスポンスとしてアクセストークンを受け取る | ユーザ介入が不要なためシンプル | 人が関与しないプロセスに限定される |
| Device Code | ブラウザーレスデバイスまたは入力制限のあるデバイスが以前取得したデバイスコードをアクセストークンと交換する | ユーザが別デバイスで簡単に認証できる | 複数のデバイスが必要 |
| Refresh Token | 事前に発行を受けていたリフレッシュトークンをトークンエンドポイントに提示することにより、アクセストークンを再発行する | アクセストークンと組み合わせて長期的なアクセスが可能なためUX向上 | 適切に管理しないとセキュリティリスク |


https://qiita.com/ist-n-m/items/992c67b803ff460818ec

#### 参考

https://qiita.com/KWS_0901/items/bb2c1dae9dcb66a3c6f3


#### OAuth2.0の図解

[OAuth2.0](./oauth.md)


### Twitter

https://developer.x.com/en/docs/authentication/overview

#### OAuth1.0a

認証されたTwitter開発者アプリがプライベートアカウント情報にアクセスしたり、Twitterアカウントに代わってTwitterのアクションを実行したりできます。
生成されたいくつかのキーとトークンを認証ヘッダーで渡して、各APIリクエストに署名する

- OAuth1.0aはユーザーに変わって実行できる

#### OAuth2.0 Bearer(App Only)

OAuth 2.0ベアラートークンは、開発者アプリに代わってリクエストを認証します。この方法はアプリ特有のものであるため、ユーザーはまったく関与しません。通常、このメソッドは、公開情報への読み取り専用のアクセスを必要とする開発者向けです。 

ベアラートークンは、POST oauth2/tokenエンドポイントにコンシューマーキーとシークレットを渡すことによって生成できる。
ベアラートークンの取り消しも可能。

- Oauth1.0はユーザーとして書き込みも許可されるが、Oauth2.0はアプリとしての読み込みのみしかできない。

#### OAuth 2.0 Authorization Code Flow with PKCE

アプリケーションのスコープと複数のデバイスにわたる承認フローをより細かく制御しながら、別のアカウントに代わって認証を行うことができる。
フローとしてはOAuth1.0aと同じ。PKCEを使用した認証コードとリフレッシュトークンのみを提供している。

- Twitter API v2 でのみ使用できる。
- App Onlyに比べ、ユーザーに変わって実行もできる。
- OAuth1.0aに比べ、より細かく定義されたスコープを使用して、アプリケーションが要求できる権限を詳細に制御できる。

#### Basic認証

基本認証を必要とするAPIへのリクエストを正常に完了するには、各リクエストの認証ヘッダーとして有効なメールアドレスとパスワードの組み合わせを渡す。HTTPSを介したエンコードされた認証情報を含むHTTPヘッダー Authentication: Basic を追加してください。

- 基本認証は会社の管理アクセスレベル内でのみ利用可能な、商用向けAPIを実行する時に使われる

### OpenID Connect図解

[OpenID Connect](./openID.md)

#### IDトークン

- 「ヘッダー.ペイロード.署名」の形式
- base64urlでエンコードされている（デコードできる）
```
例）
eyJraWQiOiIxZTlnZGs3IiwiYWxnIjoiUlMyNTYifQ.ewogImlz
cyI6ICJodHRwOi8vc2VydmVyLmV4YW1wbGUuY29tIiwKICJzdWIiOiAiMjQ4
Mjg5NzYxMDAxIiwKICJhdWQiOiAiczZCaGRSa3F0MyIsCiAibm9uY2UiOiAi
bi0wUzZfV3pBMk1qIiwKICJleHAiOiAxMzExMjgxOTcwLAogImlhdCI6IDEz
MTEyODA5NzAsCiAibmFtZSI6ICJKYW5lIERvZSIsCiAiZ2l2ZW5fbmFtZSI6
ICJKYW5lIiwKICJmYW1pbHlfbmFtZSI6ICJEb2UiLAogImdlbmRlciI6ICJm
ZW1hbGUiLAogImJpcnRoZGF0ZSI6ICIwMDAwLTEwLTMxIiwKICJlbWFpbCI6
ICJqYW5lZG9lQGV4YW1wbGUuY29tIiwKICJwaWN0dXJlIjogImh0dHA6Ly9l
eGFtcGxlLmNvbS9qYW5lZG9lL21lLmpwZyIKfQ.rHQjEmBqn9Jre0OLykYNn
spA10Qql2rvx4FsD00jwlB0Sym4NzpgvPKsDjn_wMkHxcp6CilPcoKrWHcip
R2iAjzLvDNAReF97zoJqq880ZD1bwY82JDauCXELVR9O6_B0w3K-E7yM2mac
AAgNCUwtik6SjoSUZRcf-O5lygIyLENx882p6MtmwaL1hd6qn5RZOQ0TLrOY
u0532g9Exxcm-ChymrB4xLykpDj3lUivJt63eEGGN6DH5K6o33TcxkIjNrCD
4XB1CKKumZvCedgHHF3IAK4dVEDSUoGlH9z4pP_eWYNXvqQOjGs-rDaQzUHl
6cQQWNiDpWOl_lxXjQEvQ

// デコード例
{
 "iss": "http://server.example.com",
 "sub": "248289761001",
 "aud": "s6BhdRkqt3",
 "nonce": "n-0S6_WzA2Mj",
 "exp": 1311281970,
 "iat": 1311280970,
 "name": "Jane Doe",
 "given_name": "Jane",
 "family_name": "Doe",
 "gender": "female",
 "birthdate": "0000-10-31",
 "email": "janedoe@example.com",
 "picture": "http://example.com/janedoe/me.jpg"
}
```


#### OAuth2.0と比較したメリット

- ユーザーの認証ができる
- ユーザー情報を取得できる
- 複数サービスのシングルサインオン(SSO)をサポートしている


## 課題2

1. PKCEとはなんのための仕組みでしょうか？

A. 認可コード横取り攻撃を対策するためのOAuth2.0の拡張仕様
https://qiita.com/ist-n-m/items/992c67b803ff460818ec


2. IDトークンのエンコード形式はなんでしょうか？

A. ユーザー情報を含むJSON Web Token(JWT)

https://developers.line.biz/ja/docs/line-login/verify-id-token/#get-an-id-token

3. IDトークンのユーザー情報はJWTのどこに含まれる？

A. ペイロード部分



## 参考

[Auth0 を使って ID Token と Access Token の違いをざっくり理解する](https://dev.classmethod.jp/articles/auth0-access-token-id-token-difference/)