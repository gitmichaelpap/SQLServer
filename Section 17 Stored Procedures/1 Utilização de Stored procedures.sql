-- Cria ou altera uma SP que recebe uma letra e retorna o nome das pessoas cujo primeiro nome inicia com essa letra
CREATE OR ALTER PROCEDURE Person.usp_GetPersonName @NamePrefix char(1)
AS
BEGIN
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE @NamePrefix + '%'
ORDER BY FirstName
END;
GO

-- Chamada à nova proc
EXECUTE Person.usp_GetPersonName 'A';
GO

-- Deleta a proc
DROP PROCEDURE Person.usp_GetPersonName;
GO
