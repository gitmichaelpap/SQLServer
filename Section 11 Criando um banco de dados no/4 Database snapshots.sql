-- Cria um database snapshot para o banco de dados AdventureWorks2017 chamado AdventureWorks2017_dbss1800
CREATE DATABASE AdventureWorks2017_dbss1800 ON  
( NAME = AdventureWorks2017, FILENAME =   
'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AdventureWorks2017_data_1800.ss' )  
AS SNAPSHOT OF AdventureWorks2017;  
GO  

-- Entra no contexto do snapshot criado acima
USE AdventureWorks2017_dbss1800;
GO

-- Lista os dados da tabela no snapshot
SELECT * FROM HumanResources.JobCandidate;
GO

-- Entra no contexto da base real
USE AdventureWorks2017;
GO

-- Lista os dados da tabela da base real
SELECT * FROM HumanResources.JobCandidate;
GO

-- Deleta a tabela na base real
DROP TABLE HumanResources.JobCandidate;
GO

-- Restaura a base de dados real com dados do snapshot para recuperar a tabela deletada
USE master;  
RESTORE DATABASE AdventureWorks2017 from   
DATABASE_SNAPSHOT = 'AdventureWorks2017_dbss1800';  
GO

-- Deleta o snapshot criado
USE master;
DROP DATABASE AdventureWorks2017_dbss1800;
GO