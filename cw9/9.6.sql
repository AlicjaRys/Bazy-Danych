USE AdventureWorks2014

BEGIN TRANSACTION;
 
BEGIN TRY

    IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
    BEGIN
		-- Je¿eli którykolwiek z zamówieñ ma OrderQty równ¹ 0
        ROLLBACK TRANSACTION;
        PRINT 'Transakcja wycofana. Wykryto zamówienie z OrderQty równym 0.';
    END
    ELSE
    BEGIN
		-- Aktualizacja wartoœci OrderQty
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty + 1

		-- Je¿eli ¿aden z zamówieñ nie ma OrderQty równej 0
        COMMIT TRANSACTION;
        PRINT 'Transakcja zatwierdzona. Zaktualizowano wartoœæ OrderQty.';
	END
END TRY
BEGIN CATCH
    -- Jeœli wyst¹pi b³¹d, wycofaj transakcjê i wyœwietl komunikat o b³êdzie
    ROLLBACK;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * FROM Sales.SalesOrderDetail ORDER BY OrderQty