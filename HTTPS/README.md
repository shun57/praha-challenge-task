# HTTPSを理解する

## 課題1

### HTTPS通信とは？

HTTPにSSL/TLSという暗号化プロトコルを組み合わせたセキュアバージョン
- 何を暗号化する？

  WebブラウザとWebサーバ間で送受信されるすべてのデータ

- どのような危険から守る？

  HTTPを介してデータが送信される場合、データはパケットに分割されるが、フリーソフトウェアを使用して簡単に「スニッフィング」できる<br>
  さらにHTTPを介して行われる通信はすべて平文であるため、ツールさえあれば誰でも簡単にアクセスでき、オンパス攻撃に対して脆弱になる<br>
  つまり、盗聴・改ざん・なりすましから守れる

※スニッフィング・・・パケットを盗聴すること<br>
※オンパス攻撃・・・2 つのデバイス (多くの場合、Web ブラウザとWeb サーバー) の間に入り込み、2 つのデバイス間の通信を傍受または変更します。その後、攻撃者は情報を収集したり、2 つのエージェントのいずれかになりすますことができます。これらの攻撃は、Web サイトに加えて、電子メール通信、DNSルックアップ、および公共の WiFi ネットワークをターゲットにすることができます。オンパス攻撃者の典型的なターゲットには、SaaSビジネス、e コマース ビジネス、および金融アプリのユーザーが含まれます

#### 参照

https://www.cloudflare.com/ja-jp/learning/ssl/what-is-https/

### HTTPS図解

[https図解](https.md)

### なぜ証明書の発行元の確認が必要？

発行元が信頼できない認証局の可能性もあるため。
信頼できない認証局の場合、偽造された証明書を使う悪意のあるサイトの可能性もあり、フィッシングなどのリスクがある。

https://www.idcf.jp/rentalserver/user-support/knowledge/security-guide/phishing.html

※証明書には、ドメイン認証、企業認証、EV認証の3種類がある。
- ドメイン認証・・・URLの所有者を検証するだけ
- 企業認証・・・所有者+ビジネス組織の検証
- EV認識・・・所有者+ビジネス組織+関連事業の法的実態の検証

ドメイン認証まではフィッシング詐欺目的のサイトも認証されてしまう。

https://www.digicert.com/jp/difference-between-dv-ov-and-ev-ssl-certificates


### HTTPの接続を禁止するレスポンスヘッダー

strict-transport-securityヘッダー


### HTTPS通信時のみクッキーを送信する

Set-cookieにsecure属性をつける

https://zenn.dev/arsaga/articles/80a75a3d086131


### 遷移先とHTTPS通信が確立できた時のみreferer情報を送る

- ヘッダーにReferrer-Policyを設定する

デフォルト値がstrict-origin-when-cross-origin
オリジン間でプロトコルのセキュリティ水準が同じ場合のみoriginを送信する。

https://developer.mozilla.org/ja/docs/Web/Security/Referer_header:_privacy_and_security_concerns