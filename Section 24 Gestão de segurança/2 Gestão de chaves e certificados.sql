-- Criação de um login DevJr para um desenvolvedor jr.
CREATE LOGIN [DevJr] WITH PASSWORD=N'123456', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

-- Criação de um usuário para o desenvolvedor jr. na base do AdventureWorks
CREATE USER [DevJr] WITH DEFAULT_SCHEMA=[dbo]
GO

-- Atribuição de permissões de select para o usuário do desenvolvedor jr.
GRANT SELECT ON SCHEMA :: Person TO DevJr;

-- Teste de permissões de select
EXECUTE AS USER = 'DevJr'; 
SELECT * FROM Person.Person;

-- Teste de select em um schema sem permissões (vai dar erro)
SELECT * FROM Production.Product;

-- Teste de alterações (vai dar erro)
DELETE FROM Person.Person;