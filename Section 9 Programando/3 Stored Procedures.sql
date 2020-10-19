-- Proc para retornar as pessoas cujo primeiro nome começa com uma letra passada como parâmetro
CREATE OR ALTER PROCEDURE Person.usp_GetPersonName @NamePrefix char(1)
AS
BEGIN
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE @NamePrefix + '%'
ORDER BY FirstName
END;
GO

-- Chama a proc passando a letra A como parâmetro
EXECUTE Person.usp_GetPersonName 'A';
GO

-- Deleta a proc
DROP PROCEDURE Person.usp_GetPersonName;
GO
