use msdb
go

select Bs.database_name,
'tipo'= case type when 'L' then 'LOG'
				  when 'D' then 'COMPLETO'
				  WHEN 'i' tHEN 'DIFERENCIAL' ELSE TYPE END,BS.backup_finish_date,replace (physical_device_name,'f:\','') from MSDB.DBO.backupmediaset as Bms
				   inner join MSDB.DBO.backupset as BS on bms.media_set_id=bs.media_set_id inner join 
				   MSDB.DBO.backupmediafamily as Mf on BMS.media_set_id=mf.media_set_id
				   where database_name='freeVCS'
order by BS.backup_finish_date desc


--backup database SBOFuncionalCard to disk ='\\fileserver\backup sql\Backup semanal bases sap\SBOFuncionalCard-201405051517FULL.bak' with stats=2


--select * from sys.dm_exec_connections 


replace ('f:\backup\Log\freeVCS'