-- UDF para concatenar o primeiro nome e o último nome de um funcionário cujo ID deve ser passado como parâmetro
CREATE OR ALTER FUNCTION dbo.fEmployeeFullName (@ID int)
RETURNS VARCHAR(2000)
AS
BEGIN
DECLARE @NAME VARCHAR(2000);
SELECT @NAME = FirstName + ' ' + LastName FROM Person.Person WHERE BusinessEntityID = @ID
RETURN @NAME
END;
GO

-- Chama a nova UDF passando o ID = 1 como parâmetro
SELECT dbo.fEmployeeFullName(1) AS FullName;

-- Confere o nome e o lastname do funcionário diretamente pela tabela
SELECT FirstName, LastName FROM Person.Person WHERE BusinessEntityID = 1

-- Deleta a UDF
DROP FUNCTION dbo.fEmployeeFullName;
GO
