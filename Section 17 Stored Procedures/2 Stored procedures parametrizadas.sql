-- Exemplo 1: Cria ou altera uma SP que recebe um ID e retorna o nome da pessoa usando OUTPUT
CREATE OR ALTER PROCEDURE Person.usp_GetPersonNameByID @BusinessEntityID INT, 
													   @PersonFullName NVARCHAR(2000) OUTPUT
AS
BEGIN
	SET @PersonFullName = (SELECT (FirstName + ' ' + LastName) AS FullName
							FROM Person.Person
							WHERE BusinessEntityID = @BusinessEntityID)
	RETURN 
END;
GO

-- Chamada à nova proc passando o ID = 1
DECLARE @PersonFullName NVARCHAR(2000)
EXECUTE Person.usp_GetPersonNameByID @BusinessEntityID = 1, 
									 @PersonFullName = @PersonFullName OUTPUT;
PRINT @PersonFullName;
GO

-- Deleta a proc
DROP PROCEDURE Person.usp_GetPersonNameByID;
GO

-- Exemplo 2: cria ou altera uma SP que recebe um ID e retorna 0 caso o ID exista e 1 caso não exista
CREATE OR ALTER PROCEDURE Person.usp_CheckPersonNameByID @BusinessEntityID INT
AS
BEGIN
	IF EXISTS (SELECT (FirstName + ' ' + LastName) AS FullName
			   FROM Person.Person
			   WHERE BusinessEntityID = @BusinessEntityID)
	BEGIN
		RETURN (0);
	END;
	ELSE 
	BEGIN
		RETURN (1)
	END;	
END;
GO

-- Chamada à nova proc passando o ID = 1
DECLARE @Status INT
EXECUTE @Status = Person.usp_CheckPersonNameByID @BusinessEntityID = 1;
PRINT 'Status: ' + CAST(@Status as VARCHAR(1))
IF (@Status = 1)
	PRINT 'ID inválido';
ELSE
	PRINT 'ID válido';
GO

-- Deleta a proc
DROP PROCEDURE Person.usp_CheckPersonNameByID;
GO
