# 課題1
[ダイアグラム](https://dbdiagram.io/d/6198897302cf5d186b5f8986)

## 要望

[要望内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recY3cEohhHTkuv69?blocks=hide)

## 要望への対応

### 投稿
- channel_id(チャンネル), user_id(メンション), message(メッセージ)をpost

### 削除
- channnel_idとmessage_idで特定してdelete

### 周期
- アプリ側で周期タイプと周期を計算し、投稿日時から現在日時を比較して周期とマッチしていたらcronで引っ掛ける  
 cycle_type { 1:hourly, 2:daily, 3:weekly, 4:monthly }   
 cycle { 1:hourly 1~24, 2:daily 1~, 3:weekly 1~7 1:月,2:火~, 4:Monthly 1~31 }  

### 懸念点
- 周期の特定方法がアプリ任せになっている

## 参照情報

[penpen](https://penpen.netlify.app/)

[penpen-Qiita](https://qiita.com/dowanna6/items/b5d1d0245985a26abf8e)  

[slack-api](https://api.slack.com/tutorials)

[slack-bold](https://slack.dev/bolt-python/concepts#web-api)