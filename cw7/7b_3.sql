USE AdventureWorks2014

SELECT*FROM Sales.SalesTaxRate

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
DECLARE @old FLOAT, @new FLOAT
SELECT @old = TaxRate FROM deleted
SELECT @new = TaxRate FROM inserted
IF @new > 1.3 * @old OR @new < 0.7 * @old
PRINT 'zmiana wartoœci pola TaxRate o wiêcej ni¿ 30%'
GO

UPDATE Sales.SalesTaxRate 
SET TaxRate = 20
WHERE SalesTaxRateID = 2


SELECT * FROM Sales.SalesTaxRate
