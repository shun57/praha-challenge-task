----------------------------------------------------------------
-- SQL1
----------------------------------------------------------------
SELECT
  C.CustomerID,
  COUNT(O.OrderId) AS OrderCount
FROM
  Customers AS C
  INNER JOIN Orders AS O 
    ON O.CustomerID = C.CustomerID
WHERE
  strftime('%Y', O.OrderDate) = '1996'
GROUP BY
  C.CustomerID
HAVING
  OrderCount >= 3
ORDER BY
  OrderCount DESC
;

-- 最もよく注文してくれたのは以下3名で6回
-- CustomerID | CustomerName
-- 65 | Rattlesnake Canyon Grocery
-- 63 | QUICK-Stop
-- 20 | Ernst Handel

----------------------------------------------------------------
-- SQL2
----------------------------------------------------------------

SELECT
  O.OrderID,
  COUNT(OD.OrderDetailId) AS OrderDetailCount
FROM
  Orders AS O
  INNER JOIN [OrderDetails] AS OD 
    ON OD.OrderID = O.OrderID
GROUP BY
  O.OrderID
HAVING
  OrderDetailCount = (
    SELECT
      MAX(OrderDetailCount)
    FROM
      (
        SELECT
          COUNT(OD.OrderDetailId) AS OrderDetailCount
        FROM
          [Orders] AS O
          LEFT JOIN [OrderDetails] AS OD 
            ON OD.OrderID = O.OrderID
        GROUP BY
          O.OrderID
      )
  )
;

-- 過去、最も多くのOrderDetailが紐づいたOrderは以下10レコードで5つ。
-- OrderID | OrderDetailCount
-- 10273 | 5
-- 10294 | 5
-- 10309 | 5
-- 10324 | 5
-- 10325 | 5
-- 10337 | 5
-- 10360 | 5
-- 10382 | 5
-- 10393 | 5
-- 10406 | 5

----------------------------------------------------------------
-- SQL3
----------------------------------------------------------------

SELECT
  S.ShipperID,
  COUNT(O.OrderID) AS ShippingCount
FROM
  [Shippers] AS S
  LEFT JOIN [Orders] AS O 
    ON O.ShipperID = S.ShipperID
GROUP BY
  S.ShipperID
ORDER BY
  ShippingCount DESC
;

-- Order数が多い順のShipperのid
-- ShipperID | ShippingCount
-- 2 | 74
-- 3 | 68
-- 1 | 54

----------------------------------------------------------------
-- SQL4
----------------------------------------------------------------

SELECT
  ROUND(SUM(OD.Quantity * P.Price)) AS sales,
  C.Country
FROM
  [Customers] AS C
  INNER JOIN [Orders] AS O 
    ON O.CustomerID = C.CustomerID
  INNER JOIN [OrderDetails] AS OD 
    ON OD.OrderID = O.OrderID
  INNER JOIN [Products] AS P 
    ON P.ProductID = OD.ProductID
GROUP BY
  C.Country
ORDER BY
  sales DESC
;

----------------------------------------------------------------
-- SQL5
----------------------------------------------------------------

SELECT
  ROUND(SUM(OD.Quantity * P.Price)) AS sales,
  strftime('%Y', O.OrderDate) AS OrderYear,
  C.Country
FROM
  [Customers] AS C
  INNER JOIN [Orders] AS O 
    ON O.CustomerID = C.CustomerID
  INNER JOIN [OrderDetails] AS OD 
    ON OD.OrderID = O.OrderID
  INNER JOIN [Products] AS P 
    ON P.ProductID = OD.ProductID
GROUP BY
  OrderYear, C.Country
ORDER BY
  C.Country
;

----------------------------------------------------------------
-- SQL6
----------------------------------------------------------------

-- カラム追加
ALTER TABLE [Employees] ADD Junior BOOLEAN DEFAULT 0 NOT NULL
;

-- 更新
UPDATE
  [Employees]
SET
  Junior = 1
WHERE
  strftime('%Y', BirthDate) >= '1960'
;

-- 結果確認
SELECT
  EmployeeID,
  LastName,
  FirstName,
  BirthDate,
  Photo,
  Notes,
  Junior
FROM
  [Employees]
;

----------------------------------------------------------------
-- SQL7
----------------------------------------------------------------

-- カラム追加
ALTER TABLE [Shippers] ADD long_relation BOOLEAN DEFAULT 0 NOT NULL
;

-- 更新
UPDATE
  [Shippers]
SET
  long_relation = 1
WHERE
  ShipperID = (
    SELECT
      S.ShipperID
    FROM
      [Shippers] AS S
      INNER JOIN
        [Orders] AS O
      ON  O.ShipperID = S.ShipperID
    GROUP BY
      S.ShipperID
    HAVING COUNT(O.OrderID) >= 70
  )
;

-- 結果確認
SELECT 
  ShipperID,
  ShipperName,
  Phone,
  long_relation
FROM 
  [Shippers]
;

----------------------------------------------------------------
-- SQL8
----------------------------------------------------------------

SELECT
  E.EmployeeID,
  MAX(O.OrderDate) AS LatestOrderDate
FROM
  [Employees] AS E
  INNER JOIN
    [Orders] AS O
  ON  O.EmployeeID = E.EmployeeID
GROUP BY
  E.EmployeeID
;

----------------------------------------------------------------
-- SQL9
----------------------------------------------------------------

-- CustomerID:1のCustomerNameをNULLに更新
UPDATE
  [Customers]
SET
  CustomerName = NULL
WHERE
  CustomerID = 1
;

-- CustomerNameが存在するユーザー取得
SELECT
  * 
FROM 
  [Customers] 
WHERE
  CustomerName IS NOT NULL
;

-- CustomerNameが存在しないユーザー取得
SELECT
  * 
FROM 
  [Customers] 
WHERE
  CustomerName IS NULL
;

-- Q.なぜ「= NULL」だとダメなのか？
-- A.NULLは存在しない値(真偽値ではない0のため、等号の対象にならないから。
-- 参考：
-- [3値論理](https://qiita.com/devopsCoordinator/items/9c10410b50f8fcc2ba79)

----------------------------------------------------------------
-- SQL10
----------------------------------------------------------------

-- EmployeeID=1の従業員レコードを削除
DELETE
FROM
  [Employees]
WHERE
  EmployeeID = 1
;

-- 削除した担当者を含まない注文と担当者を取得
SELECT
  O.OrderID,
  O.CustomerID,
  O.EmployeeID,
  O.OrderDate,
  O.ShipperID
FROM
  [Orders] AS O
  INNER JOIN
    [Employees] AS E
  ON  E.EmployeeID = O.EmployeeID
;

-- 削除した担当者と注文を取得
SELECT
  O.OrderID,
  O.CustomerID,
  E.EmployeeID,
  O.OrderDate,
  O.ShipperID
FROM
  [Orders] AS O
  LEFT JOIN
    [Employees] AS E
  ON  E.EmployeeID = O.EmployeeID
WHERE
  E.EmployeeID IS NULL
;