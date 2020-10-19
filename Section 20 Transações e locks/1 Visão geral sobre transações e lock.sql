-- TRAN � IGUAL A TRANSACTION
BEGIN TRAN T1

-- $6700
SELECT MAX(BONUS) FROM Sales.SalesPerson

UPDATE Sales.SalesPerson SET Bonus = 6000;

-- $6000
SELECT MAX(BONUS) FROM Sales.SalesPerson

ROLLBACK TRAN T1

-- $6700
SELECT MAX(BONUS) FROM Sales.SalesPerson