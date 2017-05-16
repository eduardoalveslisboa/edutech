SELECT schema_name(schema_id) AS SchemaName,  object_name(o.object_id) AS ObjectName, 
    i.name AS IndexName, index_id, o.type, 
    STATS_DATE(o.object_id, index_id) AS statistics_update_date 
FROM sys.indexes i join sys.objects o 
       on i.object_id = o.object_id 
WHERE o.object_id > 100 AND index_id > 0 
  AND is_ms_shipped = 0;