exec sp_MSforeachdb 'use [?] ; select ''?'' DatabaseName,object_name(T0.object_id) ProcedureName,* from sys.sql_modules T0
inner join sys.objects T1
on T0.object_id=t1.object_id
where definition like ''%tiptra%'' and T1.type =''p'' and object_name(T0.object_id) not like ''sp_MS%'''