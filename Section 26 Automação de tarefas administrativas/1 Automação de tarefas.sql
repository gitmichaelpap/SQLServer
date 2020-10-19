-- Criar um operador e um job para execução da seguinte consulta a cada 1 min
USE AdventureWorks2017;
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LogJob' and xtype='U')
    CREATE TABLE LogJob (
        ID INT IDENTITY NOT NULL PRIMARY KEY,
		UltimaExecucao DATETIME NOT NULL
    )
GO

INSERT INTO LogJob (UltimaExecucao) VALUES (GETDATE());

-- SELECT * FROM LogJob

-- DROP TABLE LogJob;