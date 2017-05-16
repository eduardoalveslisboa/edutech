  --exec master..xp_fixeddrives
  
  /* Monitora o processo sendo executado ### Marcio Penna ###*/
  Declare @cmd varchar(200),        
  @db sysname ,        
  @ip varchar(15) ,       
  @srvorigem varchar(20) ,        
  @loginame varchar(50),       
  @login_time datetime ,     
  @spid int ,        
  @blocked int,
  @typecmd varchar(100) ,    
  @program_name varchar(1000) 
 
  Set @cmd = ''     
  set @db = ''    
  set @ip = ''      
  set @srvorigem =''      
  set @loginame = ''      
  set @login_time = ''   
  set @spid = ''   
  set @blocked =''     
  set @typecmd = ''       
  set @program_name = ''            
        
select case when a.open_tran = 1 and a.status = 'sleeping' then 'DBA: Transação aberta (Begin Tran) mas em sleeping!' else convert(varchar(max),SUBSTRING( text,          
    COALESCE(NULLIF(stmt_start/2, 0), 1),          
CASE CASE WHEN stmt_end = -1 THEN -1 ELSE stmt_end/2 END           
       WHEN -1           
      THEN DATALENGTH(text)           
     ELSE      
    (CASE WHEN stmt_end = -1 THEN -1 ELSE stmt_end/2 END - stmt_start/2) END)) end AS cmd,WAIT_RESOURCE,
    sum(b.percent_complete) as [percent_complete],  estimated_completion_time/1000/60 'estimated_conclusion_min',getdate() as eventdate, sum(cpu) as CPU, CAST([CPU] * 1.0 / SUM([CPU]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [CPUPercent],isnull(sum(e.requested_memory_kb),0)as requested_memory_kb,CAST([granted_memory_kb] * 1.0 / SUM([granted_memory_kb]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [MemoryPercent],      
    sum(logical_reads) as logical_reads, sum(reads) as reads, sum(writes) as writes, spid, a.blocked, datediff(mi,a.login_time,getdate()) as Min_Conectado,  datediff(mi,a.last_batch,getdate()) as duration_m,    
    object_name(g.objectid,g.dbid) as objectname,
    db_name(a.dbid) as db,a.loginame,a.program_name,      
   isnull(case when a.program_name like 'SSIS%' then 'Job-Package' else f.name end,'NÃO JOB') as job_name,a.hostname,c.client_net_address as IP,b.wait_type,b.last_wait_type,a.cmd as typecmd, a.login_time ,granted_query_memory
  
 from sys.sysprocesses a         
   left join sys.dm_exec_requests b on a.spid = b.session_id        
   inner join sys.dm_exec_connections c on a.spid = c.session_id        
   cross apply sys.dm_exec_sql_text (a.sql_handle) g           
   left join sys.dm_exec_query_memory_grants e on a.spid = e.session_id        
   left join msdb.dbo.sysjobs f on f.job_id = case when a.program_name like 'SQLAgent - TSQL%'      
   then SUBSTRING(program_name,38,2) +      
     SUBSTRING(program_name,36,2) +      
     SUBSTRING(program_name,34,2) +      
     SUBSTRING(program_name,32,2) + '-' +      
     SUBSTRING(program_name,42,2) +      
     SUBSTRING(program_name,40,2) + '-' +      
     SUBSTRING(program_name,44,2) + '-' +      
     SUBSTRING(program_name,48,4) + '-' +      
     SUBSTRING(program_name,52,12) end       
where case when a.open_tran = 1 and a.status = 'sleeping' then 'open_tran' else a.status end <> 'sleeping' and a.spid <> @@spid        
group by WAIT_RESOURCE,case when a.open_tran = 1 and a.status = 'sleeping' then 'DBA: Transação aberta (Begin Tran) mas em sleeping!' else convert(varchar(max),SUBSTRING( text,          
    COALESCE(NULLIF(stmt_start/2, 0), 1),          
   CASE CASE WHEN stmt_end = -1 THEN -1 ELSE stmt_end/2 END           
       WHEN -1           
      THEN DATALENGTH(text)            
     ELSE      
    (CASE WHEN stmt_end = -1 THEN -1 ELSE stmt_end/2 END - stmt_start/2) END)) end,db_name(a.dbid),a.cmd,a.hostname,c.client_net_address,  b.wait_type,b.last_wait_type,      
          a.loginame,a.login_time,object_name(g.objectid,g.dbid),a.spid,a.blocked,a.program_name,isnull(case when a.program_name like 'SSIS%' then 'Job-Package' else f.name end,'NÃO JOB'),last_batch,estimated_completion_time,cpu,granted_query_memory,granted_memory_kb ORDER BY memoryPercent DESC
