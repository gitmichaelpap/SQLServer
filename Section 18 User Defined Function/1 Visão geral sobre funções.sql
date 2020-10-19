-- Exemplo 1: fun��o escalar
-- Recebe um par�metro inteiro que � o ID de uma pessoa e retorna um varchar que � o primeiro nome concatenado com o segundo nome da pessoa
CREATE OR ALTER FUNCTION dbo.fEmployeeFullName (@ID int)
RETURNS VARCHAR(2000)
AS
BEGIN
	DECLARE @NAME VARCHAR(2000);
	SELECT @NAME = FirstName + ' ' + LastName FROM Person.Person WHERE BusinessEntityID = @ID
RETURN @NAME
END;
GO

-- Chama a fun��o escalar
SELECT dbo.fEmployeeFullName(1) AS FullName;

-- Deleta a fun��o escalar
DROP FUNCTION dbo.fEmployeeFullName;
GO


-- Exemplo 2: fun��o inline table-valued
-- Retorna um resultset com o primeiro nome, nome do meio, �ltimo nome e t�tulo de pessoas cujo t�tulo � igual ao par�metro de entrada @Title
CREATE OR ALTER FUNCTION dbo.fEmployeeByTitle (@TITLE VARCHAR(10))
RETURNS table
AS
RETURN (SELECT FirstName, MiddleName, LastName, Title FROM Person.Person WHERE Title = @TITLE);
GO

-- Chama a fun��o inline table-valued
SELECT * FROM dbo.fEmployeeByTitle('Mr.');

-- Deleta a fun��o inline table-valued
DROP FUNCTION dbo.fEmployeeByTitle;
GO


-- Exemplo 3: fun��o multi-statement table-valued
-- Essa fun��o faz exatamente a mesma coisa que a fun��o acima, mas foi reescrita como multi-statement
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

-- Chama a fun��o multi-statement table-valued
SELECT * FROM dbo.fEmployeeByTitle2('Mr.');

-- Deleta a fun��o multi-statement table-valued
DROP FUNCTION dbo.fEmployeeByTitle2;
GO
