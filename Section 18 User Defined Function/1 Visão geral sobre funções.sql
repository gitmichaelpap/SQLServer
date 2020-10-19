-- Exemplo 1: função escalar
-- Recebe um parâmetro inteiro que é o ID de uma pessoa e retorna um varchar que é o primeiro nome concatenado com o segundo nome da pessoa
CREATE OR ALTER FUNCTION dbo.fEmployeeFullName (@ID int)
RETURNS VARCHAR(2000)
AS
BEGIN
	DECLARE @NAME VARCHAR(2000);
	SELECT @NAME = FirstName + ' ' + LastName FROM Person.Person WHERE BusinessEntityID = @ID
RETURN @NAME
END;
GO

-- Chama a função escalar
SELECT dbo.fEmployeeFullName(1) AS FullName;

-- Deleta a função escalar
DROP FUNCTION dbo.fEmployeeFullName;
GO


-- Exemplo 2: função inline table-valued
-- Retorna um resultset com o primeiro nome, nome do meio, último nome e título de pessoas cujo título é igual ao parâmetro de entrada @Title
CREATE OR ALTER FUNCTION dbo.fEmployeeByTitle (@TITLE VARCHAR(10))
RETURNS table
AS
RETURN (SELECT FirstName, MiddleName, LastName, Title FROM Person.Person WHERE Title = @TITLE);
GO

-- Chama a função inline table-valued
SELECT * FROM dbo.fEmployeeByTitle('Mr.');

-- Deleta a função inline table-valued
DROP FUNCTION dbo.fEmployeeByTitle;
GO


-- Exemplo 3: função multi-statement table-valued
-- Essa função faz exatamente a mesma coisa que a função acima, mas foi reescrita como multi-statement
CREATE FUNCTION [dbo].[fEmployeeByTitle2](@TITLE VARCHAR(10))
RETURNS @persons TABLE 
(        
    [FirstName] [nvarchar](50) NOT NULL, 
	[MiddleName] [nvarchar](50) NULL, 
    [LastName] [nvarchar](50) NOT NULL, 
	[Title] [nvarchar](50) NOT NULL
)
AS 
BEGIN
	INSERT INTO @persons SELECT FirstName, MiddleName, LastName, Title FROM Person.Person WHERE Title = @TITLE
	RETURN;
END;
GO

-- Chama a função multi-statement table-valued
SELECT * FROM dbo.fEmployeeByTitle2('Mr.');

-- Deleta a função multi-statement table-valued
DROP FUNCTION dbo.fEmployeeByTitle2;
GO
