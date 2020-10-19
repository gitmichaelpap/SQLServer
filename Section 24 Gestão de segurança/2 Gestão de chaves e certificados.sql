-- Cria��o de um login DevJr para um desenvolvedor jr.
CREATE LOGIN [DevJr] WITH PASSWORD=N'123456', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

-- Cria��o de um usu�rio para o desenvolvedor jr. na base do AdventureWorks
CREATE USER [DevJr] WITH DEFAULT_SCHEMA=[dbo]
GO

-- Atribui��o de permiss�es de select para o usu�rio do desenvolvedor jr.
GRANT SELECT ON SCHEMA :: Person TO DevJr;

-- Teste de permiss�es de select
EXECUTE AS USER = 'DevJr'; 
SELECT * FROM Person.Person;

-- Teste de select em um schema sem permiss�es (vai dar erro)
SELECT * FROM Production.Product;

-- Teste de altera��es (vai dar erro)
DELETE FROM Person.Person;