-- Group by com SUM
SELECT SalesOrderID, SUM(LineTotal) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID

-- Group by com COUNT
SELECT A.City, COUNT(E.BusinessEntityID) EmployeeCount
FROM HumanResources.Employee E
INNER JOIN Person.Address A ON E.BusinessEntityID = A.AddressID
GROUP BY A.City
HAVING COUNT(E.BusinessEntityID) > 10
ORDER BY A.City

-- Having
SELECT SalesOrderID, SUM(LineTotal) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 100000.00
ORDER BY SalesOrderID

-- Rollup
SELECT ProductID, Shelf, SUM(Quantity) AS QtySum
FROM Production.ProductInventory
WHERE ProductID < 6
GROUP BY ROLLUP (ProductID, Shelf)

-- Cube
SELECT ProductID, Shelf, SUM(Quantity) AS QtySum
FROM Production.ProductInventory
WHERE ProductID < 6
GROUP BY CUBE (ProductID, Shelf)

-- Grouping Sets
SELECT T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID
FROM Sales.Customer C
INNER JOIN Sales.Store S ON C.StoreID = S.BusinessEntityID
INNER JOIN Sales.SalesTerritory T ON C.TerritoryID = T.TerritoryID
INNER JOIN Sales.SalesOrderHeader H ON C.CustomerID = H.CustomerID
WHERE T.[Group] = 'Europe'
AND T.CountryRegionCode IN ('DE', 'FR')
AND SUBSTRING(S.Name, 1, 4) IN ('Vers', 'Spa')
GROUP BY GROUPING SETS(T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID)
ORDER BY T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID
