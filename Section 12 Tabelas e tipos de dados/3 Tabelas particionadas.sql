-- Cria uma partição para particionar a tabela em quatro grupos
CREATE PARTITION FUNCTION pf_OrderDate (datetime)
AS RANGE RIGHT
FOR VALUES ('2003-01-01', '2004-01-01', '2005-01-01')
GO

-- Cria cinco filegroups, sendo um para cada partição e um de reserva (next)
USE [master]
GO
ALTER DATABASE AdventureWorks2017 ADD FILEGROUP fg1;
GO
ALTER DATABASE AdventureWorks2017 ADD FILEGROUP fg2;
GO
ALTER DATABASE AdventureWorks2017 ADD FILEGROUP fg3;
GO
ALTER DATABASE AdventureWorks2017 ADD FILEGROUP fg4;
GO
ALTER DATABASE AdventureWorks2017 ADD FILEGROUP fg5;
GO

-- Cria os data files para os filegroups criados acima
ALTER DATABASE AdventureWorks2017   
ADD FILE   
(  
    NAME = fg1,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\fg1.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP fg1;  
GO 

ALTER DATABASE AdventureWorks2017   
ADD FILE   
(  
    NAME = fg2,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\fg2.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP fg2;  
GO 

ALTER DATABASE AdventureWorks2017   
ADD FILE   
(  
    NAME = fg3,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\fg3.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP fg3;  
GO 

ALTER DATABASE AdventureWorks2017   
ADD FILE   
(  
    NAME = fg4,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\fg4.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP fg4;  
GO 

ALTER DATABASE AdventureWorks2017   
ADD FILE   
(  
    NAME = fg5,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\fg5.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP fg5;  
GO 

USE AdventureWorks2017;
GO

-- Cria um scheme de particionamento para vincular as partições com seus respectivos filegroups
CREATE PARTITION SCHEME ps_OrderDate
AS PARTITION pf_OrderDate
TO (fg1, fg2, fg3, fg4, fg5);
GO

-- Cria uma tabela particionada chamada dbo.PartitionTable. Note que a cláusula ON define o nome do scheme de particionamento e a coluna é passada como parâmetro. 
CREATE TABLE dbo.PartitionTable (Id int, Description nvarchar(100), OrderDate datetime PRIMARY KEY)  
    ON ps_OrderDate (OrderDate) ;  
GO  

-- Por fim, é possível selecionar dados e inserir dados na tabela particionada normalmente
INSERT INTO	dbo.PartitionTable VALUES (1, 'Primeira linha', GETDATE());
INSERT INTO	dbo.PartitionTable VALUES (2, 'Segunda linha', GETDATE());
INSERT INTO	dbo.PartitionTable VALUES (3, 'Terceira linha', GETDATE());

SELECT * FROM dbo.PartitionTable
GO

-- Deleta a tabela, o scheme e a função de particionamento
DROP TABLE dbo.PartitionTable;
DROP PARTITION SCHEME ps_OrderDate;
DROP PARTITION FUNCTION pf_OrderDate;
GO

-- Deleta os datafiles e os filegroups
ALTER DATABASE AdventureWorks2017 REMOVE FILE fg1;
ALTER DATABASE AdventureWorks2017 REMOVE FILE fg2;
ALTER DATABASE AdventureWorks2017 REMOVE FILE fg3;
ALTER DATABASE AdventureWorks2017 REMOVE FILE fg4;
ALTER DATABASE AdventureWorks2017 REMOVE FILE fg5;
GO

ALTER DATABASE AdventureWorks2017 REMOVE FILEGROUP fg1;
ALTER DATABASE AdventureWorks2017 REMOVE FILEGROUP fg2;
ALTER DATABASE AdventureWorks2017 REMOVE FILEGROUP fg3;
ALTER DATABASE AdventureWorks2017 REMOVE FILEGROUP fg4;
ALTER DATABASE AdventureWorks2017 REMOVE FILEGROUP fg5;
GO