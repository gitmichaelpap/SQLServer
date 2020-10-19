-- Criação de uma tabela para acompanhar a trigger DDL de exemplo
CREATE TABLE [dbo].[ModificacoesDDL](
	[EventDate] [datetime] NOT NULL DEFAULT (getdate()),
	[EventType] [nvarchar](64) NULL,
	[EventDDL] [nvarchar](max) NULL,
	[LoginName] [nvarchar](255) NULL,
	[DatabaseName] [nvarchar](255) NULL,
	[SchemaName] [nvarchar](255) NULL,
	[ObjectName] [nvarchar](255) NULL,
	[HostName] [varchar](64) NULL,
	[IPAddress] [varchar](32) NULL,
	[ProgramName] [nvarchar](255) NULL,
	[EventXML] [xml] NULL
)
GO

-- Cria uma trigger para monitorar diversas alterações no nível da base de dados com criptografia do código
CREATE TRIGGER [trg_Modificacoes_DDL]
ON DATABASE
WITH ENCRYPTION
FOR 
	CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EventData XML = EventData(); 
    DECLARE @ip VARCHAR(32) = (SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id = @@SPID);
 
    INSERT dbo.ModificacoesDDL (EventType, EventDDL, LoginName, DatabaseName, SchemaName, ObjectName, HostName, IPAddress, ProgramName, EventXML)
    SELECT
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]','NVARCHAR(100)')
        ,@EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]','NVARCHAR(MAX)')
		,SUSER_SNAME()        
        ,DB_NAME()
        ,@EventData.value('(/EVENT_INSTANCE/SchemaName)[1]','NVARCHAR(255)')
        ,@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','NVARCHAR(255)')
        ,HOST_NAME()
        ,@ip
        ,PROGRAM_NAME()        
		,@EventData
END
GO

-- Simula a criação de uma tabela de testes
CREATE TABLE dbo.TabelaTestesTriggerDDL (Id Int NULL);
GO

-- Deleta a tabela de testes
DROP TABLE dbo.TabelaTestesTriggerDDL;
GO

-- Verifica se as ações de criação e deleção da tabela de testes foram logadas
SELECT * FROM ModificacoesDDL;

-- Deleta a trigger DDL
DROP TRIGGER [trg_Modificacoes_DDL] ON DATABASE;

-- Deleta a tabela de log da trigger DDL
DROP TABLE ModificacoesDDL;
GO