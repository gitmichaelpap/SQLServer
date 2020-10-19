CREATE VIEW dbo.vPerson WITH SCHEMABINDING
AS 
SELECT BusinessEntityID, FirstName, MiddleName, LastName 
FROM Person.Person 
GO


CREATE UNIQUE CLUSTERED INDEX Idx_vPerson_BusinessEntityID ON dbo.vPerson (BusinessEntityID);
GO

SELECT * FROM dbo.vPerson