# 課題

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/recBUUqpEfUtnFCDr?blocks=hide)

## 課題1

### 複合インデックスとは？

テーブルの中で複数のカラムを1つのインデックスとして設定するものです。例えばユーザーテーブルがあったとして、姓カラムと名カラムに対して設定すると複合インデックスとなります。どんな時に使うかというと、データ数が多く片方だけのカラムでは重複するデータが多い場合に使います。例えば、姓名で姓だけにインデックスを貼ると、佐藤で調べた場合、インデックスだけで佐藤が見つかったとしても、結局はテーブルデータも見に行って、特定の佐藤を探す必要が出てしまいますので非効率です。そこで「姓名」合わせてインデックスを貼ると、(姓)佐藤（名）〇〇がインデックスに保持されるため、インデックスだけを見ればデータを特定でき、効率よく検索できます。このように複数カラムを１つのインデックスとすることを複合インデックスと言います。

### どう作り直す？

複合インデックスの場合、先頭に設定したインデックス列からソートされるため、２つ目以降のインデックスのみではインデックスが参照されない。そのため例では、姓だけの検索の場合にインデックスが効かず、フルテーブルスキャン(全件検索)になってしまう。
作り直すには以下のように姓を先頭にして作成する。
```
CREATE INDEX employees_name ON employees (last_name, first_name)
```

## 課題2

1. 雇用日と誕生日を条件
hire_date, birth_dateで複合インデックス
```
SELECT * FROM employees.employees where hire_date = '1989-06-02' AND birth_date = '1953-04-20';
インデックス前：0.160sec
インデックス後：0.0026sec
```

<pre>
'1','SIMPLE','employees',NULL,'ref','index_emp_date','index_emp_date','6','const,const','1','100.00',NULL
</pre>

2. 給料と日付を条件
salary,to_dateで複合インデックス
```
SELECT * FROM employees.salaries where salary > 100000 AND to_date = '9999-01-01';
インデックス前：1.20sec
インデックス後：0.061sec
```
<pre>
'1','SIMPLE','salaries',NULL,'range','index_salary_date','index_salary_date','4',NULL,'182222','10.00','Using where; Using index'
</pre>

3. ユーザー氏名を条件
first_name,last_nameで複合インデックス
```
SELECT * FROM employees.employees where first_name = 'Sudharsan' AND last_name = 'Orlowski';
インデックス前：0.129sec
インデックス後：0.0029sec
```

<pre>
'1','SIMPLE','employees',NULL,'ref','index_full_name','index_full_name','34','const,const','1','100.00',NULL
</pre>

## 課題3(クイズ)
Employeesテーブルへのクエリクイズ

1. 1960年生まれ(birth_date)の従業員を名前(first_name)アルファベット昇順で取得するクエリ
2. 1997年〜2000年の各年に雇用(hire_date)された従業員数を取得するクエリ
3. 1993年以降に雇用(hire_date)された従業員で姓(last_name)が同じ人の数を取得するクエリ

## 参照

[DBのインデックスと複合インデックス](https://qiita.com/towtow/items/4089dad004b7c25985e3)

[複合インデックスの落とし穴](https://www.gatc.jp/gat/it/it02dbindex.html#:~:text=%E8%A4%87%E5%90%88%E3%82%A4%E3%83%B3%E3%83%87%E3%82%AF%E3%82%B9%E3%81%A8%E3%81%AF%E3%80%81%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB,%E3%82%A4%E3%83%B3%E3%83%87%E3%82%AF%E3%82%B9%E3%81%A8%E3%81%99%E3%82%8B%E3%82%82%E3%81%AE%E3%81%A7%E3%81%99%E3%80%82&text=%E5%BE%93%E6%A5%AD%E5%93%A1%E6%95%B0%E3%81%8C%E5%A4%9A%E3%81%8F%E3%80%81%E3%80%8C%E5%A7%93,%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%93%E3%81%A8%E3%82%92%E7%8B%99%E3%81%A3%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99%E3%80%82)