-- Proc para retornar as pessoas cujo primeiro nome come�a com uma letra passada como par�metro
CREATE OR ALTER PROCEDURE Person.usp_GetPersonName @NamePrefix char(1)
AS
BEGIN
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE @NamePrefix + '%'
ORDER BY FirstName
END;
GO

-- Chama a proc passando a letra A como par�metro
EXECUTE Person.usp_GetPersonName 'A';
GO

-- Deleta a proc
DROP PROCEDURE Person.usp_GetPersonName;
GO
