USe msdb
go
select J.name,J.enabled,category_id,Jsch.freq_type,Jsch.freq_interval,freq_subday_type
,Jsch.active_start_time,j.date_created,j.date_modified,subsystem,command,server
      ,last_run_duration,last_run_date,last_run_time,next_run_date,next_run_time from sysjobs as J inner Join sysjobsteps as St
on j.job_id=St.job_id inner join sysjobschedules as Sch
on J.job_id=Sch.job_id inner Join msdb.dbo.sysschedules as Jsch 
On Sch.schedule_id=Jsch.schedule_id
where subsystem='Distribution' and step_name='Run agent.' and freq_type<>64


