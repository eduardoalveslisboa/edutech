


/**************************************************************************************
       Data de criação :28/06/2014
       Autor Criação  : Marcio Penna
       Objetivo da criação: MonitorarCPU dos servidores de bancos de dados SQL
       Sistemas que utilizam : Reporting Services
       Histórico:  
       Data de alteração   Autor                      Linhas Alteradas           Objetivo  

       **************************************************************************************/


ALTER PROCEDURE MONITORACPU @ServerName nvarchar(128)
AS
	EXEC('DECLARE @ms_now bigint SELECT  @ms_now = ms_ticks
FROM  '+@ServerName+'.monitorsql.sys.dm_os_sys_info;
SELECT        TOP 50 record_id, dateadd(ms, - 1 * (@ms_now - [timestamp]), GetDate()) AS EventTime, SQLProcessUtilization, 
 SystemIdle, 80 as Target,100 - SystemIdle - SQLProcessUtilization AS OtherProcessUtilization
FROM      (SELECT        record.value(''(./Record/@id)[1]'', ''int'') AS record_id, record.value(''(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]'', ''int'') AS SystemIdle,
                         record.value(''(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]'', ''int'') 
AS SQLProcessUtilization, timestamp
FROM  (SELECT        timestamp, CONVERT(xml, record) AS record
FROM   ['+@ServerName+'].monitorsql.sys.dm_os_ring_buffers WHERE  ring_buffer_type = N''RING_BUFFER_SCHEDULER_MONITOR'' AND  record LIKE ''%<SystemHealth>%'') AS x) AS y
ORDER BY record_id DESC')
