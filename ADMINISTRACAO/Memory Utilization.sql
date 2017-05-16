


/*Query 1*/
SELECT DB_NAME(DATABASE_ID) DatabaseName
,      COUNT_BIG(*) Memory_Used_MB
FROM sys.dm_os_buffer_descriptors
GROUP BY DB_NAME(DATABASE_ID)
ORDER BY 2 DESC




-- Requer permissão VIEW_SERVER_STATE .

DECLARE @total_buffer INT;

SELECT @total_buffer = cntr_value
FROM sys.dm_os_performance_counters
WHERE RTRIM([object_name]) LIKE '%Buffer Manager'
	AND counter_name = 'Database Pages';

;WITH src
AS
(
	SELECT database_id
	,      db_buffer_pages = COUNT_BIG(*)
	FROM sys.dm_os_buffer_descriptors
	--WHERE database_id BETWEEN 5 AND 32766
	GROUP BY database_id
)
SELECT [db_name] = CASE [database_id] WHEN 32767 THEN 'Resource DB'
                                                 ELSE DB_NAME([database_id]) END
,      db_buffer_pages
,      db_buffer_MB = (db_buffer_pages*8) / 1024
,      db_buffer_percent = CONVERT(DECIMAL(6,3),
db_buffer_pages * 100.0 / @total_buffer)
FROM src
ORDER BY db_buffer_MB DESC;


/*Detectando Objeto */


;WITH src
AS
(
	SELECT [Object] = o.name
	,      [Type] = o.type_desc
	,      [Index] = COALESCE(i.name, '')
	,      [Index_Type] = i.type_desc
	,      p.[object_id]
	,      p.index_id
	,      au.allocation_unit_id
	FROM       sys.partitions       AS p 
	INNER JOIN sys.allocation_units AS au ON p.hobt_id = au.container_id
	INNER JOIN sys.objects          AS o  ON p.[object_id] = o.[object_id]
	INNER JOIN sys.indexes          AS i  ON o.[object_id] = i.[object_id]
			AND p.index_id = i.index_id
	WHERE au.[type] IN (1,2,3)
		AND o.is_ms_shipped = 0
)
SELECT src.[Object]
,      src.[Type]
,      src.[Index]
,      src.Index_Type
,      buffer_pages = COUNT_BIG(b.page_id)
,      buffer_mb = COUNT_BIG(b.page_id) / 128
FROM       src                              
INNER JOIN sys.dm_os_buffer_descriptors AS b ON src.allocation_unit_id = b.allocation_unit_id
WHERE b.database_id = DB_ID()
GROUP BY src.[Object]
,        src.[Type]
,        src.[Index]
,        src.Index_Type
ORDER BY buffer_pages DESC;


---3623128
/*** Tamanho de tabela e indices ***/

SELECT OBJECT_NAME(ID) As Objeto, Rows As Linhas,
        Reserved * 8 As Reservado, DPages * 8 As Dados,
        (Used - DPages) * 8 As Indice,
        (Reserved - Used) * 8 As NaoUtilizado,

        (SELECT SUM(Reserved * 8) FROM SYSINDEXES As TInt
        WHERE TOut.ID = TInt.ID AND
        IndID >= 1 AND NAME NOT LIKE '_WA%') As ReservadoNC,

        (SELECT SUM(Used * 8) FROM SYSINDEXES As TInt
        WHERE TOut.ID = TInt.ID AND
        IndID >= 1 AND NAME NOT LIKE '_WA%') As AlocadoNC,

        (SELECT SUM((Reserved - Used) * 8) FROM SYSINDEXES As TInt
        WHERE TOut.ID = TInt.ID AND
        IndID >= 1 AND NAME NOT LIKE '_WA%') As NaoAlocadoNC

FROM SYSINDEXES AS TOut

WHERE
    ID IN (SELECT ID FROM SYSOBJECTS WHERE NAME LIKE 'Log_venda')
    AND IndID IN (0,1) AND (NAME NOT LIKE '_WA%' OR NAME IS NULL)
	--AND Tout.name='_dta_index_pre_aut_9_1842157658__K8_K9_K2_K7_K1_K5_K6_K4_21'

/***Espaço usado pelo indices Não Cluster ***/


SELECT RESERVED*8/1024 [EspaçoAlocadoMB]
,      dpages*8/1024 [EspaçoUsadoMB]
,      name
FROM SYS.SYSINDEXES
WHERE OBJECT_NAME(ID)='PRE_aut'
	AND indid >1
	AND NAME NOT LIKE '_WA%'
	and name='_dta_index_pre_aut_9_1842157658__K8_K9_K2_K7_K1_K5_K6_K4_21'


	/*** espaço usado por indice não cluster***/

	SELECT sum(RESERVED)*8/1024 [EspaçoAlocadoMB]
,      sum(dpages)*8/1024 [EspaçoUsadoMB]
--,      name

FROM SYS.SYSINDEXES
WHERE 
    --OBJECT_NAME(ID)='PRE_aut'
	--AND 
	indid >1
	AND NAME NOT LIKE '_WA%'