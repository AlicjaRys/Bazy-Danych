USE AdventureWorks2014

BEGIN TRANSACTION;
 
BEGIN TRY

    IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'NP-001')
    BEGIN
		-- Jeœli ProductNumber istnieje ju¿ w tabeli
        ROLLBACK TRANSACTION;
        PRINT 'Transakcja wycofana. ProductNumber ju¿ istnieje w tabeli.';
    END
    ELSE
    BEGIN
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
        'New Product Name 2', -- Name
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
		-- Jeœli ProductNumber nie istnieje jeszcze w tabeli
        COMMIT TRANSACTION;
        PRINT 'Transakcja zatwierdzona. Nowy produkt dodany do tabeli';
	END
END TRY
BEGIN CATCH
    -- Jeœli wyst¹pi b³¹d, wycofaj transakcjê i wyœwietl komunikat o b³êdzie
    ROLLBACK;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * FROM Production.Product