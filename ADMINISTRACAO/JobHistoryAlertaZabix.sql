


USE msdb
GO

DECLARE @CMD NVARCHAR(4000)

SET @CMD='
SELECT DISTINCT 
       h.server SERVIDOR ,
       J.name NOME ,
       h.instance_id,
       H.run_date,
       ''STATUS''=case h.run_status 
						WHEN 0 THEN ''FALHOU''
                        WHEN 1 THEN ''SUCESSO''
                        WHEN 2 THEN ''TENTAR NOVAMENTE''
                        WHEN 3 THEN ''CANCELADO''
                        WHEN 4 THEN ''RODANDO'' END,
       h.run_duration DURACAO,
       a.run_requested_date DATA_REQUISICAO,    
       a.start_execution_date INICIO_EXECUCAO,
       a.last_executed_step_id ULTIMO_PASSO_EXECUTADO,
       a.last_executed_step_date DATA_EXECUCAO_ULTIMO_PASSO,
       a.stop_execution_date DATA_PARADA_EXECUCAO,a.next_scheduled_run_date
                              FROM sysjobs J WITH (NOLOCK)inner join sysjobhistory h WITH (NOLOCK) ON j.job_id=h.job_id 
                                             inner join sysjobactivity a WITH (NOLOCK) ON h.job_id=a.job_id
                                              join 
                                             (SELECT DISTINCT h.JOB_ID ,
                                              max(A.run_requested_date) OVER (PARTITION BY J.JOB_ID)run_requested_date,                                        
                                              max( H.instance_id) over (partition by  j.job_id) instance_id                                              
                                              FROM sysjobs J WITH (NOLOCK)inner join sysjobhistory h WITH (NOLOCK) ON j.job_id=h.job_id 
                                              inner join sysjobactivity a WITH (NOLOCK) ON h.job_id=a.job_id
                                              ) as M 
                                              on m.run_requested_date=a.run_requested_date 
                                              and h.instance_id=m.instance_id
                                              where J.enabled=1
                                              order by nome'
                                              
                                              
EXEC SP_EXECUTESQL @CMD
                                              

                                             
