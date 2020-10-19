-- Cria um XML schema collection
CREATE XML SCHEMA COLLECTION ManuInstructionsSchemaCollection AS  
N'<?xml version="1.0" encoding="UTF-16"?>  
<xsd:schema targetNamespace="https://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"   
   xmlns          ="https://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"   
   elementFormDefault="qualified"   
   attributeFormDefault="unqualified"  
   xmlns:xsd="http://www.w3.org/2001/XMLSchema" >  
  
    <xsd:complexType name="StepType" mixed="true" >  
        <xsd:choice  minOccurs="0" maxOccurs="unbounded" >   
            <xsd:element name="tool" type="xsd:string" />  
            <xsd:element name="material" type="xsd:string" />  
            <xsd:element name="blueprint" type="xsd:string" />  
            <xsd:element name="specs" type="xsd:string" />  
            <xsd:element name="diag" type="xsd:string" />  
        </xsd:choice>   
    </xsd:complexType>  
  
    <xsd:element  name="root">  
        <xsd:complexType mixed="true">  
            <xsd:sequence>  
                <xsd:element name="Location" minOccurs="1" maxOccurs="unbounded">  
                    <xsd:complexType mixed="true">  
                        <xsd:sequence>  
                            <xsd:element name="step" type="StepType" minOccurs="1" maxOccurs="unbounded" />  
                        </xsd:sequence>  
                        <xsd:attribute name="LocationID" type="xsd:integer" use="required"/>  
                        <xsd:attribute name="SetupHours" type="xsd:decimal" use="optional"/>  
                        <xsd:attribute name="MachineHours" type="xsd:decimal" use="optional"/>  
                        <xsd:attribute name="LaborHours" type="xsd:decimal" use="optional"/>  
                        <xsd:attribute name="LotSize" type="xsd:decimal" use="optional"/>  
                    </xsd:complexType>  
                </xsd:element>  
            </xsd:sequence>  
        </xsd:complexType>  
    </xsd:element>  
</xsd:schema>' ;  
GO  
  
-- Declara uma vari�vel do tipo de dados XML passando o XSD como par�metro  
DECLARE @DOCUMENT xml (ManuInstructionsSchemaCollection);  
SET @DOCUMENT = '<root xmlns="https://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions">
  Adventure Works CyclesFR-210B Instructions for Manufacturing HL Touring FrameSummaryThis document contains manufacturing instructions for manufacturing the HL Touring Frame, Product Model 7. Instructions are work center specific and are identified by Work Center ID. These instructions must be followed in the order presented. Deviation from the instructions is not permitted unless an authorized Change Order detailing the deviation is provided by the Engineering Manager. 
<Location LaborHours="2.5" LotSize="100" MachineHours="3" 
          SetupHours="0.5" LocationID="10">
  Work Center - 10 Frame FormingThe following instructions pertain to Work Center 10. (Setup hours = .5, Labor Hours = 2.5, Machine Hours = 3, Lot Sizing = 100) 
  <step>Insert <material>aluminum sheet MS-2341</material> into the 
  <tool>T-85A framing tool</tool>.</step>
  <step>Attach <tool>Trim Jig TJ-26</tool> to the upper and lower right corners of the aluminum sheet. </step>
  <step>Using a <tool>router with a carbide tip 15</tool> 
  , route the aluminum sheet following the jig carefully. </step>
  <step>Insert the frame into <tool>Forming Tool FT-15</tool> and press Start. </step>
  <step> When finished, inspect the forms for defects per Inspection Specification <specs>INFS-111</specs>.</step>
  <step>Remove the frames from the tool and place them in the Completed or Rejected bin as appropriate.</step> 
  </Location>
<Location LaborHours="1.75" LotSize="1" MachineHours="2" SetupHours="0.15" LocationID="20">
  Work Center 20 - Frame WeldingThe following instructions pertain to Work Center 20. (Setup hours = .15, Labor Hours = 1.75, Machine Hours = 2, Lot Sizing = 1) 
  <step>Assemble all frame components following blueprint 
  <blueprint>1299</blueprint> . </step>
  <step>Weld all frame components together as shown in illustration 
  <diag>3</diag> </step>
  <step>Inspect all weld joints per Adventure Works Cycles Inspection Specification <specs>INFS-208</specs> . </step>
  </Location>
