USE AdventureWorks2014

SELECT * FROM HumanResources.Employee
SELECT * FROM HumanResources.EmployeePayHistory
SELECT * FROM Person.Person

-- Tworzenie tabeli tymczasowej
CREATE TABLE #TempEmployeeInfo (
    BusinessEntityID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    JobTitle NVARCHAR(100),
    Gender CHAR(1),
    Rate MONEY
);

-- Tworzenie CTE zawieraj¹cego informacje o pracownikach
WITH EmployeeInfo AS (
    SELECT 
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.BirthDate,
        e.JobTitle,
        e.Gender,
        r.Rate
    FROM 
        HumanResources.Employee e
    JOIN 
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN 
        HumanResources.EmployeePayHistory r ON e.BusinessEntityID = r.BusinessEntityID
)

-- Wstawianie danych z CTE do tabeli tymczasowej
INSERT INTO #TempEmployeeInfo (BusinessEntityID, FirstName, LastName, BirthDate, JobTitle, Gender, Rate)
SELECT 
    BusinessEntityID, 
    FirstName, 
    LastName, 
    BirthDate, 
    JobTitle, 
    Gender, 
    Rate
FROM 
    EmployeeInfo;

-- Wyœwietlenie danych z tabeli tymczasowej
SELECT * FROM #TempEmployeeInfo;

