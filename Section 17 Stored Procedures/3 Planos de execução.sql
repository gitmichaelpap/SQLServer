-- Exemplo 1: exibir o plano de execução estimado da consulta abaixo
SELECT FirstName
FROM Person.Person
WHERE FirstName like 'S%'
GO

-- Exemplo 2: exibir o plano de execução atual da consulta abaixo
SELECT FirstName
FROM [HumanResources].[vEmployee] WITH (index([IX_Person_LastName_FirstName_MiddleName]))
WHERE FirstName like 'S%'
GO

-- Exemplo 3: criando uma proc com recompilação forçada
CREATE OR ALTER PROCEDURE Person.usp_GetPersonName @NamePrefix char(1)
WITH RECOMPILE
AS
BEGIN
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE @NamePrefix + '%'
ORDER BY FirstName
END;
GO

-- Recompilação manual da nova proc
EXECUTE sp_recompile 'Person.usp_GetPersonName';
GO

-- Deleta a proc
DROP PROCEDURE Person.usp_GetPersonName;
GO