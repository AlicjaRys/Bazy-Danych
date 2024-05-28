USE AdventureWorks2014

BEGIN TRANSACTION;
 
BEGIN TRY
    -- Aktualizacja StandardCost o 10%
    UPDATE Production.Product
    SET StandardCost = StandardCost * 1.10;
 
    -- Sprawdzenie, czy suma StandardCost po aktualizacji nie przekracza 50000
    DECLARE @TotalStandardCost MONEY;
    SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;
 
    IF @TotalStandardCost <= 50000
    BEGIN
        -- Je�li suma nie przekracza 50000, zatwierd� transakcj�
        COMMIT;
        PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
    END
    ELSE
    BEGIN
        -- Je�li suma przekracza 50000, wycofaj transakcj�
        ROLLBACK;
        PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50000. Aktualna suma: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
    END
END TRY
BEGIN CATCH
    -- Je�li wyst�pi b��d, wycofaj transakcj� i wy�wietl komunikat o b��dzie
    ROLLBACK;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;