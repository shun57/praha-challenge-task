# DBを代替してみよう

## 課題1

- Airtable
https://airtable.com/appbj3GoxUqHmTRXT/tblPbWoqGlXPuYc57/viw7wYOelvc6D8VFY

### AirtableのAPI

- 記事を作成する

```
curl -X POST https://api.airtable.com/v0/appbj3GoxUqHmTRXT/%E8%A8%98%E4%BA%8B%E4%B8%80%E8%A6%A7 \
  -H "Authorization: Bearer Token" \
  -H "Content-Type: application/json" \
  --data '{
  "records": [
    {
      "fields": {
        "記事名": "テスト記事",
        "記事URL": "https://example.com",
        "説明": "テストようです",
        "既読済": false
      }
    }
  ],
  "typecast": true
}'
```

- 記事一覧を取得する

```
curl "https://api.airtable.com/v0/appbj3GoxUqHmTRXT/%E8%A8%98%E4%BA%8B%E4%B8%80%E8%A6%A7?maxRecords=3&view=Grid%20view" \
  -H "Authorization: Bearer Token"
```

### 実装

https://github.com/shun57/replace-db-praha/pull/1


#### APIドキュメント

https://airtable.com/appbj3GoxUqHmTRXT/api/docs

- ライブラリ
https://github.com/Airtable/airtable.js