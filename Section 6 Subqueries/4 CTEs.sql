-- CTE simples
WITH TopSales (SalesPerson, NumSales) AS
(SELECT SalesPersonID, Count(*) FROM Sales.SalesOrderHeader GROUP BY SalesPersonID)

SELECT LoginID, SalesPerson, NumSales
FROM HumanResources.Employee e 
INNER JOIN TopSales ON TopSales.SalesPerson = e.BusinessEntityID
ORDER BY NumSales DESC
