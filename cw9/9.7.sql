USE AdventureWorks2014

BEGIN TRANSACTION;
 
BEGIN TRY

    -- Obliczenie œredniego kosztu wszystkich produktów w tabeli Production.Product
    DECLARE @AverageCost DECIMAL(18, 2);
    SELECT @AverageCost = AVG(StandardCost) FROM Production.Product;

	-- Sprawdzenie, czy liczba produktów do usuniêcia przekracza 10
    DECLARE @ProductsToDeleteCount INT;
    SELECT @ProductsToDeleteCount = COUNT(*) FROM Production.Product WHERE StandardCost > @AverageCost;

	-- Wyœwietlenie œredniego kosztu
    PRINT 'Œredni koszt wszystkich produktów: ' + CAST(@AverageCost AS VARCHAR(50));

	-- Wyœwietlenie wartoœci produktów, które zostan¹ usuniête
	SELECT *
	FROM Production.Product
	WHERE StandardCost > @AverageCost;
 
    IF @ProductsToDeleteCount > 10
    BEGIN
        -- Je¿eli liczba produktów do usuniêcia przekracza 10
		ROLLBACK;
        PRINT 'Transakcja wycofana. Liczba produktów do usuniêcia przekracza 10.'
    END
    ELSE
    BEGIN
		-- usuniêcie produktów
		DELETE FROM Production.Product WHERE StandardCost > @AverageCost;

		-- Je¿eli liczba produktów do usuniêcia nie przekracza 10
		COMMIT;
        PRINT 'Transakcja zatwierdzona. Produkty usuniête.'
    END
END TRY
BEGIN CATCH
    -- Jeœli wyst¹pi b³¹d, wycofaj transakcjê i wyœwietl komunikat o b³êdzie
    ROLLBACK;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

