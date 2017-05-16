/****AUTOR : MARCIO PENNA       ****/


/***** LISTA INDICES FRAGMENTADOS****/

select distinct TOP 100 PERCENT S.name Table_Schema
,                               I.name Indice
,                               object_name(a.object_id) Tabela
,                               index_type_desc TipoIndices
,                               avg_fragmentation_in_percent
,                               sts.Last_user_scan
,                               sts.Last_user_seek
,                               sts.Last_user_lookup
,                               a.fragment_count
,                               a.page_count
from       sys.dm_db_index_physical_stats (db_id(), NULL ,NULL, NULL,Null) as A  
INNER JOIN sys.objects                                                  o   ON o.object_id = A.object_id AND o.type='U'
INNER JOIN sys.indexes                                                  i   ON i.object_id = a.object_id AND i.index_id = a.index_id
INNER JOIN sys.schemas                                                  s   ON s.schema_id = o.schema_id
		AND OBJECTPROPERTY(a.object_id, 'ISMSSHIPPED') = 0
		AND i.name IS NOT NULL
INNER JOIN sys.dm_db_index_usage_stats                               AS Sts ON i.object_id = Sts.object_id AND i.index_id = Sts.index_id and Sts.Database_id=A.Database_id
where Avg_Fragmentation_in_percent>29 
and   (sts.Last_user_seek is not null
or   sts.Last_user_scan is not null
or   sts.Last_user_lookup is not null)
Order By 1 asc






/***** GERA SCRIPT PARA DEFRAGMENTAÇÃO DE TABELAS ****/

select TOP 100 PERCENT 'ALTER INDEX '+ QUOTENAME(i.name) +' ON '+QUOTENAME(s.name) + '.' + QUOTENAME(OBJECT_NAME(a.object_id))+ ' REORGANIZE'
from       sys.dm_db_index_physical_stats (db_id(), NULL ,NULL, NULL,Null) as A
INNER JOIN sys.objects                                                              o ON o.object_id = A.object_id AND o.type='U'
INNER JOIN sys.indexes                                                              i ON i.object_id = a.object_id AND i.index_id = a.index_id
INNER JOIN sys.schemas                                                              s ON s.schema_id = o.schema_id
		AND OBJECTPROPERTY(a.object_id, 'ISMSSHIPPED') = 0
		AND i.name IS NOT NULL
INNER JOIN sys.dm_db_index_usage_stats                               AS Sts ON i.object_id = Sts.object_id AND i.index_id = Sts.index_id and Sts.Database_id=A.Database_id
where Avg_Fragmentation_in_percent>29 
and   (sts.Last_user_seek is not null
or   sts.Last_user_scan is not null
or   sts.Last_user_lookup is not null)
Order By 1 asc

