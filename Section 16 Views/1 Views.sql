-- Cria uma nova view
CREATE VIEW [HumanResources].[vEmployeeDepartment2] 
AS 
SELECT 
    e.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName] 
    ,p.[LastName], p.[Suffix], e.[JobTitle], d.[Name] AS [Department] 
    ,d.[GroupName], edh.[StartDate] 
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.[BusinessEntityID] = edh.[BusinessEntityID] 
    INNER JOIN [HumanResources].[Department] d ON edh.[DepartmentID] = d.[DepartmentID] 
WHERE edh.EndDate IS NULL
GO

-- Exibe os dados da view
SELECT * FROM [HumanResources].[vEmployeeDepartment2] 

-- Aplica um update na view para alterar dados da tabela de pessoas
UPDATE [HumanResources].[vEmployeeDepartment2] SET Title = 'Test' WHERE BusinessEntityID = 1;
GO

-- Exibe os dados da view
SELECT FirstName, LastName, Title FROM [HumanResources].[vEmployeeDepartment2] WHERE BusinessEntityID = 1;

-- Exibe os dados da tabela person
SELECT FirstName, LastName, Title FROM [Person].[Person] WHERE BusinessEntityID = 1;

-- Volta o titulo para nulo
UPDATE [HumanResources].[vEmployeeDepartment2] SET Title = NULL WHERE BusinessEntityID = 1;
GO

-- Exibe o código da view criada
EXEC sp_helptext '[HumanResources].[vEmployeeDepartment2]'
GO

-- Altera a view removendo as colunas [GroupName] e [StartDate] do SELECT. Além disso, criptografa o código da view nos metadados
ALTER VIEW [HumanResources].[vEmployeeDepartment2] 
WITH ENCRYPTION AS 
SELECT 
    e.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName] 
    ,p.[LastName], p.[Suffix], e.[JobTitle], d.[Name] AS [Department] 
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.[BusinessEntityID] = edh.[BusinessEntityID] 
    INNER JOIN [HumanResources].[Department] d ON edh.[DepartmentID] = d.[DepartmentID] 
WHERE edh.EndDate IS NULL
GO

-- Exibe os dados da view alterada
SELECT * FROM [HumanResources].[vEmployeeDepartment2] 

-- Tenta exibe o código da view criptografada
EXEC sp_helptext '[HumanResources].[vEmployeeDepartment2]'
GO

-- Deleta a view
DROP VIEW [HumanResources].[vEmployeeDepartment2];
GO
