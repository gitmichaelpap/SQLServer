-- Gera um contador de pessoas que são vendedores usando cursor
DECLARE @COUNT INT = 0;
DECLARE @BusinessEntityID INT;
DECLARE person_cursor CURSOR
FOR SELECT BusinessEntityID FROM Person.Person
OPEN person_cursor
FETCH NEXT FROM person_cursor INTO @BusinessEntityID
WHILE @@FETCH_STATUS = 0
BEGIN
      IF EXISTS(SELECT * FROM Sales.SalesPerson WHERE BusinessEntityID = @BusinessEntityID) 
            SET @COUNT = @COUNT + 1;
      FETCH NEXT FROM person_cursor INTO @BusinessEntityID
END
CLOSE person_cursor
DEALLOCATE person_cursor
PRINT 'TOTAL: ' + CAST(@COUNT AS NVARCHAR(10));

-- Outra implementação da funcionalidade acima usando consultas baseadas em lógica de grupo
SELECT COUNT(*) AS 'TOTAL'
FROM Person.Person p
INNER JOIN Sales.SalesPerson s 
ON (p.BusinessEntityID = s.BusinessEntityID)

-- Mais uma implementação diferente usando consulta aninhada
SELECT COUNT(*) AS 'TOTAL'
FROM 
(
      SELECT p.FirstName, p.LastName
      FROM Person.Person p
      INNER JOIN Sales.SalesPerson s 
      ON (p.BusinessEntityID = s.BusinessEntityID)
) AS v
