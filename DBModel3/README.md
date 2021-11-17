# 課題1
[ダイアグラム](https://dbdiagram.io/d/6194fb0502cf5d186b5ae573)
<iframe width="560" height="315" src='https://dbdiagram.io/embed/6194fb0502cf5d186b5ae573'></iframe>

## テーブル構成概要

|テーブル名|説明|
|:--|:--|
|users|ユーザーマスタ|
|directories|ディレクトリの管理|
|directory_tree|ディレクトリ階層の管理|
|documents|ドキュメントの管理|

## 要望

[要望内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recNz4o0hCUn6ctkA?blocks=hide)

## 要望への対応

1. ドキュメント/ユーザー

- created_user_idやcreated_atを持たせることで登録・更新ユーザーと日時を特定できる（削除は物理削除を想定）
- titleとcontentでテキスト情報を保存できる
- directories_idを持たせることでディレクトリを特定できる

2. ディレクトリ

- ディレクトリ階層無制限・構造変更可能ということから「閉包テーブル」を想定し、directory_treeテーブルを作成

### 検討過程

1. 最初はdirectoriesに親IDを持たせることで実現しようと考えた  
こちらは「隣接リスト」というアンチパターンだった。  
実現はできるが、階層が深くなるとSQL発行数が増えたり、アプリケーション側の制御が煩雑になるらしい。  

2. 文字列データとしてパスを持つ方法  
`path: /usr/local/path/`
こちらは「経路列挙」と呼ばれるものらしい。  
パスの文字数に制限があることや、整合性を担保できないため、使われないらしい。  

3. 閉包テーブル  
階層用のテーブルを作って全ての階層をデータで管理する方法とのこと。  
階層変更やサブディレクトリが無限という今回の要件に対しては一番当てはまりそうなため選択。  

## 参照情報

[ツリー構造のデータをRDBで扱う](https://qiita.com/ftsan/items/d11c47e81508b92426fb)  

[閉包テーブル](https://qiita.com/ymstshinichiro/items/b1825719c4fb274446cc)
