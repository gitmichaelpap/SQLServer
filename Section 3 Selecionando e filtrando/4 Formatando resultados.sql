-- Nomear tabela
SELECT e.BusinessEntityID AS 'Employee Identification Number'
FROM HumanResources.Employee AS e

-- Nomear coluna
SELECT (LastName + ', ' + FirstName + ' ' + ISNULL (SUBSTRING(MiddleName, 1, 1), ' ')) AS Name
FROM Person.Person AS p

-- Express�o matem�tica em colunas e no resultado
SELECT Name, ProductNumber, ListPrice AS OldPrice, 
              (ListPrice * 1.1) AS NewPrice
FROM Production.Product
WHERE ListPrice > 0 AND (ListPrice/StandardCost) > .8

-- Express�es com c�lculos e fun��es para filtrar linhas no resultado
SELECT Name, ProductNumber, ListPrice AS OldPrice, 
              (ListPrice * 1.1) AS NewPrice
FROM Production.Product
WHERE SellEndDate < GETDATE()
