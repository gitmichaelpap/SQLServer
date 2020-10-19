-- For XML RAW: serializa um resultado tabular em um resultado XML
-- Note que é gerado um elemento para cada linha do resultset
-- Permite renomear a raiz e o elemento
SELECT c.CustomerID, c.AccountNumber, sh.SalesOrderID, sh.OrderDate
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader sh ON (sh.CustomerID = c.CustomerID)
ORDER BY c.CustomerID
--FOR XML RAW
FOR XML RAW ('Order'), ROOT('Orders')

-- For XML AUTO: serializa um resultado tabular em um resultado XML
-- Formatação automática do corpo do XML
-- Por padrão, a formatação gera atributos. Utilize ELEMENTS para forçar o resultado no formato de elementos
SELECT Customer.CustomerID, Customer.AccountNumber, [Order].SalesOrderID, [Order].OrderDate
FROM Sales.Customer Customer
INNER JOIN Sales.SalesOrderHeader [Order] ON ([Order].CustomerID = Customer.CustomerID)
ORDER BY Customer.CustomerID
FOR XML AUTO

-- Força o resultado no tipo de dados XML e com elementos ao invés de atributos
SELECT Customer.CustomerID, Customer.AccountNumber, [Order].SalesOrderID, [Order].OrderDate
FROM Sales.Customer Customer
INNER JOIN Sales.SalesOrderHeader [Order] ON ([Order].CustomerID = Customer.CustomerID)
ORDER BY Customer.CustomerID
FOR XML AUTO, ELEMENTS, TYPE

-- For XML EXPLICIT: serializa um resultado tabular em um resultado XML
-- Formatação customizável
-- Veja que o alias das colunas determina sua formatação (Elemento, tag e atributo)
-- Note que os campos da tabela SalesOrderHeader foram explicitamente marcados como Elementos (!Element)
SELECT	1 AS TAG, 
		NULL AS PARENT, 
		Customer.CustomerID [Customer!1!CustomerID], 
		Customer.AccountNumber [Customer!1!AccountNumber], 
		[Order].SalesOrderID [Customer!1!SalesOrderID!Element], 
		[Order].OrderDate [Customer!1!OrderDate!Element]
FROM Sales.Customer Customer
INNER JOIN Sales.SalesOrderHeader [Order] ON ([Order].CustomerID = Customer.CustomerID)
ORDER BY Customer.CustomerID
FOR XML EXPLICIT

-- For XML PATH: serializa um resultado tabular em um resultado XML
-- Formatação customizável e sintaxe simplificada
-- Note que o @ antes do nome do campo determina que ele será um atributo e não um elemento
SELECT	Customer.CustomerID "Customer/@CustomerID", 
		Customer.AccountNumber "Customer/@AccountNumber", 
		[Order].SalesOrderID "Customer/SalesOrderID", 
		[Order].OrderDate "Customer/OrderDate"
FROM Sales.Customer Customer
INNER JOIN Sales.SalesOrderHeader [Order] ON ([Order].CustomerID = Customer.CustomerID)
ORDER BY Customer.CustomerID
FOR XML PATH

-- XML aninhados
-- Note o UNION ALL, os valores de Tag, Parent e o FOR XML EXPLICIT apenas no final
SELECT 1    as Tag,  
       NULL as Parent,  
       E.BusinessEntityID as [Employee!1!EmpID],  
       NULL       as [Name!2!FName],  
       NULL       as [Name!2!LName]  
FROM   HumanResources.Employee AS E  
INNER JOIN Person.Person AS P  
ON  E.BusinessEntityID = P.BusinessEntityID  
UNION ALL  
SELECT 2 as Tag,  
       1 as Parent,  
       E.BusinessEntityID,  
       FirstName,   
       LastName   
FROM   HumanResources.Employee AS E  
INNER JOIN Person.Person AS P  
ON  E.BusinessEntityID = P.BusinessEntityID  
ORDER BY [Employee!1!EmpID],[Name!2!FName]  
FOR XML EXPLICIT; 