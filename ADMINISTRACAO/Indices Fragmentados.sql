select  TOP 100 PERCENT
    QUOTENAME(s.name) + '.' + QUOTENAME(OBJECT_NAME(a.object_id)) ObjectName,
    QUOTENAME(i.name) as IndexName,
    index_type_desc,
    alloc_unit_type_desc,
    avg_fragmentation_in_percent,
    avg_fragment_size_in_pages
from
    sys.dm_db_index_physical_stats(db_id(db_name()), NULL ,NULL, NULL, NULL) A
    INNER JOIN      sys.objects o   ON o.object_id = A.object_id    AND o.type='U'
    INNER JOIN      sys.indexes i   ON i.object_id = a.object_id    AND i.index_id = a.index_id
    INNER JOIN      sys.schemas s   ON s.schema_id = o.schema_id
    AND        OBJECTPROPERTY(a.object_id, 'ISMSSHIPPED') = 0
    AND        i.name IS NOT NULL
	where Avg_Fragmentation_in_percent>29
Order By 1 asc

/*
ALTER INDEX [IdxN_Chave1]							ON t_TRANSACAO			REORGANIZE
ALTER INDEX [IDX_NNV]								ON t_TRANSACAO			REORGANIZE
ALTER INDEX [PK__t_Detalh__F677B4572C29722F]		ON t_DETALHETRANSACAO	REORGANIZE
*/