USE msdb
GO

IF EXISTS(SELECT * FROM TEMPDB.sys.tables WHERE name LIKE '%#JOBS%')
BEGIN
DROP TABLE #JOBS
END 
CREATE TABLE #JOBS(ID INT IDENTITY (1,1),JOB_ID nvarchar(max),name sysname)
INSERT INTO #JOBS
SELECT JOB_ID,NAME FROM SYSJOBS WHERE enabled=1
SELECT * FROM #JOBS 

DECLARE @ID INT
DECLARE @ID_MAX INT

SELECT @ID=MIN(ID) FROM #JOBS
SELECT @ID_MAX=MAX(ID) FROM #JOBS


SELECT @ID
SELECT @ID_MAX

IF EXISTS(SELECT * FROM TEMPDB.sys.tables WHERE name LIKE '%#MONITORJOBS%')
BEGIN
DROP TABLE #MONITORJOBS
END 


CREATE TABLE #MONITORJOBS (NOME SYSNAME,ATIVADO VARCHAR(20),PASSO_INICIADOR INT,INSTANCE_ID INT, STEP_ID INT,"MESSAGE" NVARCHAR(4000),RUN_DATE INT,STATUS VARCHAR(100),
						   TEMPO_EXECUCAO INT,DURACAO INT,SERVIDOR VARCHAR(100),DATA_REQUISICAO DATETIME,REQUISITOR VARCHAR(100),INICIO_EXECUCAO DATETIME,ULTIMO_PASSO_EXECUTADO INT,
						   DATA_EXECUCAO_ULTIMO_PASSO DATETIME,DATA_PARADA_EXECUCAO DATETIME)

WHILE @ID<@ID_MAX
BEGIN

INSERT #MONITORJOBS
SELECT DISTINCT J.name NOME , 
       J.enabled ATIVADO ,
       j.start_step_id PASSO_INICIADOR,
       h.instance_id,
       H.step_id PASSO,
       h.message MENSAGEM,
       H.run_date,
       'STATUS'=case h.run_status 
						WHEN 0 THEN 'FALHOU'
                        WHEN 1 THEN 'SUCESSO'
                        WHEN 2 THEN 'TENTAR NOVAMENTE'
                        WHEN 3 THEN 'CANCELADO'
                        WHEN 4 THEN 'RODANDO' END,
       h.run_time TEMPO_EXECUCAO,
       h.run_duration DURACAO,
       h.server SERVIDOR ,
       a.run_requested_date DATA_REQUISICAO,
       'REQUISITOR'= CASE a.run_requested_source WHEN 1 THEN 'SOURCE_SCHEDULER' 
						                         WHEN 2 THEN 'SOURCE_ALERTER'
						                         WHEN 3 THEN 'SOURCE_BOOT'
						                         WHEN 4 THEN 'SOURCE_USER' 
						                         WHEN 5 THEN 'SOURCE_ON_IDLE_SCHEDULE' END ,     
       a.start_execution_date INICIO_EXECUCAO,
       a.last_executed_step_id ULTIMO_PASSO_EXECUTADO,
       a.last_executed_step_date DATA_EXECUCAO_ULTIMO_PASSO,
       a.stop_execution_date DATA_PARADA_EXECUCAO
                              FROM sysjobs J WITH (NOLOCK)inner join sysjobhistory h WITH (NOLOCK) ON j.job_id=h.job_id 
                                             inner join sysjobactivity a WITH (NOLOCK) ON h.job_id=a.job_id
                                              join 
                                             (SELECT DISTINCT h.JOB_ID ,
                                              max(A.run_requested_date) OVER (PARTITION BY J.JOB_ID)run_requested_date,                                        
                                              max( H.instance_id) over (partition by  j.job_id) instance_id                                              
                                              FROM sysjobs J WITH (NOLOCK)inner join sysjobhistory h WITH (NOLOCK) ON j.job_id=h.job_id 
                                              inner join sysjobactivity a WITH (NOLOCK) ON h.job_id=a.job_id 
                                              WHERE j.name =(SELECT NAME FROM #JOBS WHERE ID=@ID) AND J.enabled=1) as M 
                                              on m.run_requested_date=a.run_requested_date 
                                              and h.instance_id=m.instance_id
                                              where J.enabled=1 and J.name is not null
                                              order by nome
   SET @ID=@ID+1                                           
                                              
                                              
 END  
 SELECT * FROM #MONITORJOBS                                  