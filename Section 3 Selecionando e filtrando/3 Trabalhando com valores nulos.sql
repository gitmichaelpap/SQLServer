-- Usando ISNULL: note que existem apenas dois parâmetros
SELECT Description, DiscountPct, MaxQty, 
              ISNULL (MaxQty, 0) AS 'Max Quantity'
FROM Sales.SpecialOffer

-- Usando COALESCE: note que o coalesce aceita mais de dois parâmetros
SELECT Description, DiscountPct, MaxQty, MinQty, 
COALESCE (MaxQty, MinQty, 0) AS 'Quantity'
FROM Sales.SpecialOffer

-- NULLIF: retorna NULL sem ambos os parâmetros forem nulos
SELECT ProductID, MakeFlag, FinishedGoodsFlag, 
              NULLIF (MakeFlag, FinishedGoodsFlag) AS 'NULL if Equal'
FROM Production.Product
WHERE ProductID < 10
