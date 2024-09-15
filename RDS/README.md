# RDSを冗長化してみよう


## 課題1

### マルチAZ

![マルチAZ](マルチAZ.png)

### フェイルオーバー再起動時のアクセス

できない

※なぜか再現できず、、

https://dev.classmethod.jp/articles/how-amazon-aurora-failover-affect-downtime/


### フェイルオーバーでサブネットは変わる？

変わる

- フェイルオーバー前

![フェイルオーバー前](フェイルオーバー前.png)

-フェイルオーバー後

![フェイルオーバー後](フェイルオーバー後.png)