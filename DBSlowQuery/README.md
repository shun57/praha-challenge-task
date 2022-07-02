# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recdAAMiL9UsSObbS?blocks=hide)

## 課題1

- スロークエリログを有効

```
SET GLOBAL slow_query_log = 'ON';
SHOW GLOBAL VARIABLES LIKE '%slow_query%';
```

- 0.1秒以上のログを記録する

```
SET GLOBAL long_query_time = 0.1;
SHOW GLOBAL VARIABLES LIKE '%query_time%';
```

- 0.1秒以下のクエリ

```
1. SELECT * FROM employees.employees WHERE last_name = 'Preusig';

2. SELECT * FROM employees.titles WHERE title = 'Engineer';

3. SELECT * FROM employees.salaries WHERE emp_no = 10001;
```

- 0.1秒以上のクエリ

<pre>
1. 
# Time: 2022-02-26T03:51:23.710686Z
# Query_time: 0.706280  Lock_time: 0.000184 Rows_sent: 41  Rows_examined: 2844050
use employees;
SET timestamp=1645847483;
SELECT * FROM employees.salaries WHERE salary = 74333;
</pre>

<pre>
2. 
# Time: 2022-02-26T03:54:19.149466Z
# Query_time: 1.529822  Lock_time: 0.000103 Rows_sent: 257784  Rows_examined: 2844050
SET timestamp=1645847659;
SELECT * FROM employees.salaries WHERE from_date > '2000-01-01' AND to_date < '2001-12-31';
</pre>

<pre>
3. 
# Time: 2022-02-26T03:56:15.183705Z
# Query_time: 0.237190  Lock_time: 0.000163 Rows_sent: 65941  Rows_examined: 300024
SET timestamp=1645847775;
SELECT * FROM employees.employees WHERE hire_date > '1991-01-01' AND gender = 'M';
</pre>


## 課題2

1. 最も頻度が高い

```
# mysqldumpslow -s c -t 1 /var/lib/mysql/205fe43bc776-slow.log

Reading mysql slow query log from /var/lib/mysql/205fe43bc776-slow.log
Count: 2  Time=0.22s (0s)  Lock=0.00s (0s)  Rows=54777.0 (109554), root[root]@[172.17.0.1]
  SELECT * FROM employees.employees WHERE hire_date > 'S' AND gender = 'S'
```

2. 実行時間が最も長い

```
# mysqldumpslow -s t -t 1 /var/lib/mysql/205fe43bc776-slow.log

Count: 1  Time=4.65s (4s)  Lock=0.00s (0s)  Rows=234270.0 (234270), root[root]@[172.17.0.1]
  SELECT E.first_name, E.last_name FROM employees.employees AS E INNER JOIN employees.salaries AS S ON E.emp_no = S.emp_no WHERE S.salary > N
```

3. ロック時間が最も長い

```
# mysqldumpslow -s l -t 1 /var/lib/mysql/205fe43bc776-slow.log

Reading mysql slow query log from /var/lib/mysql/205fe43bc776-slow.log
Count: 1  Time=2.08s (2s)  Lock=0.00s (0s)  Rows=1.0 (1), root[root]@[172.17.0.1]
  SELECT SUM(salary) FROM employees.salaries where (DATE_FORMAT(from_date, 'S') = 'S')
```

## 課題3

1. 高速化できず
2. salaryにindexを貼って高速化(4.65s => 0.9s)

## 課題4

- 新人A

LIMIT句はSQLの実行順序の中で一番最後のため、レコードの絞り込みも最後に実行される。そのため、その前の絞り込みに時間がかかっている場合、LIMIT句だけでは処理時間の改善ができない。

- 新人B

・内部結合の場合は、ONでもWHEREは同じ。  
・外部結合の場合、ONの場合は条件に合致しないデータも取得する。WHEREの場合は、外部結合した結果に対して条件を指定するため、合致しないデータは除外される。

## 課題5

- オフセット・ページネーション

```
select * from users order by `id` asc limit 20 offset 20;
```

- カーソル・ページネーション

```
select * from users where `id` > 20 order by `id` asc limit 20;
```

### メリット
 
1. オフセットの場合、スキップデータを全てスキャンしてしまうが、カーソルの場合はスキップされるため、大規模データの際にパフォーマンスが良い。※インデックスが貼られている場合
2. オフセットの場合、対象に書き込みが頻繁に行われた時、ページの表示前に前ページにデータが追加されると重複データが表示されたり、前ページのデータが削除されたら不足表示されたりしてしまうが、カーソルの場合は発生しない。


### デメリット

1. ページ番号の表示ができない。(前、次が可能) ※オフセットは可能
2. order byで利用するカラムにインデックスを貼る必要がある
3. where条件に利用されるカラムがユニークである必要がある。

使い所：無限スクロールなど

## 課題6

1. 課題で紹介されている以外の「ログ集計ツール」を挙げること！
2. スロークエリログで出力されるQuery_time、Lock_time、Rows_sent、Rows_examinedの意味を説明すること！
3. スロークエリログで出力されるExtraの項目を説明すること！


## 参照

[スロークエリの確認方法：MySQL編](https://ptune.jp/tech/how-to-check-mysql-slow-query/)

[MySQLのスロークエリログをmysqldumpslowで分析する](https://webmake.info/mysql%E3%81%AE%E3%82%B9%E3%83%AD%E3%83%BC%E3%82%AF%E3%82%A8%E3%83%AA%E3%83%AD%E3%82%B0%E3%82%92mysqldumpslow%E3%81%A7%E5%88%86%E6%9E%90%E3%81%99%E3%82%8B/)

[オフセット・ページネーションとカーソル・ページネーションの比較](https://note.com/tomo_program/n/nbb010ff6eede)