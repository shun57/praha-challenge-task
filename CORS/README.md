# CORSについて理解する

## 課題1（質問）

### CORSとは？

CORS（Cross-Origin Resource Sharing）は、HTTPヘッダーを使用して、異なるオリジンからのアクセスを許可または制御するための仕組みです。これにより、ウェブアプリケーションが特定のオリジン（スキーム、ホスト、ポート番号）からのリクエストを受け入れるか、拒否することが可能となります。CORSは、サーバーが「access-control-allow-origin」というHTTPヘッダーを使用して、許可するオリジンを指定することによって動作します。ブラウザは、HTTPリクエストメソッドが一部の副作用を伴う場合、事前にOPTIONSメソッドを使用して「preflight request」を送信し、サーバーの許可を確認した後、実際のリクエストを送信します。ただし、一部のリクエストはpreflightが不要で、「simple request」として処理されます。

#### 参考

https://developer.mozilla.org/ja/docs/Web/HTTP/CORS


### Access-Control-Allow-Origin: *の危険性

例えばAPIサーバの場合、機密情報や個人情報を取得するAPIがあるとする。オリジンを全て許容している場合、パスがわかればリクエストができてしまう。もし認証が必要だとしても認証が突破された場合にリクエストができてしまう。特定のオリジンのみに制限していれば認証がバレてもAPIリクエストができない。

### simple requestの条件

- HTTPメソッドがGET,HEAD,POSTであること
- ユーザーエージェントによって自動的に設定されたヘッダーであるか、手動の場合は、Accept、Accept-Language、Content-Language、Content-Type（追加条件あり）、Range 
- Content-Typeヘッダーが、application/x-www-form-urlencoded、multipart/form-data、text/plain
- リクエストにReadableStreamオブジェクトが使用されていないこと
- XMLHttpRequestの場合、 XMLHttpRequest.upload プロパティから返されるオブジェクトにイベントリスナーが登録されていないこと

###  シンプルなリクエストでAccess-Control-Allow-Originヘッダーに、リクエスト送信元のオリジンが含まれない場合

- ブラウザはクロスオリジンのアクセスを拒否し、コンソールにCORSエラーが表示される


### HTMLのaタグを辿って異なるオリジンに移動する際は、特にCORS制約は発生しません。なぜでしょうか？

- 異なるサーバへのリクエストが元オリジンではなく、異なるオリジンからのリクエストになり、同一オリジンとなるため。


### XMLHttpRequestを使ってクロスオリジンリクエストを発行する際、デフォルトの挙動だとリクエストにクッキーが含まれません。クッキー情報を含むためには、何をする必要があるでしょうか？

- XMLHttpRequest.withCredentialsをtrueとする


## 課題2（クイズ）

1. CORSエラーはブロックされたことはわかりますが、何が失敗したのか理由は表示されません。ブラウザのコンソール上で確認する方法はありますか？

A. Firefoxの場合コンソールにreasonが表示される
https://developer.mozilla.org/ja/docs/Web/HTTP/CORS/Errors#cors_のエラーメッセージ

1. access-control-allow-originはnullにすれば安全ですか？

A.安全ではない
データスキームやファイルスキームでnullになっていることがあり、許容されてしまう
https://www.securify.jp/blog/cross-origin-resource-sharing/#null

1. クロスドメインなデータを取得する方法としてJSONPという手段あります。なぜこちらは使われなくなったのでしょうか？

A. 扱う上での注意点として、CSRFの脆弱性に注意が必要である。src属性に設定するエンドポイントは外部に公開されているため、悪意のあるサイトがデータを取得するといったことが可能であることから、機密情報や個人情報などのデータを取り扱うには不向きである。またオリジンにおいてもリモートサイトから任意の内容のデータをページに差し込むことが可能であるため、JavaScriptインジェクションに対する脆弱性がある場合は、注意が必要である。そのためデータを提供するサーバ側では、リクエストの正当性を検証する必要がある。
いまではクロスオリジンでXHR（XMLHttpRequest – JavaScriptなどのウェブブラウザ搭載のスクリプト言語でサーバとのHTTP通信を行うためのAPI）を行うことができる環境が普及したことでJSONPはバッドパターン（相手側のオリジンに悪意があればなんでもできてしまう）として使用されることがなくなった。
https://isaxxx.com/archives/2173/


## 課題3

https://github.com/shun57/praha-express-cors


## 課題4

- CORS制約は適用されない
- CORSは異なるオリジンで実行されているブラウザ・サーバ間の機能のため、curlには適用されない