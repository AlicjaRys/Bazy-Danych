USE AdventureWorks2014

SELECT * FROM Production.Product

BEGIN TRANSACTION;
 
-- Dodanie nowego produktu do tabeli Production.Product
    INSERT INTO Production.Product (
        Name, 
        ProductNumber, 
        MakeFlag, 
        FinishedGoodsFlag, 
        Color, 
        SafetyStockLevel, 
        ReorderPoint, 
        StandardCost, 
        ListPrice, 
        Size, 
        SizeUnitMeasureCode, 
        WeightUnitMeasureCode, 
        Weight, 
        DaysToManufacture, 
        ProductLine, 
        Class, 
        Style, 
        ProductSubcategoryID, 
        ProductModelID, 
        SellStartDate, 
        SellEndDate, 
        DiscontinuedDate, 
        rowguid, 
        ModifiedDate
    )
  VALUES (
        'New Product Name', -- Name
        'NP-001',           -- ProductNumber
        1,                  -- MakeFlag
        1,                  -- FinishedGoodsFlag
        'Black',            -- Color
        100,                -- SafetyStockLevel
        500,                -- ReorderPoint
        50.00,              -- StandardCost
        100.00,             -- ListPrice
        'L',                -- Size
        'CM',               -- SizeUnitMeasureCode
        'LB',               -- WeightUnitMeasureCode
        10.00,              -- Weight
        5,                  -- DaysToManufacture
        'T',                -- ProductLine
        'H',                -- Class
        'U',                -- Style
        1,                  -- ProductSubcategoryID
        1,                  -- ProductModelID
        GETDATE(),          -- SellStartDate
        NULL,               -- SellEndDate
        NULL,               -- DiscontinuedDate
        NEWID(),            -- rowguid
        GETDATE()           -- ModifiedDate
    );

-- Zatwierdzenie transakcji
COMMIT TRANSACTION;

-- Wyœwietlenie komunikatu potwierdzaj¹cego wycofanie transakcji
PRINT 'Transakcja zatwierdzone. Nowy produkt zosta³ dodany do tabeli.';