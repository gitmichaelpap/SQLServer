-- Este script deve ser testado no SQL Server Developer, uma vez que o Express não possui suporte à políticas de gerenciamento
CREATE DATABASE BDTeste;
GO

USE BDTeste;

CREATE TABLE T1 (ID INT);
GO

CREATE VIEW Teste AS SELECT * FROM T1;
GO

CREATE VIEW vTeste AS SELECT * FROM T1;
GO

SELECT * FROM Teste

USE master
DROP DATABASE BDTeste;
GO