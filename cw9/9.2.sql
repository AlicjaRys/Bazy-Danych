USE AdventureWorks2014

SELECT * FROM Production.ProductCostHistory

BEGIN TRANSACTION;
 
-- Usunięcie produktu o ProductID równym 707
DELETE FROM Production.Product
WHERE ProductID = 707;

-- Wycofanie transakcji
ROLLBACK TRANSACTION;

-- Wyświetlenie komunikatu potwierdzającego wycofanie transakcji
PRINT 'Transakcja wycofana. Produkt o ProductID 707 nie został usunięty.';