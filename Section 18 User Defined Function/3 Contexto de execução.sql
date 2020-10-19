-- TRUSTWORTHY é uma propriedade da base de dados usada para indicar
-- que a instância do SQL Server confia na base de dados e em seu conteúdo
-- possibilitando o impersonate no nível do servidor
ALTER DATABASE AdventureWorks2017 SET TRUSTWORTHY ON; 
GO

-- Exemplo de função que permite a chamada em nome do usuário sa
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

-- Chama a função escalar (vai dar erro, pois o usuário da minha base TestUser não tem permissão na base do AdventureWorks)
SELECT dbo.fEmployeeFullName(1) AS FullName;

-- Deleta a função escalar
DROP FUNCTION dbo.fEmployeeFullName;
GO
