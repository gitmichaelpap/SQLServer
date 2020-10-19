-- Utilizando operadores de comparação;
SELECT OrderDate, AccountNumber, SubTotal, TaxAmt
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2001-08-01'
             

-- Utilizando operadores de intervalo;
SELECT SalesOrderID, OrderQty, ProductID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE ProductID IN (750, 753, 765, 770)
