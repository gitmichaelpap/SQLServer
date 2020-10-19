-- Estrutura da tabela criada na instância do Linux
/*
CREATE TABLE TabelaLinux (id INT, descricao NVARCHAR(100));

INSERT INTO TabelaLinux VALUES (1, 'Linux');
INSERT INTO TabelaLinux VALUES (2, 'SQL Express');
INSERT INTO TabelaLinux VALUES (3, 'Ubuntu');
*/

-- IP Linux: 192.168.91.129
-- Login: teste
-- Senha: 123456
SELECT * FROM dbo.TabelaLinux

-- Ativacao de consultas distribuidas ad hoc
sp_configure 'show advanced options', 1;  
RECONFIGURE;
GO 
sp_configure 'Ad Hoc Distributed Queries', 1;  
RECONFIGURE;  
GO 

-- Consulta distribuida via Ad Hoc
SELECT a.*  
FROM OPENROWSET('MSDASQL', 'DRIVER={SQL SERVER};SERVER=192.168.91.129;UID=teste;PWD=123456',
     'SELECT * FROM AdventureWorks2017.dbo.TabelaLinux') AS a;  
GO  

-- Criação de um Linked Server para acessar o Linux
USE [master]  
GO  
EXEC master.dbo.sp_addlinkedserver   
    @server = N'192.168.91.129',   
    @srvproduct=N'SQL Server' ;  
GO 

EXEC master.dbo.sp_addlinkedsrvlogin   
    @rmtsrvname = N'192.168.91.129',   
    @locallogin = NULL ,   
	@rmtuser = 'teste', 
	@rmtpassword = '123456', 
    @useself = N'False' ;  
GO 

-- Utilizando o Linked Server com nome qualificado (4 partes)
SELECT * FROM [192.168.91.129].AdventureWorks2017.dbo.TabelaLinux