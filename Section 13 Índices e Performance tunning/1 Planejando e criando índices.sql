-- Cria um índice nonclustered simples
CREATE UNIQUE NONCLUSTERED INDEX [IDX_Employee_LoginID] ON [HumanResources].[Employee] (LoginID ASC);
GO

-- Cria um índice nonclustered composto com duas colunas
CREATE NONCLUSTERED INDEX IDX_Contact_LastName_FirstName ON [Person].[Person] (LastName ASC, FirstName ASC);
GO

-- Cria um índice nonclustered com coluna incluída
CREATE UNIQUE NONCLUSTERED INDEX [IDX_Employee_LoginID_NationalIDNumber] ON [HumanResources].[Employee] (LoginID ASC) INCLUDE (NationalIDNumber);
GO

-- Cria um índice nonclustered único com FILLFACTOR e PAD_INDEX
CREATE UNIQUE NONCLUSTERED INDEX IDX_Employee_LoginID_FillFactor ON [HumanResources].[Employee] (LoginID ASC) WITH (FILLFACTOR = 65, PAD_INDEX = ON);
GO

-- Consulta dados da tabela Person.Person
EXEC sp_help 'Person.Person'

-- Consulta dados de índices da tabela Person.Person
EXEC sp_helpindex 'Person.Person'

-- Deleta os índices acima
DROP INDEX IDX_Employee_LoginID ON [HumanResources].[Employee];
DROP INDEX IDX_Contact_LastName_FirstName ON Person.Person;
DROP INDEX IDX_Employee_LoginID_NationalIDNumber ON [HumanResources].[Employee];
DROP INDEX IDX_Employee_LoginID_FillFactor ON [HumanResources].[Employee];
GO