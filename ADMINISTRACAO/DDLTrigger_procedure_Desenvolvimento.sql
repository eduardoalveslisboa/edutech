USE [MONITORSQL]
GO

/****** Object:  DdlTrigger [DDLTrigger_procedure]    Script Date: 07/22/2014 11:13:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
--DROP TRIGGER  DDLTrigger_procedure on database
GO
CREATE TRIGGER [DDLTriggerMonitor]

ON ALL SERVER
WITH EXECUTE as 'AuditDB', ENCRYPTION
FOR DDL_EVENTS
AS
--    ON DATABASE
--    WITH EXECUTE as 'AuditDB'
--    FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE,RENAME,ALTER_SCHEMA
--AS
SET NOCOUNT ON
BEGIN

	IF PROGRAM_NAME()<>'Microsoft SQL Server Management Studio - Query'
	BEGIN
    SET NOCOUNT ON;
    DECLARE
        @EventData XML = EVENTDATA();
 
    DECLARE 
        @ip VARCHAR(32) =
        (
            SELECT client_net_address
                FROM sys.dm_exec_connections
                WHERE session_id = @@SPID
        );
 
    INSERT MonitorSQL.dbo.DDLEvents
    (
        EventType,
        EventDDL,
        EventXML,
        DatabaseName,
        SchemaName,
        ObjectName,
        HostName,
        IPAddress,
        ProgramName,
        LoginName
    )
    SELECT
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'), 
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        @EventData,
        DB_NAME(),
        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'), 
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
        HOST_NAME(),
        @ip,
        PROGRAM_NAME(),
        ORIGINAL_LOGIN();
		END
		ELSE
		PRINT 'PERMITIDA ALTERAÇÃO APENAS PELO SOURCESAFE'
END

GO




