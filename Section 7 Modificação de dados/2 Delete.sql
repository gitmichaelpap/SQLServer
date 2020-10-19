-- Delete sem WHERE que apresenta erro, pois a tabela SalesPerson é referenciada por Foreign Keys
DELETE FROM Sales.SalesPerson; 

-- Delete simples sem WHERE
DELETE FROM HumanResources.JobCandidate;
TRUNCATE TABLE HumanResources.JobCandidate;

-- Delete com WHERE e subconsulta para deletar dados da tabela SalesOrderHeader cujo vendedor fez vendas superiores a 2.500.000
DELETE FROM 
Sales.SalesOrderHeader 
WHERE SalesPersonID IN (SELECT SalesPersonID FROM Sales.SalesPerson WHERE SalesYTD > 2500000)

-- Delete com TOP para deletar uma amostra de 2,5% da tabela ProductInventory
DELETE TOP (2.5) PERCENT FROM Production.ProductInventory;

-- Delete com OUTPUT para exibir as linhas deletadas no resultado
DELETE Production.ProductCostHistory OUTPUT DELETED.*;
