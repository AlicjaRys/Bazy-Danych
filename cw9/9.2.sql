USE AdventureWorks2014

SELECT * FROM Production.ProductCostHistory

BEGIN TRANSACTION;
 
-- Usuniêcie produktu o ProductID równym 707
DELETE FROM Production.Product
WHERE ProductID = 707;

-- Wycofanie transakcji
ROLLBACK TRANSACTION;

-- Wyœwietlenie komunikatu potwierdzaj¹cego wycofanie transakcji
PRINT 'Transakcja wycofana. Produkt o ProductID 707 nie zosta³ usuniêty.';