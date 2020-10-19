-- TRUSTWORTHY � uma propriedade da base de dados usada para indicar
-- que a inst�ncia do SQL Server confia na base de dados e em seu conte�do
-- possibilitando o impersonate no n�vel do servidor
ALTER DATABASE AdventureWorks2017 SET TRUSTWORTHY ON; 
GO

-- Exemplo de fun��o que permite a chamada em nome do usu�rio sa
CREATE OR ALTER FUNCTION dbo.fEmployeeFullName (@ID int)
RETURNS VARCHAR(2000)
WITH EXECUTE AS 'TestUser'
AS
BEGIN
	DECLARE @NAME VARCHAR(2000);
	SELECT @NAME = FirstName + ' ' + LastName FROM Person.Person WHERE BusinessEntityID = @ID
RETURN @NAME
END;
GO

-- Chama a fun��o escalar (vai dar erro, pois o usu�rio da minha base TestUser n�o tem permiss�o na base do AdventureWorks)
SELECT dbo.fEmployeeFullName(1) AS FullName;

-- Deleta a fun��o escalar
DROP FUNCTION dbo.fEmployeeFullName;
GO
