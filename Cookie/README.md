# クッキーを理解する

## 課題1

### Cookieとは？

クライアントからサーバにHTTPリクエストを送ると、サーバからCookie情報がSet-Cookieヘッダを使ってレスポンスされる。Cookie情報はブラウザに保存され、同じサーバに対して行われるリクエストと共にHTTPのCookieヘッダの中で送信される。

#### 参考

https://developer.mozilla.org/ja/docs/Web/HTTP/Cookies

### 質問

1. 送信されない
  ブラウザはCookieの同一オリジンからのリクエストに対してのみCookieを送るため。この例ではホストが異なるため同一オリジンと見なされず送信されない

1. 送信されない
   ポートが異なる場合、ブラウザは同一オリジンとして区別しないため

1. 送信されない
   CookieにDomain属性を設定しない場合、ブラウザは規定でサブドメインを除外するため

1. 送信される
   CookieにDomain属性を設定した場合は制限が緩和され、サブドメインも含まれるため

1. JSからCookie値の取得を防ぐことは可能
   CookieにHttpOnly属性を設定する

1. HTTPSの時だけ送ることは可能
   CookieにSecure属性を設定する

1. Expireを設定すると、Expires属性で指定された時刻を経過した後にCookieが削除される。これを持続的Cookieといい、設定しない場合はセッションCookieといい、セッションが終了すると削除される

1. SameSite属性とは？
   サーバがサイト間リクエストと一緒にCookieを送るべきでないことを要求できる。Strict, Lax, Noneの3つが設定できる。Strictの場合はブラウザーはCookieの元サイトからのリクエストに対してのみCookieを送る。LaxもStrictと同様だが、別サイトからCookieの元サイトに移動した際に、ブラウザからCookieを送ることを許可する。Noneの場合は制御しないがSecure属性が必要。設定しない場合はLaxとなる。

1. Cookieに格納しないほうがいい情報は？
   - 個人識別情報
   - パスワード
   - クレジットカード情報

1. Cookieとローカルストレージ
   - Cookie
    SessionIDなどサーバと共有する情報を保持したい時
   - ローカルストレージ
    未ログイン時のカート追加情報などブラウザだけで完結する情報を保持したい時

1. XSSの仕組みと対策
   - 仕組み
    攻撃者がCookie情報を送信するスクリプトを含んだリンクを掲示板に投稿する
    利用者がそのリンクをクリックすると、ブラウザ上でスクリプトが動き、利用者のCookieが攻撃者に盗まれてしまう
    
   - 対策
    HttpOnly属性をつけてJSからアクセスさせない
    HTTPレスポンスヘッダのContent-Typeフィールドに文字コード（charset）を指定する
    ウェブページの本文やHTMLタグの属性値等に相当する出力要素にエスケープ処理を行う



#### 参考

https://www.ipa.go.jp/security/vuln/websecurity/cross-site-scripting.html

https://envader.plus/article/13


## 課題2


1. 同一オリジンポリシーはフォームのPOSTリクエストに適用されますか？
https://zenn.dev/dove/articles/3dc0b8603db3fd
2. CSRFについて説明してください
https://zenn.dev/dove/articles/3dc0b8603db3fd
https://developer.mozilla.org/ja/docs/Web/Security/Types_of_attacks#%E3%82%AF%E3%83%AD%E3%82%B9%E3%82%B5%E3%82%A4%E3%83%88%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%83%95%E3%82%A9%E3%83%BC%E3%82%B8%E3%82%A7%E3%83%AA%E3%83%BC_csrf
3. サイトがCookieを使用することをユーザーに通知している場合があります。これはなぜでしょうか？
https://developer.mozilla.org/ja/docs/Web/HTTP/Cookies#%E9%96%A2%E9%80%A3%E6%83%85%E5%A0%B1