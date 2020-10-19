-- UDF para concatenar o primeiro nome e o �ltimo nome de um funcion�rio cujo ID deve ser passado como par�metro
CREATE OR ALTER FUNCTION dbo.fEmployeeFullName (@ID int)
RETURNS VARCHAR(2000)
AS
BEGIN
DECLARE @NAME VARCHAR(2000);
SELECT @NAME = FirstName + ' ' + LastName FROM Person.Person WHERE BusinessEntityID = @ID
RETURN @NAME
END;
GO

-- Chama a nova UDF passando o ID = 1 como par�metro
SELECT dbo.fEmployeeFullName(1) AS FullName;

-- Confere o nome e o lastname do funcion�rio diretamente pela tabela
SELECT FirstName, LastName FROM Person.Person WHERE BusinessEntityID = 1

-- Deleta a UDF
DROP FUNCTION dbo.fEmployeeFullName;
GO
