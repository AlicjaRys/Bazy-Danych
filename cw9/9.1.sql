USE AdventureWorks2014

SELECT * FROM Production.Product

BEGIN TRANSACTION;
 
-- Aktualizacja ListPrice 680 o 10%
UPDATE Production.Product
SET ListPrice = ListPrice * 1.10
WHERE ProductID = 680;

-- Sprawdzenie ceny po aktualizacji
DECLARE @NewPrice DECIMAL(19, 4);
SELECT @NewPrice = ListPrice FROM Production.Product WHERE ProductID = 680;

-- Zatwierdzenie transakcji
COMMIT TRANSACTION;

-- Wyœwietlenie komunikatu potwierdzaj¹cego oraz nowej ceny
PRINT 'Transakcja zatwierdzona. Nowa cena produktu o ProductID 680 to: ' + CAST(@NewPrice AS NVARCHAR(50));