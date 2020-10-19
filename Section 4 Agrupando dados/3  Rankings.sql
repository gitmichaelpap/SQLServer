-- Rank
SELECT P.Name, P.ListPrice, PSC.Name Category, 
RANK() OVER(PARTITION BY PSC.Name ORDER BY P.ListPrice DESC) AS PriceRank
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID

-- Dense_Rank
SELECT P.Name, P.ListPrice, PSC.Name Category, 
DENSE_RANK() OVER(PARTITION BY PSC.Name ORDER BY P.ListPrice DESC) AS PriceRank
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID

--Row_Number
SELECT ROW_NUMBER() OVER(PARTITION BY PSC.Name ORDER BY P.ListPrice) AS Row,
PSC.Name Category, P.Name Product, P.ListPrice
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID

--Ntile
SELECT NTILE(10) OVER (PARTITION BY PC.Name ORDER BY ListPrice)
AS PriceBand, PC.Name Category, P.Name Product, P.ListPrice
FROM Production.Product P
JOIN Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN Production.ProductCategory PC ON PSC.ProductCategoryID = PC.ProductCategoryID
