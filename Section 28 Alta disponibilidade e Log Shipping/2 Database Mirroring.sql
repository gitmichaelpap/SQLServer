-- Database Mirroring

-- No principal: altere o recovery model para FULL
ALTER DATABASE AdventureWorks2017   
SET RECOVERY FULL;  
GO  

-- No principal: cria��o do endpoint para rodar na porta 5022
CREATE ENDPOINT Endpoint_Mirroring  
    STATE=STARTED   
    AS TCP (LISTENER_PORT=5022)   
    FOR DATABASE_MIRRORING (ROLE=PARTNER)  
GO  

-- *** ATEN��O ****
-- N�o prosseguir se voc� n�o tiver feito o backup do principal e restore da base no mirror 
-- N�o prosseguir se a base do mirror n�o estiver em restoring

-- No mirror: cria��o do endpoint para rodar na porta 5023
CREATE ENDPOINT Endpoint_Mirroring  
    STATE=STARTED   
    AS TCP (LISTENER_PORT=5023)   
    FOR DATABASE_MIRRORING (ROLE=PARTNER)  
GO 

-- No mirror: defina que o principal � o servidor do endpoint 5022
ALTER DATABASE AdventureWorks2017
    SET PARTNER = 'TCP://NOTE-LEO-DELL:5022';  
GO  

-- No principal: defina que o endpoint do partner � o servidor do endpoint 5023
ALTER DATABASE AdventureWorks2017
    SET PARTNER = 'TCP://NOTE-LEO-DELL:5023';  
GO 

-- No principal: testando um insert para mostrar que a base est� ativa
INSERT INTO SALES.CURRENCY (CurrencyCode, Name, ModifiedDate) VALUES ('GHI', 'TESTE MIRRORING', GETDATE());

-- No principal: verifica��o do insert
SELECT * FROM Sales.Currency WHERE CurrencyCode = 'GHI'

-- No mirror: note que n�o � poss�vel realizar selects, pois a base est� em restoring

-- Limpeza
DELETE FROM Sales.Currency WHERE CurrencyCode = 'GHI'

-- Para desativar o mirroring via TSQL
-- ALTER DATABASE AdventureWorks2017 SET PARTNER OFF;
