-- Subconsulta correlacionada para retornar Persons cujo bonus é igual a 5000
SELECT c.LastName, c.FirstName
FROM Person.Person c
JOIN HumanResources.Employee e
ON e.BusinessEntityID = c.BusinessEntityID
WHERE 5000 IN 
(SELECT Bonus 
FROM Sales.SalesPerson sp 
WHERE e.BusinessEntityID = sp.BusinessEntityID)

-- Subconsulta com EXISTS para trazer produtos cujo nome da subcategoria é Wheels (rodas)
SELECT Name
FROM Production.Product
WHERE EXISTS 
(SELECT * FROM Production.ProductSubcategory 
WHERE ProductSubcategoryID = Production.Product.ProductSubcategoryID 
AND Name = 'Wheels')