<Location LaborHours="1" LotSize="1" LocationID="30">
  Work Center 30 - Debur and PolishThe following instructions pertain to Work Center 30. (Setup hours = 0, Labor Hours = 1, Machine Hours = 0, Lot Sizing = 1) 
  <step>Using the <tool>standard debur tool</tool> , remove all excess material from weld areas. </step>
  <step>Using <material>Acme Polish Cream</material> , polish all weld areas. </step>
  </Location>
<Location LaborHours="0.5" LotSize="20" MachineHours="0.65" LocationID="45">
  Work Center 45 - Specialized PaintThe following instructions pertain to Work Center 45. (Setup hours = 0, Labor Hours = .5, Machine Hours = .65, Lot Sizing = 20) 
  <step>Attach <material>a maximum of 20 frames</material> 
  to <tool>paint harness</tool> ensuring frames are not touching. 
  </step>
  <step>Mix <material>primer PA-529S</material>. Test spray pattern on sample area and correct flow and pattern as required per engineering spec 
  <specs>AWC-501</specs>. </step>
  <step>Apply thin coat of primer to all surfaces.</step> 
  <step>After 30 minutes, touch test for dryness. If dry to touch, lightly sand all surfaces. Remove all surface debris with compressed air.</step> 
  <step>Mix <material>paint</material> per manufacturer instructions. </step>
  <step>Test spray pattern on sample area and correct flow and pattern as required per engineering spec <specs>AWC-509</specs>.</step>
  <step>Apply thin coat of paint to all surfaces.</step> 
  <step>After 60 minutes, touch test for dryness. If dry to touch, reapply second coat.</step> 
  <step> Allow paint to cure for 24 hours and inspect per <specs>AWC-5015</specs> . </step>
  </Location>
<Location LaborHours="3" LotSize="1" SetupHours="0.25" LocationID="50">
  Work Center 50 - SubAssembly The following instructions pertain to Work Center 50. (Setup hours = .25, Labor Hours = 3, Machine Hours = 0, Lot Sizing = 1) 
  <step>Add Seat Assembly.</step> 
  <step>Add Brake assembly.</step> 
  <step>Add Wheel Assembly.</step> 
  <step>Inspect Front Derailleur.</step> 
  <step>Inspect Rear Derailleur.</step> 
  </Location>
<Location LaborHours="4" LotSize="1" LocationID="60">
  Work Center 60 - Final Assembly The following instructions pertain to Work Center 60. (Setup hours = 0, Labor Hours = 4, Machine Hours = 0, Lot Sizing = 1) 
<step>Perform final inspection per engineering specification 
  <specs>AWC-915</specs>. </step>
  <step>Complete all required certification forms.</step> 
  <step>Move to shipping.</step> 
  </Location>
  </root>';
GO

-- Cria uma nova tabela com uma coluna do tipo de dados XML usando o novo XSD para valida��o
CREATE TABLE dbo.TabelaComValidacaoXSD (  
	i INT PRIMARY KEY,   
	document XML (ManuInstructionsSchemaCollection));  
GO  

-- Insere dados v�lidos
INSERT INTO dbo.TabelaComValidacaoXSD (i, document) VALUES (1, '<root xmlns="https://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"><Location LocationID="1000" SetupHours="10" MachineHours="3" LaborHours="4"  LotSize="5"><step><tool>Hammer</tool><material>Steel</material><blueprint>SP</blueprint><specs>Wood and Steel</specs><diag></diag></step></Location></root>')
GO

-- Tenta inserir dados inv�lidos, ou seja, passando uma string em um tipo decimal no atributo SetupHours
INSERT INTO dbo.TabelaComValidacaoXSD (i, document) VALUES (2, '<root xmlns="https://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"><Location LocationID="1001" SetupHours="11h" MachineHours="4" LaborHours="5"  LotSize="6"><step><tool>Hammer</tool><material>Steel</material><blueprint>SP</blueprint><specs>Wood and Steel</specs><diag></diag></step></Location></root>')
GO

-- Visualiza os dados inseridos (somente o id=1)
SELECT * FROM dbo.TabelaComValidacaoXSD
GO

-- Deleta a tabela de testes
DROP TABLE dbo.TabelaComValidacaoXSD;  
GO  

-- Deleta o XSD
DROP XML SCHEMA COLLECTION ManuInstructionsSchemaCollection;  
GO