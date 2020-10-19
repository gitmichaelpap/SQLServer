-- Exemplo de consulta que utiliza índice XML
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription' AS "PD")
SELECT CatalogDescription.query('  /PD:ProductDescription/PD:Summary') as Result
FROM Production.ProductModel
WHERE CatalogDescription.exist ('/PD:ProductDescription/PD:Features') = 1
GO

-- Criando uma nova tabela
CREATE TABLE dbo.TabelaIndiceXML (Col1 INT PRIMARY KEY, XmlCol XML);  
GO 

-- Cria um índece primário
CREATE PRIMARY XML INDEX Idx_TabelaIndiceXML_XmlCol   
ON TabelaIndiceXML(XmlCol);  
GO  

-- Cria os índices secundários (PATH, VALUE, PROPERTY).  
CREATE XML INDEX Idx_TabelaIndiceXML_XmlCol_PATH ON TabelaIndiceXML(XmlCol)  
USING XML INDEX Idx_TabelaIndiceXML_XmlCol  
FOR PATH;  
GO  
CREATE XML INDEX Idx_TabelaIndiceXML_XmlCol_VALUE ON TabelaIndiceXML(XmlCol)  
USING XML INDEX Idx_TabelaIndiceXML_XmlCol  
FOR VALUE;  
GO  
CREATE XML INDEX Idx_TabelaIndiceXML_XmlCol_PROPERTY ON TabelaIndiceXML(XmlCol)  
USING XML INDEX Idx_TabelaIndiceXML_XmlCol  
FOR PROPERTY;  
GO 

-- Insere valores de testes
INSERT INTO dbo.TabelaIndiceXML VALUES (1,  
'<doc id="123">  
<sections>  
<section num="2">  
<heading>Background</heading>  
</section>  
<section num="3">  
<heading>Sort</heading>  
</section>  
<section num="4">  
<heading>Search</heading>  
</section>  
</sections>  
</doc>');  
GO  

-- Deleta os índices secundários
DROP INDEX Idx_TabelaIndiceXML_XmlCol_PATH ON dbo.TabelaIndiceXML;  
GO  
DROP INDEX Idx_TabelaIndiceXML_XmlCol_VALUE ON dbo.TabelaIndiceXML;  
GO  
DROP INDEX Idx_TabelaIndiceXML_XmlCol_PROPERTY ON dbo.TabelaIndiceXML;  
GO  
-- Deleta o índice primário
DROP INDEX Idx_TabelaIndiceXML_XmlCol ON dbo.TabelaIndiceXML;  
GO

-- Deleta a tabela
DROP TABLE dbo.TabelaIndiceXML;
GO