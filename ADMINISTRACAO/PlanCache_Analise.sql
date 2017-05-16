/*

    SELECT * FROM sys.dm_os_performance_counters
    WHERE object_name = 'SQLServer:Plan cache'
    AND counter_name in ('Cache Hit Ratio','Cache Hit Ratio Base')

*/


/* PLAN CACHE HIT HATIO */
;WITH PlanCacheHitRatio AS
(
    SELECT ROW_NUMBER() OVER (PARTITION BY instance_name ORDER BY Counter_name) AS SEQ,* 
    FROM sys.dm_os_performance_counters
    WHERE object_name = 'SQLServer:Plan cache'
    and counter_name in ('Cache Hit Ratio','Cache Hit Ratio Base')
)
SELECT P.object_name,P.counter_name, p.instance_name,((P.cntr_value * 100) / P2.cntr_value) AS PlanCacheHitRatio
,P.cntr_value AS ContadorTotal,P2.cntr_value AS ContadorBase,p2.counter_name
FROM PlanCacheHitRatio AS P
INNER JOIN PlanCacheHitRatio AS P2 ON P.SEQ = P2.SEQ - 1 AND P.instance_name = P2.instance_name




/* Ad/Hoc Versus Procedures Porcentagem */
;WITH CACHE_STATS AS 
(
    SELECT 
    cast(SUM(case when Objtype ='Proc'  then 1 else 0 end) as DECIMAL (10,2)) as [Proc],
    cast(SUM(case when Objtype ='AdHoc'  then 1 else 0 end) as DECIMAL (10,2)) as [Adhoc],
    cast(SUM(case when Objtype ='Proc' or Objtype ='AdHoc' then 1 else 0 end)as DECIMAL (10,2)) as [Total]
    FROM sys.dm_exec_cached_plans 
    WHERE cacheobjtype='Compiled Plan' 
)
SELECT
cast(Adhoc/Total as decimal (5,2)) * 100 as Adhoc_pct,
cast([Proc]  /Total as decimal (5,2)) * 100 as Proc_Pct
FROM CACHE_STATS as c


/* Quantidade de memória alocada dentro do PLAN CACHE */
;WITH CACHE_ALLOC AS
(
    SELECT  objtype AS [CacheType]
    ,COUNT_BIG(objtype) AS [Total Plans]
    , sum(cast(size_in_bytes as decimal(18,2)))/1024/1024 AS [Total MBs]
    , avg(usecounts) AS [Avg Use Count]
    , sum(cast((CASE WHEN usecounts = 1 THEN size_in_bytes ELSE 0 END) as decimal(18,2)))/1024/1024 AS [Total MBs - USE Count 1]
    , CASE 
        WHEN (Grouping(objtype)=1) THEN count_big(objtype)
        ELSE 0 
        END AS GTOTAL
    FROM sys.dm_exec_cached_plans
    GROUP BY objtype 
) 
SELECT
[CacheType], [Total Plans],[Total MBs],
[Avg Use Count],[Total MBs - USE Count 1],
Cast([Total Plans]*1.0/Sum([Total Plans])OVER() * 100.0 AS DECIMAL(5, 2)) As Cache_Alloc_Pct
FROM CACHE_ALLOC
Order by [Total Plans] desc




SELECT [text] AS [QueryText], cp.size_in_bytes/1024/1024 AS Size_IN_MB
--SELECT SUM(ISNULL(cp.size_in_bytes,0)/1024/1024)
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_sql_text(plan_handle) 
WHERE cp.cacheobjtype = N'Compiled Plan' 
AND cp.objtype = N'Adhoc' 
AND cp.usecounts = 1
--and text like '%USE [tempdb] IF OBJECT_ID(''TEMPDB.DBO.#tmp_MPS_PEDIDO'') IS NOT NULL%'
ORDER BY cp.size_in_bytes DESC OPTION (RECOMPILE);


/***Total de entradas no PlanCache (Objetos e ADhoc) ***/

SELECT type as 'plan cache store', buckets_count
FROM sys.dm_os_memory_cache_hash_tables
WHERE type IN ('CACHESTORE_OBJCP', 'CACHESTORE_SQLCP');
GO
SELECT type, count(*) total_entries
FROM sys.dm_os_memory_cache_entries
WHERE type IN ('CACHESTORE_SQLCP', 'CACHESTORE_OBJCP')
GROUP BY type;
GO

/***Areas do PLAN Cache e distribuição ***/

SELECT objtype, count(*) AS 'number of plans',
SUM(size_in_bytes)/(1024.0 * 1024.0 * 1024.0)
AS size_in_gb_single_use_plans
FROM sys.dm_exec_cached_plans
GROUP BY objtype;

/***Parametrização when prepared muito baixo****/

SELECT usecounts, cacheobjtype, objtype, bucketid, text
FROM sys.dm_exec_cached_plans
CROSS APPLY sys.dm_exec_sql_text(plan_handle)
WHERE cacheobjtype = 'Compiled Plan'
ORDER BY objtype;


