-- Update simples para atualizar a coluna Bonus da tabela SalesPerson para 6.000
UPDATE Sales.SalesPerson SET Bonus = 6000;

SELECT BONUS FROM SALES.SALESPERSON

-- Update com expressão para dobrar o valor da coluna Bonus da tabela SalesPerson
UPDATE Sales.SalesPerson SET Bonus = Bonus * 2;

-- Update com WHERE para atualizar a cor de produtos cuja cor é Red e que começam com Road-250 para Metallic Red
UPDATE Production.Product 
SET Color = N'Metallic Red'
WHERE Name LIKE N'Road-250%' AND Color = N'Red';

SELECT NAME, COLOR FROM PRODUCTION.PRODUCT WHERE Name LIKE N'Road-250%' AND COLOR = 'Metallic Red'

-- Update com JOIN, expressão e subconsulta
UPDATE Sales.SalesPerson
SET SalesYTD = SalesYTD + so.SubTotal
FROM Sales.SalesPerson AS sp
JOIN Sales.SalesOrderHeader AS so 
ON sp.BusinessEntityID = so.SalesPersonID
AND so.OrderDate = (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader WHERE SalesPersonID = sp.BusinessEntityID)