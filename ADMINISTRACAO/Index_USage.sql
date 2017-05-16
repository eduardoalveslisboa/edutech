
SELECT 	db_name(database_id)Database_name,
	object_name(S.object_id),
	i.name,
	--S.index_id,
	--I.index_id,
	[user_seeks] ,
	[user_scans] ,
	[user_lookups] ,
	[user_updates] ,
	[last_user_seek] ,
	[last_user_scan] ,
	[last_user_lookup] ,
	[last_user_update] ,
	[system_seeks] ,
	[system_scans] ,
	[system_lookups] ,
	[system_updates] ,
	[last_system_seek] ,
	[last_system_scan] ,
	[last_system_lookup] ,
	[last_system_update]  FROM sys.dm_db_index_usage_stats as S inner join sys.indexes as I on S.object_id=i.object_id and S.Index_id=I.Index_id
	where  last_user_seek is null and last_user_lookup is null and last_user_scan is null and db_name(database_id)='Netcardpj'
	


	
	