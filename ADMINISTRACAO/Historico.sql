alter PROCEDURE [dbo].[USP_BACKUPHISTORY] 
@SERVERNAME SYSNAME,
@BACKUPTIPO SYSNAME,
@Datade varchar(100),
@Dataate varchar(100)
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @SQL NVARCHAR(MAX)
				SET @SQL=('select backup_start_date,backup_finish_date,database_name,
                         ''tipo''= case type when ''L'' then ''LOG''
				          when ''D'' then ''COMPLETO''
				          WHEN ''i'' tHEN ''DIFERENCIAL'' ELSE TYPE END,datediff (MINUTE,backup_start_date,backup_finish_date) DiferencaMinutos
				          ,compressed_backup_size/1024.0/1024.0/1024.0 Database_size,physical_device_name from '+quotename(@Servername)+'.MSDB.dbo.backupmediaset as Bms
				           inner join '+quotename(@Servername)+'.MSDB.dbo.backupset as BS on bms.media_set_id=bs.media_set_id inner join '+quotename(@Servername)+'.MSDB.dbo.backupmediafamily as Mf on BMS.media_set_id=mf.media_set_id 	 
				 where backup_start_date >='''+convert(varchar,@Datade,103)+''' and backup_finish_date <='''+convert(varchar,@Dataate,103)+''' and type=case '''+@BACKUPTIPO+''' WHEN ''LOG'' THEN ''L'' WHEN ''DIFERENCIAL'' THEN ''I'' WHEN ''COMPLETO'' THEN ''D'' ELSE TYPE END
				 and Database_name not in (''db1'',''db2'')
				  order by 1 desc')
						 EXEC sp_executesql @SQL
						 print @sql
		end

		