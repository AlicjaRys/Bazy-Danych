USE AdventureWorks2014

SELECT * FROM Production.ProductCostHistory

BEGIN TRANSACTION;
 
-- Usuni�cie produktu o ProductID r�wnym 707
DELETE FROM Production.Product
WHERE ProductID = 707;

-- Wycofanie transakcji
ROLLBACK TRANSACTION;

-- Wy�wietlenie komunikatu potwierdzaj�cego wycofanie transakcji
PRINT 'Transakcja wycofana. Produkt o ProductID 707 nie zosta� usuni�ty.';