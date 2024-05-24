USE AdventureWorksLT2019

SELECT * FROM SalesLT.SalesOrderDetail
SELECT * FROM SalesLT.SalesOrderHeader
SELECT * FROM SalesLT.ProductCategory
SELECT * FROM SalesLT.Product

-- Tworzenie CTE zawieraj¹cego informacje o przychodach ze sprzeda¿y, firmie i kontakcie
WITH SalesCategory AS (
    SELECT
        c.Name AS Category,
        SUM(d.LineTotal) AS SalesValue
    FROM SalesLT.ProductCategory c
	JOIN SalesLT.Product p ON c. ProductCategoryID = p. ProductCategoryID
	JOIN SalesLT.SalesOrderDetail d ON p.ProductID = d.ProductID 
    GROUP BY
        c.Name
)

-- Wyci¹ganie informacji z CTE
SELECT Category, ROUND(SalesValue, 2) FROM SalesCategory
ORDER BY Category;