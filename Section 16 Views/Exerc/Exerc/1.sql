-- Cria uma nova view
CREATE VIEW Person.vPerson
AS 
SELECT BusinessEntityID, FirstName, MiddleName, LastName 
FROM Person.Person 
GO

SELECT * FROM Person.vPerson

