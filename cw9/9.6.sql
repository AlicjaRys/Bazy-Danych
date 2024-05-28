USE AdventureWorks2014

BEGIN TRANSACTION;
 
BEGIN TRY

    IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
    BEGIN
		-- Je�eli kt�rykolwiek z zam�wie� ma OrderQty r�wn� 0
        ROLLBACK TRANSACTION;
        PRINT 'Transakcja wycofana. Wykryto zam�wienie z OrderQty r�wnym 0.';
    END
    ELSE
    BEGIN
		-- Aktualizacja warto�ci OrderQty
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty + 1

		-- Je�eli �aden z zam�wie� nie ma OrderQty r�wnej 0
        COMMIT TRANSACTION;
        PRINT 'Transakcja zatwierdzona. Zaktualizowano warto�� OrderQty.';
	END
END TRY
BEGIN CATCH
    -- Je�li wyst�pi b��d, wycofaj transakcj� i wy�wietl komunikat o b��dzie
    ROLLBACK;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * FROM Sales.SalesOrderDetail ORDER BY OrderQty