# よく使うHTTPヘッダを理解する

## 課題1

### Host

リクエスト先サーバーのドメイン名およびサーバーが待ち受けているTCPポート番号を指定する(省略可能)。

### Content-type

リソースのメディア種別を示すために使用する。
リクエスト時には、クライアントがサーバに送ったMIMEタイプと文字エンコーディングの種類を伝える。
レスポンス時には、クライアントに返されたMIMEタイプと文字エンコーディングの種類を伝える。

### User-agent

リクエスト時にクライアントの情報をサーバーに伝えるためのもの。ブラウザの種類やバージョン、デバイス、OS、クローラーなどの情報を持つ。

### Accept

クライアントが受け入れ可能なMIMEタイプをサーバーに通知する。

### Referer

リクエストヘッダー。現在リクエストされているページへリンクされていた前のWebページのアドレスを持つ。

### Accept-Encoding

クライアントが受け入れ可能なエンコードアルゴリズム(コンテンツの圧縮方式)をサーバーに通知する。

### Authorization

リクエストヘッダー。ユーザーエージェントがサーバーから認証を受けるための資格情報を保持する。例えばBasicやBearerなどの認証方式がある。

### Location

レスポンスヘッダーでリダイレクト先のURLをクライアントに示す。3xxまたは201のときのみ意味をなす。

### Refererについて

- aタグにtarget="_blank"を設定したところ、先輩エンジニアから「ちゃんとrel=noreferrerを設定した？」と聞かれました。なぜそのような設定が必要なのでしょうか？

refererヘッダーに元のWEBページのアドレスが含まれることで、情報の盗用や機密情報の漏洩などセキュリティリスクがあるため。

https://developer.mozilla.org/ja/docs/Web/Security/Referer_header:_privacy_and_security_concerns

https://www.mizdra.net/entry/2020/10/28/234533

- rel=noreferrerを設定しなかった場合に起きうる問題を調べて、説明して下さい

例えば、フッターにソーシャルメディアへのリンクがある「パスワードリセット」ページを想像してみてください。リンクをクリックすると、情報を共有する方法によっては、ソーシャルメディアサイトがパスワードをリセットする URL を受け取り、共有された情報が使用されると、ユーザーのセキュリティを侵害する恐れがあります。
同じ論理で、サードパーティ側でホストされている画像がページに埋め込まれている場合、機密情報がサードパーティに漏洩する可能性があります。たとえセキュリティが損なわれていなくても、その情報はユーザーが共有してほしくないものかもしれません。


- 先輩エンジニアに「同じオリジンの時はrefererの情報を全部送って、別オリジンの時は、オリジン情報だけをrefererとして送信するように、HTTPヘッダを追加しておいてもらえる？」と頼まれました。HTTPヘッダーには、どんな値を追加する必要があるでしょうか？

Referrer-Policy ヘッダにsame-originを指定する



課題２（クイズ）
* HTTPヘッダーに関するクイズを3問、作成してください

①ユーザーエージェントを用いてモバイルかタブレットかパソコンかを判定する方法を教えてください。
https://developer.mozilla.org/ja/docs/Web/HTTP/Browser_detection_using_the_user_agent


②クリックジャッキングを防ぐために使用されるヘッダーはなんですか？

③キャッシュが有効であることを判定するヘッダーはなんですか？また、キャッシュについてセキュリティ的に気をつけるべきことを教えてください。


課題３（クイズ）
* 様々なHTTPメソッドがありますが（GET/POST/PUT/PATCH/FETCHなど）、実現したいユースケースに適したメソッドを選択するのは意外と（特に更新系）大変です。例えば以下のケースを考えてみてください：
* Twitterのフォロー関係の破棄はPUT?PATCH?DELETE?
* 取引の取り消しはPUT?PATCH?DELETE?
* お気に入りリストからの削除はPUT?PATCH?DELETE?
* どこまでHTTPメソッドを本来の定義に沿って使うべきか、ペアと話し合ってみてください。参考としてSlackやTwitterなど有名サービスのAPIのドキュメントを読んでみると良いかもしれません！

- すべてDELETE

TwitterはPUT、PATCHはほとんど使ってない
Slackも同様、削除さえPOSTにしている

◾️参考

- Slack

https://api.slack.com/methods?filter=chat


- Googleフォト

https://developers.google.com/photos/library/reference/rest?hl=ja

- Twitter 

https://developer.twitter.com/en/docs/api-reference-index


- 冪等性

https://qiita.com/sfp_waterwalker/items/765abc2b53cc11d5e367

- Microsoft

https://learn.microsoft.com/ja-jp/azure/architecture/best-practices/api-design

https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md

- Zen

https://zenn.dev/yu1ro/articles/4c73274383b676