-- Entra na base sem criptografia e tenta acessar dados da tabela Person.Person
USE AdventureWorks2017;  
SELECT * FROM Person.Person

-- Entra na base master
USE master;  
GO  

-- Cria uma chave master com uma senha escolhida forte
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<UseStrongPasswordHere>';  
GO  

-- Realiza o backup da master
-- Armazene o arquivo gerado em um local seguro
OPEN MASTER KEY DECRYPTION BY PASSWORD = '<UseStrongPasswordHere>';   

BACKUP MASTER KEY TO FILE = 'd:\temp\masterkey_sqldev'   
    ENCRYPTION BY PASSWORD = '<UseStrongPasswordHere>';   
GO  

-- Cria um certificado 
CREATE CERTIFICATE MyServerCert WITH SUBJECT = 'My DEK Certificate';  
GO  

-- Realiza o backup do certificado
-- Armazene o arquivo gerado em um local seguro
BACKUP CERTIFICATE MyServerCert TO FILE = 'd:\temp\certificate_sqldev';  
GO  

-- Entra no contexto da base a ser criptografada
USE AdventureWorks2017;  
GO  

-- Cria a chave de criptografia usando o certificado acima
CREATE DATABASE ENCRYPTION KEY  
WITH ALGORITHM = AES_128  
ENCRYPTION BY SERVER CERTIFICATE MyServerCert;  
GO  

-- Por fim, seta a criptografia para ON na base
ALTER DATABASE AdventureWorks2017  
SET ENCRYPTION ON;  
GO  

-- Acessa novamente os dados da tabela Person.Person. Note que eles são exibidos normalmente
-- Mas, se alguem tiver acesso aos arquivos de dados e fizer o attach em outra máquina, não conseguirão ler 
SELECT * FROM Person.Person

/*
-- Dica
-- Se der problema na base e você precisar recriar a master e o certificado 
RESTORE MASTER KEY FROM FILE = 'd:\temp\masterkey_sqldev'   
DECRYPTION BY PASSWORD = '<UseStrongPasswordHere>'  

CREATE CERTIFICATE MyServerCert   
    FROM FILE = 'd:\temp\certificate_sqldev'   
    WITH PRIVATE KEY (FILE = 'd:\temp\masterkey_sqldev',   
    DECRYPTION BY PASSWORD = '<UseStrongPasswordHere>');  
GO 
*/

-- Removendo a criptografia da base
ALTER DATABASE AdventureWorks2017  
SET ENCRYPTION OFF;  
GO 

-- Deletando os objetos
USE master
DROP DATABASE AdventureWorks2017
DROP CERTIFICATE MyServerCert
DROP MASTER KEY
GO