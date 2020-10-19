-- Habilita a integração com CLR
sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

sp_configure 'clr strict security', 0
GO
RECONFIGURE
GO

-- Registra o assembly
USE AdventureWorks2017

CREATE ASSEMBLY Utilities
FROM 'D:\Projetos\Empresa\Escola Parati\SQL Server\Aulas\Hands-on\Utilities.dll'
WITH PERMISSION_SET = SAFE
GO

-- Deleta o assembly
DROP ASSEMBLY Utilities
GO