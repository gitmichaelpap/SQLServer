-- Conversão com CAST no WHERE
DECLARE @FistName CHAR(10);
SET @FistName = 'John';

SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName = CAST(@FistName AS NCHAR(10)) 

-- Conversão de data com CONVERT no select list
SELECT BusinessEntityID, FirstName, LastName, ModifiedDate, 
             CONVERT(NVARCHAR(10), ModifiedDate, 103) AS ModifiedDatePtBR
FROM Person.Person
WHERE FirstName = 'John' 

-- Precedência com erro
DECLARE @TOTAL INT = 10;
SELECT 'TOTAL SALES: ' + @TOTAL;
GO

-- Precedência tratada com CAST
DECLARE @TOTAL INT = 10;
SELECT 'TOTAL SALES: ' + CAST(@TOTAL AS VARCHAR(2));
SELECT 'TOTAL SALES: ' + CONVERT(VARCHAR(2), @TOTAL);