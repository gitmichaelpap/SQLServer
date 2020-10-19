-- Cria uma view com SCHEMABINDING
CREATE VIEW dbo.vDiscount WITH SCHEMABINDING
AS 
SELECT SUM(UnitPrice*OrderQty) AS SumPrice,
SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS SUMDiscountPrice,
SUM(UnitPrice*OrderQty*UnitPriceDiscount) AS SumDiscountPrice2, 
COUNT_BIG(*) AS Count, ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
GO

-- Cria um índice na view para que ela se torne indexada (materializada)
CREATE UNIQUE CLUSTERED INDEX Idx_vDiscount_ProductID ON dbo.vDiscount (ProductID);
GO

-- Acessa a view
SELECT * FROM dbo.vDiscount;

-- Deleta a view
DROP VIEW dbo.vDiscount;
GO