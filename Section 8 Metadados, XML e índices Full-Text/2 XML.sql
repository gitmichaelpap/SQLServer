-- Usando FOR XML para transformar um resultado tabular em XML
SELECT Cust.CustomerID, OrderHeader.SalesOrderID, OrderHeader.Status, Cust.PersonID
FROM Sales.Customer Cust
INNER JOIN Sales.SalesOrderHeader OrderHeader ON (Cust.CustomerID = OrderHeader.CustomerID)
ORDER BY Cust.CustomerID
FOR XML AUTO

-- Usando OpenXML para ler um XML em formato tabular
DECLARE @xml_text VARCHAR(4000), @i INT;

SELECT @xml_text = '<root><person LastName="Silva" FirstName="Jose" /><person LastName="Souza" FirstName="Maria" /></root>'

EXEC sp_xml_preparedocument @i OUTPUT, @xml_text;

SELECT * FROM OpenXML(@i, '/root/person') WITH (LastName nvarchar(50), FirstName nvarchar(50))

EXEC sp_xml_removedocument @i
