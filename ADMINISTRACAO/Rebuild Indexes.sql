SET NOCOUNT ON

DECLARE         @targetPercentFragmentation          smallint

DECLARE         @SQL                                 varchar(8000)

DECLARE         @cnt                                 int

DECLARE         @maxCount                            int

CREATE TABLE #SQLcommand (rowId int identity, sqltext varchar(8000))

SELECT    

    @targetPercentFragmentation          =    20;  
WITH CTE_IndexStats ( ObjectName, IndexName, Index_type_desc,alloc_unit_type_desc, avg_fragmentation_in_percent, avg_fragment_size_in_pages)

AS

(

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

Order By 1 asc

)

INSERT #SQLcommand(SQLTEXT)

SELECT

'ALTER INDEX ' + IndexName + ' ON ' + objectName + ' REBUILD WITH ( ONLINE = OFF)' + CHAR(13)

FROM CTE_IndexStats

WHERE

    alloc_unit_type_desc <> 'LOB_DATA'   AND

    avg_fragmentation_in_percent > @targetPercentFragmentation

UNION ALL

SELECT

'ALTER INDEX ' + IndexName + ' ON ' + objectName + ' REORGANIZE' + CHAR(13)

FROM CTE_IndexStats

WHERE

    alloc_unit_type_desc <> 'LOB_DATA'   AND

    avg_fragmentation_in_percent BETWEEN 5 AND @targetPercentFragmentation;

SELECT @maxCount = max(RowID), @cnt=1 FROM #SQLcommand

WHILE (@cnt <= @maxCount)

BEGIN

    SELECT @SQL = SQLTEXT FROM #SQLcommand WHERE RowId = @cnt

    EXEC (@SQL)

    IF (SELECT DATABASEPROPERTY(db_name(),'ISTruncLog')) = '1'

    BEGIN

          SET @SQL = 'BACKUP LOG [' + db_name() + '] WITH NO_LOG '

          EXEC (@SQL)

    END

    SET @cnt = @cnt+1

END

DROP TABLE #SQLcommand

--	Getting CPU and IO usage data. I store the data in a table and generate CPU and IO trend graphs using reporting services

--	SQL 2005/2008 compatible

INSERT Admin.dbo.CPUIO (dbname, usage, dateCaptured,Type, PercentShare)

SELECT

    db_name,

    sum(total_worker_time) as CPU_Usage,

    getdate() as date_captured,

    'CPU' as [Type],

    CAST(sum(total_worker_time) as numeric(25,12)) / (

          SELECT CAST(sum(total_worker_time) as numeric(25,12)) FROM

               (

                    select  total_worker_time

                    from sys.dm_exec_query_stats s1

                    cross apply sys.dm_exec_sql_text(sql_handle) as  s2

               ) as B) * 100 as PercentShare

FROM (

select  total_worker_time

,       case when db_name(dbid ) is null then 'Adhoc Queries' else  db_name(dbid) end as db_name

,       dbid

,       1 as state

,       1 as msg  

from sys.dm_exec_query_stats s1

cross apply sys.dm_exec_sql_text(sql_handle) as  s2

) as A

GROUP BY db_name

ORDER BY 2 desc

INSERT Admin.dbo.CPUIO (dbname, usage, dateCaptured,Type, PercentShare)

SELECT

    db_name,

    sum(total_io) as IO_Usage,

    getdate() as date_captured,

    'IO' as [Type],

    cast(sum(total_io) as numeric(25,12))/(select cast(sum(total_io) as numeric(25,12)) FROM

    (

          select total_logical_reads + total_logical_writes as  total_io

          from sys.dm_exec_query_stats s1

          cross apply sys.dm_exec_sql_text(sql_handle) as  s2

          ) as b)*100 as percentShare

FROM (

select total_logical_reads + total_logical_writes as  total_io

,       case when db_name(dbid) is null then 'Adhoc Queries' else  db_name(dbid) end as db_name

,       1 as severity

,       1 as state

,       1 as msg  

from sys.dm_exec_query_stats s1

cross apply sys.dm_exec_sql_text(sql_handle) as  s2

) as A

GROUP BY db_name

ORDER BY 2 desc