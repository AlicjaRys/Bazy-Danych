USE AdventureWorks2014 
GO;

CREATE FUNCTION dbo.fibofunction(@n INT)

RETURNS @results TABLE (
    val INT
)
AS
BEGIN
    DECLARE @i INT = 2,
            @iCurrent INT,
            @i0 INT = 0,
            @i1 INT = 1;

    INSERT INTO @results VALUES(@i0);
    INSERT INTO @results VALUES(@i1);

    WHILE (@n > @i)
    BEGIN
        SET @iCurrent = @i0 + @i1;
        INSERT INTO @results VALUES(@iCurrent);
        SET @i0 = @i1;
        SET @i1 = @iCurrent;
        SET @i = @i + 1;
    END;

    RETURN;
END;
GO

CREATE PROCEDURE dbo.fiboprint(@n INT)
AS
BEGIN
    SELECT * FROM dbo.fibofunction(@n);
END;
GO

EXEC dbo.fiboprint @n = 20;
GO
