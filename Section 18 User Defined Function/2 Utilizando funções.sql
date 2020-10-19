-- Rotina para verificar se uma UDF é deterministica ou não
-- 1 significa sim e 0 significa não
SELECT [IsDeterministic] = OBJECTPROPERTY(OBJECT_ID('[dbo].[ufnLeadingZeros]'), 'IsDeterministic')

-- Exemplo de comportamento determinístico
-- Execute 5x e terá o mesmo resultado para o mesmo parâmetro
SELECT [dbo].[ufnLeadingZeros](100)

-- Exemplo de comportamento não determinístico
-- Execute 5x e poderá apresentar resultados diferentes para o mesmo parâmetro
SELECT FirstName, LastName 
FROM Person.Person
TABLESAMPLE (5 PERCENT)
ORDER BY FirstName, LastName
