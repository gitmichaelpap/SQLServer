-- CREATE DATABASE BDTeste;

-- Executa o script no contexto da base Master
USE [master]
GO

-- Cria um Filegroup chamado SECONDARY no banco de dados DBTeste
ALTER DATABASE [BDTeste] ADD FILEGROUP [SECONDARY]
GO

-- Cria um arquivo de dados no Filegroup SECONDAY chamado DBTeste_secundario1 que inicia com 8MB de tamanho e pode atingir até 64MB
ALTER DATABASE [BDTeste] ADD FILE ( NAME = N'DBTeste_secundario1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLDEVELOPER\MSSQL\DATA\DBTeste_secundario1.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [SECONDARY]
GO

USE [BDTeste]
GO

-- Lista os dados do filegroup criado via metadados
SELECT * FROM sys.filegroups WHERE name = N'SECONDARY'

-- Muda o filegroup para somente leitura
ALTER DATABASE [BDTeste] MODIFY FILEGROUP [SECONDARY] READ_ONLY;
GO

-- Tenta criar uma tabela no arquivo somente leitura (vai dar erro)
CREATE TABLE dbo.TabelaSomenteLeitura (id INT, Nome CHAR(8000))
ON [SECONDARY]
GO

-- Volta o filegroup para leitura escrita
ALTER DATABASE [BDTeste] MODIFY FILEGROUP [SECONDARY] READ_WRITE;
GO

-- Deleta a tabela criada
DROP TABLE dbo.TabelaSomenteLeitura;
GO

-- Deleta o banco de dados de testes
USE [master]
GO

DROP DATABASE BDTeste;
GO