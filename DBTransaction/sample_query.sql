-----------------------------------------
-- 準備
-----------------------------------------

-- 分離レベルの確認

>SELECT
@@global.transaction_isolation,
@@session.transaction_isolation;

>REPEATABLE-READ

-- 分離レベルをREAD UNCOMMITEDに変更

>SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- ターミナルを2つ用意してそれぞれからMySQLにつなぐ

ターミナル1
>PROMPT mysql1>

ターミナル2
>PROMPT mysql2>

-----------------------------------------
-- Dirty Read(コミット前値を読み取ってしまう)
-----------------------------------------

-- 値を確認
mysql1>SELECT * FROM employees WHERE emp_no = 10001;
emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 

-- トランザクション開始
mysql1>START TRANSACTION;
mysql2>START TRANSACTION;

-- 値を更新
mysql1>UPDATE employees SET first_name="TOMMY" WHERE emp_no = 10001;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- 値を確認
mysql2>SELECT * FROM employees WHERE emp_no = 10001;
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | TOMMY      | Facello   | M      | 1986-06-26 |

-- ロールバック
mysql1>ROLLBACK;
mysql2>ROLLBACK;

-- 値を確認
mysql2>SELECT * FROM employees WHERE emp_no = 10001;
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |

-----------------------------------------
-- Non-repeatable read(他トランザクションの更新で値が変わる)
-----------------------------------------

-- READCOMMITEDに変える
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- トランザクション開始
mysql1>START TRANSACTION;
mysql2>START TRANSACTION;

-- 値を更新
mysql1>UPDATE employees SET first_name="TOMMY" WHERE emp_no = 10001;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- 値を確認（ダーティリードは生じていない）
mysql2>SELECT * FROM employees WHERE emp_no = 10001;
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |

-- COMMIT
mysql1>COMMIT;
Query OK, 0 rows affected (0.00 sec)

-- トランザクション中のmysql2の方から再度値を確認すると変更が見える
mysql2>SELECT * FROM employees WHERE emp_no = 10001;
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | TOMMY      | Facello   | M      | 1986-06-26 |
+--------+------------+------------+-----------+--------+------------+


-----------------------------------------
-- Phantom read(他トランザクションの追加で値が変わる)
-----------------------------------------

-- MySQL InnoDBではREPEATABLE READでもファントムリードは生じないため、分離レベルは変更しない

-- トランザクション開始
mysql1>START TRANSACTION;
mysql2>START TRANSACTION;

-- 値を確認
mysql2>SELECT * FROM employees WHERE first_name = "Val" AND last_name = "Facello";
emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
| 425965 | 1957-08-01 | Val        | Facello   | M      | 1991-06-20 |
| 481003 | 1959-04-07 | Val        | Facello   | M      | 1986-12-29 |
+--------+------------+------------+-----------+--------+------------+

-- 値を追加
mysql1>INSERT INTO employees VALUES (500000, "1960-01-01", "Val", "Facello", "F", "2000-01-01");
Query OK, 1 row affected (0.00 sec)

-- 値を確認(追加されていない)
mysql2>SELECT * FROM employees WHERE first_name = "Val" AND last_name = "Facello";
emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
| 425965 | 1957-08-01 | Val        | Facello   | M      | 1991-06-20 |
| 481003 | 1959-04-07 | Val        | Facello   | M      | 1986-12-29 |
+--------+------------+------------+-----------+--------+------------+

-- COMMIT
mysql1>COMMIT;
Query OK, 0 rows affected (0.00 sec)

-- トランザクション中のmysql2の方から再度値を確認すると値が増えている
SELECT * FROM employees.employees WHERE first_name = "Val" AND last_name = "Facello";
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
| 425965 | 1957-08-01 | Val        | Facello   | M      | 1991-06-20 |
| 481003 | 1959-04-07 | Val        | Facello   | M      | 1986-12-29 |
| 500000 | 1960-01-01 | Val        | Facello   | F      | 2000-01-01 |

