SELECT MAX (TaxRate), TaxType
FROM Sales.SalesTaxRate
GROUP BY TaxType;

SELECT AVG( ISNULL(Weight,0) ) AS 'AvgWeight'
FROM Production.Product

/* pulando valores nullos */
SELECT AVG(Weight) AS 'AvgWeight'
FROM Production.Product

SELECT COUNT(*) 
FROM Person.Person