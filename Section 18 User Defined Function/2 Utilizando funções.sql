-- Rotina para verificar se uma UDF � deterministica ou n�o
-- 1 significa sim e 0 significa n�o
SELECT [IsDeterministic] = OBJECTPROPERTY(OBJECT_ID('[dbo].[ufnLeadingZeros]'), 'IsDeterministic')

-- Exemplo de comportamento determin�stico
-- Execute 5x e ter� o mesmo resultado para o mesmo par�metro
SELECT [dbo].[ufnLeadingZeros](100)

-- Exemplo de comportamento n�o determin�stico
-- Execute 5x e poder� apresentar resultados diferentes para o mesmo par�metro
SELECT FirstName, LastName 
FROM Person.Person
TABLESAMPLE (5 PERCENT)
ORDER BY FirstName, LastName
