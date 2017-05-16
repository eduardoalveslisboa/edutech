CREATE TABLE #xp_results 
  
    ( 
    job_id                UNIQUEIDENTIFIER NOT NULL,   
    last_run_date         INT              NOT NULL,   
    last_run_time         INT              NOT NULL,   
    next_run_date         INT              NOT NULL,   
    next_run_time         INT              NOT NULL,   
    next_run_schedule_id  INT              NOT NULL,   
    requested_to_run      INT              NOT NULL, -- BOOL   
    request_source        INT              NOT NULL,   
    request_source_id     sysname          COLLATE database_default NULL,   
    running               INT              NOT NULL, -- BOOL   
    current_step          INT              NOT NULL,   
    current_retry_attempt INT              NOT NULL,   
    job_state             INT              NOT NULL
    )   
  
INSERT INTO  #xp_results  
EXECUTE master.dbo.xp_sqlagent_enum_jobs 1, 'sa'  
SELECT j.name, * FROM #xp_results r
INNER JOIN msdb..sysjobs j
ON r.job_id = j.job_id
WHERE running = 1

drop table #xp_results