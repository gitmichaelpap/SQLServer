-- Cria uma tabela com uma coluna do tipo XML chamada Documento
CREATE TABLE dbo.TabelaComXML (
	Id INT NOT NULL PRIMARY KEY, 
	Documento XML NULL
)
GO

-- Declara uma variável do tipo de dados XML chamada Documento
DECLARE @Documento XML;
GO

-- Utiliza o método Query() para localizar um fragmento XML do nó /Root/ProductDescription/Features
DECLARE @myDoc XML
SET @myDoc = '<Root>  
<ProductDescription ProductID="1" ProductName="Road Bike">  
<Features>  
  <Warranty>1 year parts and labor</Warranty>  
  <Maintenance>3 year parts and labor extended maintenance is available</Maintenance>  
</Features>  
</ProductDescription>  
</Root>'  
SELECT @myDoc.query('/Root/ProductDescription/Features')  
GO

-- Utiliza o método Values() para retornar o valor do atributo ProductID do XML abaixo
DECLARE @myDoc xml  
DECLARE @ProdID int  
SET @myDoc = '<Root>  
<ProductDescription ProductID="1" ProductName="Road Bike">  
<Features>  
  <Warranty>1 year parts and labor</Warranty>  
  <Maintenance>3 year parts and labor extended maintenance is available</Maintenance>  
</Features>  
</ProductDescription>  
</Root>'  
  
SET @ProdID =  @myDoc.value('(/Root/ProductDescription/@ProductID)[1]', 'int' )  
SELECT @ProdID  
GO

-- Utiliza o método Exists() para verificar a existencia de uma data num atributo de um fragmento XML
DECLARE @x XML;  
DECLARE @f BIT;  
SET @x = '<root Somedate = "2002-01-01Z"/>';  
SET @f = @x.exist('/root[(@Somedate cast as xs:date?) eq xs:date("2002-01-01Z")]');  
SELECT @f;  
GO

-- Utiliza o método Modify() para deletar um fragmento XML do nó /Root/ProductDescription/Features
DECLARE @myDoc XML
SET @myDoc = '<Root>  
<ProductDescription ProductID="1" ProductName="Road Bike">  
<Features>  
  <Warranty>1 year parts and labor</Warranty>  
  <Maintenance>3 year parts and labor extended maintenance is available</Maintenance>  
</Features>  
</ProductDescription>  
</Root>'  
SET @myDoc.modify('delete (/Root/ProductDescription/Features)')  
SELECT @myDoc.query('/Root/ProductDescription/Features')  
GO

-- Utiliza o método Insert() para incluir um fragmento XML no nó /Root/ProductDescription/Features
DECLARE @myDoc xml;  
SET @myDoc = N'<Root>             
<ProductDescription ProductID="1" ProductName="Road Bike">             
    <Features> </Features>             
</ProductDescription>             
</Root>';  
DECLARE @newFeatures xml;  
SET @newFeatures = N'<Warranty>1 year parts and labor</Warranty>            
<Maintenance>3 year parts and labor extended maintenance is available</Maintenance>';           
SET @myDoc.modify('             
insert sql:variable("@newFeatures")             
into (/Root/ProductDescription/Features)[1] ')             
SELECT @myDoc;  
GO  

-- Utiliza o método replace value of() para alterar o valor de um elemento e de um atributo
DECLARE @myDoc xml;  
SET @myDoc = '<Root>  
<Location LocationID="10"   
            LaborHours="1.1"  
            MachineHours=".2" >Manufacturing steps are described here.  
<step>Manufacturing step 1 at this work center</step>  
<step>Manufacturing step 2 at this work center</step>  
</Location>  
</Root>';  
SELECT @myDoc;  
  
-- Atualiza o texto do primeiro elemento step
SET @myDoc.modify('  
  replace value of (/Root/Location/step[1]/text())[1]  
  with     "new text describing the manu step"  
');  
SELECT @myDoc;  
-- Atualiza o valor do atributo LaborHours
SET @myDoc.modify('  
  replace value of (/Root/Location/@LaborHours)[1]  
  with     "100.0"  
');  
SELECT @myDoc; 

-- Utiliza o método Nodes() para retornar elementos row
DECLARE @x xml   
SET @x='<Root>  
    <row id="1"><name>Larry</name><oflw>some text</oflw></row>  
    <row id="2"><name>moe</name></row>  
    <row id="3" />  
</Root>'  
SELECT T.c.query('.') AS result  
FROM   @x.nodes('/Root/row') T(c)  
GO  