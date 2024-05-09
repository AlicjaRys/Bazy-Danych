USE AdventureWorks2014

SELECT * FROM Person.Person
SELECT * FROM Person.BusinessEntity


CREATE TRIGGER modifyLastName
ON Person.Person
AFTER INSERT
AS
UPDATE Person.Person
SET LastName = UPPER(LastName)

INSERT INTO Person.BusinessEntity(rowguid) VALUES(newID())

INSERT INTO Person.Person(BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName) 
VALUES(20778, 'IN', 0, NULL, 'Jan', 'Adam', 'Kowalski')

SELECT * FROM Person.Person
GO

