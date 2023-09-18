# curlとpostmanに慣れる

https://httpbin.org/#/HTTP_Methods/get_get

## 課題1

```
$ curl -H "X-Test:hello" https://httpbin.org/headers
```

## 課題2

```
$ curl -H "Content-Type: application/json" -d '{"name":"hoge"}' https://httpbin.org/post
```

## 課題3

```
$ curl -H "Content-Type: application/json" -d '{"userA":{"name":"hoge"}}' https://httpbin.org/post
```

## 課題4

```
$ curl -H "Content-Type: application/x-www-form-urlencoded" -d "name=hoge" https://httpbin.org/post
```

## postman

[postman課題](Praha.postman_collection.json)

## クイズ

1. headersに付与されている"X-Amzn-Trace-Id"とは何でしょうか？
1. Postmanは有料ですか？また、Postmanのようなツールを1つ挙げてください（拡張機能でも可）
1. x-www-form-urlencodedはPOSTで送る際、どのような時に必要でしょうか？

## 回答

1. https://repost.aws/ja/knowledge-center/trace-elb-x-amzn-trace-id
1. https://zenn.dev/ctrlkeykoyubi/articles/vscode-thunderclient
1. https://redj.hatenablog.com/entry/2022/08/06/011409