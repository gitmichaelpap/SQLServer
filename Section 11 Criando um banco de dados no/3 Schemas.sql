-- Criação de um schema chamado Mobile
CREATE SCHEMA Mobile;
GO

-- Criação de um login de testes chamado TestUser com senha igual a StrongPasswordHere
CREATE LOGIN TestUser WITH PASSWORD = 'StrongPasswordHere';
GO

-- Criação de um usuário para o login TestUser com o schema default igual a Mobile
CREATE USER TestUser WITH DEFAULT_SCHEMA = Mobile;
GO

-- Consulta do schema default do usuário TestUser
SELECT name, default_schema_name 
FROM sys.database_principals 
WHERE name = 'TestUser'