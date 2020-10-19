-- Join de três tabelas
SELECT p.Name, v.Name
FROM Production.Product p
JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE ProductSubcategoryID = 15
ORDER BY v.Name

-- Self join
SELECT DISTINCT pv1.ProductID, pv1.BusinessEntityID
FROM Purchasing.ProductVendor pv1
INNER JOIN Purchasing.ProductVendor pv2 ON pv1.ProductID = pv2.ProductID 
AND pv1.BusinessEntityID <> pv2.BusinessEntityID
ORDER BY pv1.ProductID

--Non equi-join
SELECT DISTINCT p1.ProductSubCategoryID, p1.ListPrice
FROM Production.Product p1
INNER JOIN Production.Product p2
ON p1.ProductSubcategoryID = p2.ProductSubcategoryID AND p1.ListPrice <> p2.ListPrice
WHERE p1.ListPrice < 15 AND p2.ListPrice < 15
ORDER BY ProductSubcategoryID
