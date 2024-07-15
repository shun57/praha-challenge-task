# ログの取り方を学ぼう

## 課題1

### ログレベルとは？

ログメッセージの種類を示すための基準のこと
FATAL,ERROR,WARN,INFO,DEBUGなどのレベルがある

- メリット

レベルによって対応ルールを決めておくことで、対応・判断がしやすくなる。
例えばERROR以上はSlackに通知する、FATALならすぐに調査が必要など。

### アプリケーションログにはどのような情報を含めるべき?

いつ、どこで、誰が、何を
ex. レベル、時間、リクエスト対象、ユーザー情報、処理場所、処理結果、メッセージ

- 含めない方がいい情報は？

漏れてしまったらマズイ情報、例えば個人情報やパスワード、クレジット情報など。

### どのようなタイミングでログを出力すると良い?

- INFO: 認証の成功と失敗、決済など重要な処理の実行、バッチの開始・完了・終了、検証の失敗
- ERROR: 例外発生時

参考：https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Logging_Cheat_Sheet.md


### どのようなログメッセージならパースしやすくなる?

- 出力内容を一定にし、出力順番を揃える
- 出力内容ごとに区切る

### ログの種類

- アクセスログ
Webサーバーに送信されるリクエスト情報のログ。
ユーザーの行動解析や、不正アクセスの監視に利用される。

- アプリケーションログ
アプリケーション内で発生したイベントのログ。
プログラムによって実行されるイベント、エラー、およびアクティビティを記録する
開発者、システム管理者がトラブルシューティングや監視するのに役立つ

- エラーログ
アプリケーション、OS、サーバーの実行中に発生するエラーを追跡するログ

- （フロントエンドの）ユーザーログ
ブラウザ側で発生したイベントのログ
異なるデバイスやブラウザの問題を発見できる

- データベースのクエリログ
接続・接続解除の情報、およびクライアントから実行された全ての SQL クエリを出力してくれるログです。 SQL 実行エラーが発生した際に、どのような SQL が実行されたのかを正確に把握するのに役に立ちます。

### ログローテーションとは

ログファイルが一定のファイルサイズに達したり、一定の期間が経過したらファイル名を変更しログファイルを切り分け、古くなったログファイルは消去すること

- メリット
ログファイルの肥大化を防ぐ

- デメリット
ログを取得するのにサーバに入る必要性
ファイルで見ると、加工しないと必要なログを見つけづらい
サーバが分散しているとログを集約しづらい

- 使われる頻度が減っている？
クラウドの利用が増えてきており、クラウド側で管理できることが多いため


### サービスが稼働するインスタンスにログファイルを置くのを避ける理由は？

- セキュリティリスク
サーバーに侵入された場合にログを盗まれる可能性
権限を細かく設定するのが大変

- サーバーリソースを消費してしまう
大量のログを長期間保存するときに問題になる

- 管理の煩雑さ
サーバーが複数台ある場合に、それぞれログを集約する必要がある
サーバーが落ちた場合に過去のログが見れなくなってしまう

### プル型とプッシュ型

- プル型

監視サーバ上に監視対象についての設定を行い、監視対象からデータを集めてくる
監視対象一覧を知っているため、データを取得出来なかった時に異常に気づくことができる
Zabbixなど

- プッシュ型

監視対象となるホストにエージェントをインストールし、各ホストのエージェントが監視サーバに対してデータを送信する
監視対象を増やす場合は エージェントをインストールするだけで簡易
ファイアウォールなどで外部からのアクセスが制限されたネットワークの場合でも、簡単に導入が可能
Saasやクラウド


## 課題2

- 秘匿情報がマスクされずにそのまま出力されてしまう可能性
- データが膨大な場合にも出力されてしまう
- 悪意のある入力がそのまま出力されてしまう