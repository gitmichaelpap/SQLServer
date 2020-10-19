/*
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LogSSIS' and xtype='U')
    CREATE TABLE LogSSIS (
        ID INT IDENTITY NOT NULL PRIMARY KEY,
		UltimaExecucao DATETIME NOT NULL
    )
GO

INSERT INTO LogSSIS (UltimaExecucao) VALUES (GETDATE());
*/

SELECT * FROM logssis