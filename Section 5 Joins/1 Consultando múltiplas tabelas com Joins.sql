-- Inner Join
SELECT e.LoginID
FROM HumanResources.Employee AS e
INNER JOIN Sales.SalesPerson AS s
ON e.BusinessEntityID = s.BusinessEntityID

-- Left Join
SELECT p.Name, pr.ProductReviewID
FROM Production.Product p
LEFT OUTER JOIN 
Production.ProductReview pr
ON p.ProductID = pr.ProductID
--WHERE pr.ProductReviewID IS NOT NULL

-- Equivalente com Inner Join
SELECT p.Name, pr.ProductReviewID
FROM Production.Product p
INNER JOIN 
Production.ProductReview pr
ON p.ProductID = pr.ProductID

SELECT ProductID, Name FROM Production.Product
SELECT ProductID, ProductReviewID FROM Production.ProductReview

-- Cross Join
SELECT p.BusinessEntityID, t.Name AS Territory
FROM Sales.SalesPerson p
CROSS JOIN Sales.SalesTerritory t
ORDER BY p.BusinessEntityID

SELECT * FROM Sales.SalesPerson
SELECT * FROM Sales.SalesTerritory