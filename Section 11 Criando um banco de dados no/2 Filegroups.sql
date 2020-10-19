-- CREATE DATABASE DBTeste;

-- Executa o script no contexto da base Master
USE [master]
GO

-- Cria um Filegroup chamado SECONDARY no banco de dados DBTeste
ALTER DATABASE [BDTeste] ADD FILEGROUP [SECONDARY]
GO

-- Cria um arquivo de dados no Filegroup SECONDAY chamado DBTeste_secundario1 que inicia com 8MB de tamanho e pode atingir até 64MB
ALTER DATABASE [BDTeste] ADD FILE ( NAME = N'DBTeste_secundario1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DBTeste_secundario1.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [SECONDARY]
GO