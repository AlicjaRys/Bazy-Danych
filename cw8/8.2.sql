USE AdventureWorksLT2019

SELECT * FROM SalesLT.SalesOrderHeader

-- Tworzenie CTE zawierającego informacje o przychodach ze sprzedaży, firmie i kontakcie
WITH SalesRevenue AS (
    SELECT
        ISNULL(c.CompanyName, '') + ' (' + ISNULL(c.FirstName, '') + ' ' + ISNULL(c.LastName, '') + ')' AS CompanyContact,
        SUM(h.TotalDue) AS Revenue
    FROM 
        SalesLT.Customer c
    JOIN 
        SalesLT.SalesOrderHeader h ON c.CustomerID = h.CustomerID
    GROUP BY
        c.CustomerID,
        c.CompanyName,
        c.FirstName,
        c.LastName
)

-- Wyciąganie informacji z CTE
SELECT * 
FROM SalesRevenue
ORDER BY Revenue DESC;