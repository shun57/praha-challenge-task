# サービスのモニタリングを考える

## ツールを探す

- 監視とは？

https://qiita.com/tsurumiii/items/27f22b38215e37518c7c

### 一定期間で一定数以上、フロントエンドのWEBアプリケーションがクラッシュしていたら、開発者にSlackで知らせる

- Sentry
https://zenn.dev/apgun/articles/798661f7eb7c86

Slack連携
https://sentry.io/integrations/slack/

- Rollbar
https://tech.macloud.jp/entry/2021/06/17/190827

- BugSnag

### フロントエンドで何らかのエラーが発生したら、直前までユーザが実施した作業手順、ブラウザの実行環境等の情報を付与して開発者に通知する

- Datadog RUM
https://creators-note.chatwork.com/entry/how-to-use-datadog-rum

※Sentryとかでもできるっぽい

### バックエンドのアプリケーションが（メモリ不足などの理由で）クラッシュしたら、自動的にアプリケーションを再起動しつつ、開発者にSlackで知らせる

- NewRelic
https://devlog.atlas.jp/2017/12/22/1728

- Supervisor
https://zenn.dev/hashito/articles/caa579a9aa8b4f

- monit
https://fisproject.net/2017/07/slack-notification-from-monit/


### APIからのレスポンスタイムが5秒以上かかっているエンドポイントを可視化する。もし5秒以上かかっているレスポンスが全体の1割を超えたら開発者にSlackで知らせる

- Datadog APM
https://qiita.com/KawamotoShuji/items/02a85c4f61ad77310fbd

- AppDynamics
https://docs.appdynamics.com/appd/22.x/22.5/en/end-user-monitoring/synthetic-monitoring/synthetic-api-monitoring

- Site24x7
https://www.site24x7.jp/rest-api-monitoring.html

### データベースのスロークエリを可視化して、レスポンスに5秒以上かかるクエリがある場合は開発者にSlackで知らせる

- AWS Cloud Watch

※DatadogやNewRelicでもできそう

## 監視するメトリクス

- フロントエンドの表示速度
- サーバー負荷：CPU使用率、ディスク使用率
- ネットワーク負荷
- セキュリティ
- キャッシュヒット率
- HTTPエラー
- DBストレージ
