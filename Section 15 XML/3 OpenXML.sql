-- Exemplo 1: desserialização simples
-- Declara uma variável XML para receber o XML em formato string
DECLARE @Documento XML;
SET @Documento = '<pessoas><pessoa><nome>José</nome><sobrenome>Silva</sobrenome></pessoa><pessoa><nome>Maria</nome><sobrenome>Batista</sobrenome></pessoa></pessoas>';

-- Declara o handle do documento XML
DECLARE @i INT;

-- Cria a árvore em memória para os nós do XML
EXEC sp_xml_preparedocument @i OUTPUT, @Documento;

-- Trabalha os dados...
SELECT *
FROM OPENXML(@i, '/pessoas/pessoa', 2)
WITH (Nome VARCHAR(100) 'nome', 
      SobreNome VARCHAR(100) 'sobrenome')

-- Libera a memória
EXEC sp_xml_removedocument @i;
GO

-- Exemplo 2 : desserialização com NS
-- Usando namespaces
DECLARE @Documento XML;
SET @Documento ='<ns2:root xmlns="uri2" xmlns:ns2="uri2" xmlns:ns1="uri1">  
  <ns1:Product>  
    <ns1:ProductID>316</ns1:ProductID>  
    <ns1:Name>Blade</ns1:Name>  
	<ns1:Color>Red</ns1:Color>
  </ns1:Product>  
  <ns1:Product>  
    <ns1:ProductID>317</ns1:ProductID>  
    <ns1:Name>LL Crankarm</ns1:Name>  
    <ns1:Color>Black</ns1:Color>  
  </ns1:Product>  
</ns2:root>';

-- Declara o handle do documento XML
DECLARE @i INT;

-- Cria a árvore em memória para os nós do XML
EXEC sp_xml_preparedocument @i OUTPUT, @Documento, '<ns2:root xmlns="uri2" xmlns:ns2="uri2" xmlns:ns1="uri1" />';

-- Trabalha os dados...
SELECT * 
FROM OPENXML(@i, '/ns2:root/ns1:Product', 2)
WITH (ProductID VARCHAR(100) 'ns1:ProductID', 
      Name VARCHAR(100) 'ns1:Name', 
	  Color VARCHAR(100) 'ns1:Color')

-- Libera a memória
EXEC sp_xml_removedocument @i;
GO
