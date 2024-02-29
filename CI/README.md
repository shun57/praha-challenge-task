# CI環境を整備してみよう

## 課題1

https://github.com/shun57/praha-challenge-ddd/pull/19

## 課題2

https://github.com/shun57/praha-challenge-ddd/pull/20

## 課題3

### ビルド時間の短縮

- 依存関係をキャッシュする

https://docs.github.com/ja/actions/using-workflows/caching-dependencies-to-speed-up-workflows

### Github外のイベントをフックにする方法

repository_dispatchというWebhookイベントをトリガーさせることができる

```
// cURLサンプル
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/OWNER/REPO/dispatches \
  -d '{"event_type":"on-demand-test","client_payload":{"unit":false,"integration":true}}'
```

https://docs.github.com/ja/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-dispatch-event

### 特定のディレクトリ配下のみ適用

- pathフィルターを利用する

```
// 例
on:
  push:
    paths:
      - 'src/**'
```

https://docs.github.com/ja/actions/using-workflows/triggering-a-workflow#using-filters-to-target-specific-paths-for-pull-request-or-push-events

### 特定のjobが他のjobの完了を待ってから実行

- jobs.<job_id>.needsキーワードを利用する

```
// 例
jobs:
  job1:
  job2:
    needs: job1
  job3:
    needs: [job1, job2]
```

https://docs.github.com/ja/actions/using-jobs/using-jobs-in-a-workflow


### 秘匿性の高い環境変数をymlファイルの中で扱う

- Github secretsを使う

```
// 例
env:
  CERTIFICATE_BASE64: ${{ secrets.CERTIFICATE_BASE64 }}
```

https://docs.github.com/ja/actions/security-guides/using-secrets-in-github-actions