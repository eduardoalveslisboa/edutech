-->Plan Cache Detail<-----------------------------------------
DECLARE @start DATETIME, @end DATETIME
SELECT @start = DATEADD(hh,-1,GETDATE())
SELECT @end = GETDATE()

SELECT Hits.[instance_name], 
CAST((Hits.[cntr_value] * 1.0 / Total.[cntr_value]) * 100.0 AS DECIMAL(5,2)) AS [plan_cache_hit_ratio], 
[Pages].[cntr_value] AS [cache_pages], 
([Pages].[cntr_value] * 8 / 1024) AS [cache_in_mb],
Hits.[date_stamp]
FROM 
(
SELECT [instance_name], [cntr_value], [date_stamp]
FROM iDBA.[MetaBOT].[dm_os_performance_counters]
WHERE [counter_name] = 'Cache Hit Ratio'
AND [date_stamp] BETWEEN @start AND @end

) Hits 

INNER JOIN

(
SELECT [instance_name], [cntr_value], [date_stamp] 
FROM iDBA.[MetaBOT].[dm_os_performance_counters] 
WHERE [counter_name] = 'Cache Hit Ratio Base'
AND [date_stamp] BETWEEN @start AND @end
) Total 
ON Hits.[date_stamp] = Total.[date_stamp] 
AND [Hits].[instance_name] = [Total].[instance_name]

INNER JOIN 

(
SELECT [instance_name], [cntr_value], [date_stamp] 
FROM iDBA.[MetaBOT].[dm_os_performance_counters] 
WHERE [object_name] LIKE '%:Plan Cache%'
AND [counter_name] = 'Cache Pages'
AND [date_stamp] BETWEEN @start AND @end
) Pages
ON Hits.[date_stamp] = [Pages].[date_stamp]
AND Hits.[instance_name] = [Pages].[instance_name]
ORDER BY Hits.[date_stamp] DESC, Hits.[instance_name];