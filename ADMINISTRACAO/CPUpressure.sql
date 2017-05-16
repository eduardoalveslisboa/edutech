
/***CPU -- pressão sobre processador ***/

WITH Waits AS 
( 
SELECT 
wait_type, 
wait_time_ms / 1000. AS wait_time_s, 
100. * wait_time_ms / SUM(wait_time_ms) OVER() AS pct, 
ROW_NUMBER() OVER(ORDER BY wait_time_ms DESC) AS rn 
FROM sys.dm_os_wait_stats 
WHERE wait_type 
NOT IN 
('CLR_SEMAPHORE', 'LAZYWRITER_SLEEP', 'RESOURCE_QUEUE', 
'SLEEP_TASK', 'SLEEP_SYSTEMTASK', 'SQLTRACE_BUFFER_FLUSH', 'WAITFOR', 
'CLR_AUTO_EVENT', 'CLR_MANUAL_EVENT') 
) -- filter out additional irrelevant waits 
SELECT W1.wait_type, 
CAST(W1.wait_time_s AS DECIMAL(12, 2)) AS wait_time_s, 
CAST(W1.pct AS DECIMAL(12, 2)) AS pct, 
CAST(SUM(W2.pct) AS DECIMAL(12, 2)) AS running_pct 
FROM Waits AS W1 
INNER JOIN Waits AS W2 ON W2.rn <= W1.rn 
GROUP BY W1.rn, 
W1.wait_type, 
W1.wait_time_s, 
W1.pct 
HAVING SUM(W2.pct) - W1.pct < 95; -- percentage threshold;


/***MEDIA DE TAREFAS EXECUTANDO EM UM DETERMINADO PROCESSADOR ***/

SELECT AVG(current_tasks_count) AS [Avg Current Task], 
AVG(runnable_tasks_count) AS [Avg Wait Task]
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255
AND status = 'VISIBLE ONLINE'

/*** QUERY ASSOCIADA À CPU ***/


SELECT 
a.scheduler_id ,
b.session_id,
 (SELECT TOP 1 SUBSTRING(s2.text,statement_start_offset / 2+1 , 
      ( (CASE WHEN statement_end_offset = -1 
         THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2) 
         ELSE statement_end_offset END)  - statement_start_offset) / 2+1))  AS sql_statement
FROM sys.dm_os_schedulers a 
INNER JOIN sys.dm_os_tasks b on a.active_worker_address = b.worker_address
INNER JOIN sys.dm_exec_requests c on b.task_address = c.task_address
CROSS APPLY sys.dm_exec_sql_text(c.sql_handle) AS s2 


/*** TAREFAS ATUALMENTE EXECUTANDO ***/


SELECT s2.text, 
session_id,
start_time,
status, 
cpu_time, 
blocking_session_id, 
wait_type,
wait_time, 
wait_resource, 
open_transaction_count
FROM sys.dm_exec_requests a
CROSS APPLY sys.dm_exec_sql_text(a.sql_handle) AS s2  
WHERE status <> 'background'


/*** Quantos processadores estão sendo usados pela instancia ***/

SELECT COUNT(*) AS proc# 
FROM sys.dm_os_schedulers 
WHERE status = 'VISIBLE ONLINE' 
AND is_online = 1


SELECT SUM(signal_wait_time_ms) AS TotalSignalWaitTime ,
( SUM(CAST(signal_wait_time_ms AS NUMERIC(20, 2)))
/ SUM(CAST(wait_time_ms AS NUMERIC(20, 2))) * 100 )
AS PercentageSignalWaitsOfTotalTime
FROM sys.dm_os_wait_stats

/*** Total de tarefas por processador ***/

SELECT scheduler_id ,
current_tasks_count ,
runnable_tasks_count
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255



/***TOP CPU que consomem o banco ***/


SELECT TOP ( 10 )
db_name(st.dbid)DatabaseName,
SUBSTRING(ST.text, ( QS.statement_start_offset / 2 ) + 1,
( ( CASE statement_end_offset
WHEN -1 THEN DATALENGTH(st.text)
ELSE QS.statement_end_offset
END - QS.statement_start_offset ) / 2 ) + 1)
AS statement_text ,
execution_count ,
total_worker_time / 1000 AS total_worker_time_ms ,
( total_worker_time / 1000 ) / execution_count
AS avg_worker_time_ms ,
total_logical_reads ,
total_logical_reads / execution_count AS avg_logical_reads ,
total_elapsed_time / 1000 AS total_elapsed_time_ms ,
( total_elapsed_time / 1000 ) / execution_count
AS avg_elapsed_time_ms ,
qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_worker_time DESC