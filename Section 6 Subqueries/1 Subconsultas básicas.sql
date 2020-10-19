-- Seleciona producos cuja cor não é igual a cor do produto 317, que é Black
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color NOT IN 
(SELECT Color
FROM Production.Product
WHERE ProductID = 317)

-- Subconsultas como expressões
SELECT Name, ListPrice, 
(SELECT AVG(ListPrice) FROM Production.Product) AS Average, 
ListPrice - (SELECT AVG(ListPrice) FROM Production.Product) AS Difference
FROM Production.Product
WHERE ProductSubcategoryID = 1

-- ANY: retorna nome de produtos cujo preço de lista seja maior ou igual a ALGUM dos preços listados pela subconsulta
SELECT Name, ListPrice
FROM Production.Product 
WHERE ListPrice >= ANY 
(SELECT MAX(ListPrice) 
FROM Production.Product
GROUP BY ProductSubcategoryID)
ORDER BY ListPrice

SELECT MAX(ListPrice) 
FROM Production.Product
GROUP BY ProductSubcategoryID
ORDER BY Max(ListPrice)

-- ALL: retorna nome de produtos cujo preço de lista seja maior ou igual a TODOS os preços listados pela subconsulta
SELECT Name, ListPrice
FROM Production.Product 
WHERE ListPrice >= ALL
(SELECT MAX(ListPrice) 
FROM Production.Product
GROUP BY ProductSubcategoryID)
