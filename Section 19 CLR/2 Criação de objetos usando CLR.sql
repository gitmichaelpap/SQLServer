-- Habilita a integração com CLR
sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

-- Registra um novo assembly
USE AdventureWorks2017

CREATE ASSEMBLY Utilities
FROM 'D:\Projetos\Empresa\Escola Parati\SQL Server\Aulas\Hands-on\Utilities.dll'
WITH PERMISSION_SET = Safe
GO

-- Cria uma função usando o CLR importado acima
CREATE FUNCTION dbo.ufn_GetOSVersion()
RETURNS NVARCHAR(50) 
AS EXTERNAL NAME Utilities.UserDefinedFunctions.GetOSVersion 
GO

-- Testa a função criada via CLR
SELECT dbo.ufn_GetOSVersion()
GO

-- Cria um tipo de dados usando o CLR importado acima
CREATE TYPE PointType
EXTERNAL NAME Utilities.Point
GO

-- Testa o tipo de dados criado via CLR declarando uma variável
DECLARE @P PointType
SET @P = '1,5'
SELECT @P.X AS X, @P.Y AS Y
GO

-- Testa o tipo de dados criado via CLR por meio de uma nova tabela
CREATE TABLE dbo.Points 
(ID int IDENTITY(1,1) PRIMARY KEY, PointValue PointType)
GO

INSERT INTO dbo.Points (PointValue) VALUES (CONVERT(PointType, '3,4'));
INSERT INTO dbo.Points (PointValue) VALUES (CONVERT(PointType, '1,5'));
INSERT INTO dbo.Points (PointValue) VALUES (CAST ('1,99' AS PointType));

SELECT	ID, 
		PointValue.X AS X, 
		PointValue.Y AS Y, 
		PointValue.ToString() AS String  
FROM	dbo.Points
GO

-- Deleta os objetos criados
DROP TABLE dbo.Points
DROP FUNCTION dbo.ufn_GetOSVersion
DROP TYPE PointType
DROP ASSEMBLY Utilities
GO