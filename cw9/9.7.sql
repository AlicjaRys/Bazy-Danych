USE AdventureWorks2014

BEGIN TRANSACTION;
 
BEGIN TRY

    -- Obliczenie �redniego kosztu wszystkich produkt�w w tabeli Production.Product
    DECLARE @AverageCost DECIMAL(18, 2);
    SELECT @AverageCost = AVG(StandardCost) FROM Production.Product;

	-- Sprawdzenie, czy liczba produkt�w do usuni�cia przekracza 10
    DECLARE @ProductsToDeleteCount INT;
    SELECT @ProductsToDeleteCount = COUNT(*) FROM Production.Product WHERE StandardCost > @AverageCost;

	-- Wy�wietlenie �redniego kosztu
    PRINT '�redni koszt wszystkich produkt�w: ' + CAST(@AverageCost AS VARCHAR(50));

	-- Wy�wietlenie warto�ci produkt�w, kt�re zostan� usuni�te
	SELECT *
	FROM Production.Product
	WHERE StandardCost > @AverageCost;
 
    IF @ProductsToDeleteCount > 10
    BEGIN
        -- Je�eli liczba produkt�w do usuni�cia przekracza 10
		ROLLBACK;
        PRINT 'Transakcja wycofana. Liczba produkt�w do usuni�cia przekracza 10.'
    END
    ELSE
    BEGIN
		-- usuni�cie produkt�w
		DELETE FROM Production.Product WHERE StandardCost > @AverageCost;

		-- Je�eli liczba produkt�w do usuni�cia nie przekracza 10
		COMMIT;
        PRINT 'Transakcja zatwierdzona. Produkty usuni�te.'
    END
END TRY
BEGIN CATCH
    -- Je�li wyst�pi b��d, wycofaj transakcj� i wy�wietl komunikat o b��dzie
    ROLLBACK;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

