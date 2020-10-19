-- Cria um banco de dados especificando o caminho do datafile do filegroup primário
-- Também, cria dois filegroups chamados ArchivedData e  CurrentData
-- Por fim, determina o caminho do logfile
CREATE DATABASE [BDTeste] ON  PRIMARY 
( NAME = N'BDTeste_Data1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLDEVELOPER\MSSQL\DATA\BDTeste_Data1.mdf' , SIZE = 10240KB , FILEGROWTH = 0), 
 FILEGROUP [ArchivedData] 
( NAME = N'BDTeste_Data3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLDEVELOPER\MSSQL\DATA\BDTeste_Data3.ndf' , SIZE = 25600KB , FILEGROWTH = 0), 
 FILEGROUP [CurrentData] 
( NAME = N'BDTeste_Data2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLDEVELOPER\MSSQL\DATA\BDTeste_Data2.ndf' , SIZE = 10240KB , FILEGROWTH = 0)
 LOG ON 
( NAME = N'BDTeste_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLDEVELOPER\MSSQL\DATA\BDTeste_log.ldf' , SIZE = 10240KB , FILEGROWTH = 0)
GO

/* Modifica o nível de compatibilidade do banco de dados para 90 
100 = SQL Server 2008
110 = SQL Server 2012 (11.x)
120 = SQL Server 2014 (12.x)
130 = SQL Server 2016 (13.x)
140 = SQL Server 2017 (14.x)
150 = SQL Server 2019 (15.x) */
EXEC dbo.sp_dbcmptlevel @dbname=N'BDTeste', @new_cmptlevel=100
GO

-- Exemplo de condição para ativação de um recurso se uma opção estiver ativada
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
	EXEC [BDTeste].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO

-- Modificação de diversas opções no nível da base de dados
ALTER DATABASE [BDTeste] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BDTeste] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BDTeste] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BDTeste] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BDTeste] SET ARITHABORT OFF 
GO
ALTER DATABASE [BDTeste] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BDTeste] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BDTeste] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BDTeste] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BDTeste] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BDTeste] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BDTeste] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BDTeste] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BDTeste] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BDTeste] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BDTeste] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BDTeste] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BDTeste] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BDTeste] SET  READ_WRITE 
GO
ALTER DATABASE [BDTeste] SET RECOVERY FULL 
GO
ALTER DATABASE [BDTeste] SET  MULTI_USER 
GO
ALTER DATABASE [BDTeste] SET PAGE_VERIFY CHECKSUM  
GO

-- Exemplo de definição de filegroup default com condição
USE [BDTeste]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') 
	ALTER DATABASE [BDTeste] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

-- Criando diversos schemas
CREATE SCHEMA Promotions;
GO
CREATE SCHEMA Sponsorship
GO
CREATE SCHEMA PastPromotions
GO
CREATE SCHEMA PastSponsorship
GO

-- Cria a tabela SpecialOffers no schema Promotions
-- Neste exemplo, não informamos um filegroup, logo, ela será criada no Primary
CREATE TABLE Promotions.SpecialOffers
(OfferID int IDENTITY PRIMARY KEY,
 Description nvarchar(200),
 StartDate datetime,
 EndDate datetime, 
 DiscountPercent decimal)
 GO

-- Cria a tabela SpecialOffers no schema PastPromotions (note que a tabela tem mesmo nome em diferentes schemas)
-- Neste exemplo, informamos o filegroup ArchivedData
CREATE TABLE PastPromotions.SpecialOffers
(OfferID int IDENTITY PRIMARY KEY,
 Description nvarchar(200),
 StartDate datetime,
 EndDate datetime, 
 DiscountPercent decimal)
ON ArchivedData
GO

-- Deleta o banco de dados de testes
USE [master]
DROP DATABASE BDTeste;
GO