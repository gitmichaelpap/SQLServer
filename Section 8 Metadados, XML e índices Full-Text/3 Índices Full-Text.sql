-- Criação de um índice full-text na tabela Production.Product para a coluna Name
EXEC sp_fulltext_database 'enable'

EXEC sp_fulltext_catalog 'Product_Description', 'create';  
EXEC sp_fulltext_table 'Production.ProductDescription', 'create', 'Product_Description', 'PK_ProductDescription_ProductDescriptionID'; 

EXEC sp_fulltext_column 'Production.ProductDescription','Description','add';  

EXEC sp_fulltext_table 'Production.ProductDescription','Activate'; 
EXEC sp_fulltext_table 'Production.ProductDescription','start_full'; 

-- Realiza o rebuild manual do catalogo
ALTER FULLTEXT CATALOG [Product_Description] REBUILD
GO

SELECT Description FROM Production.ProductDescription WHERE Description LIKE '%run%'

-- Realiza uma consulta ao índice criado usando uma forma flexiva (ride, riders, etc)
SELECT Description
FROM Production.ProductDescription 
WHERE CONTAINS (Description, ' FORMSOF (INFLECTIONAL, ride) ')

-- Realiza uma consulta ao índice criado usando Freetext
SELECT Description
FROM Production.ProductDescription 
WHERE FREETEXT(Description, 'ride')

-- Deleta o catálogo e o índice Full-Text
DROP FULLTEXT INDEX ON Production.ProductDescription 
EXEC sp_fulltext_catalog 'Product_Description', 'drop';  