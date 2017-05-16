--Querys que estão sendo executadas frequentemente e não estão tendo o plano de execução reutilizados

WITH cached_plans (cacheobjtype, objtype, usecounts, size_in_bytes, dbid, objectid, short_qry_text) AS 
(
  SELECT p.cacheobjtype, p.objtype, p.usecounts, size_in_bytes, s.dbid, s.objectid, 
    CONVERT (nvarchar(100), REPLACE (REPLACE (
      CASE 
        -- Caso especial: handle NULL s.[text] e 'SET NOEXEC'
        WHEN s.[text] IS NULL THEN NULL 
        WHEN CHARINDEX ('noexec', SUBSTRING (s.[text], 1, 200)) > 0 THEN SUBSTRING (s.[text], 1, 40)
        -- CASE #1: sp_executesql (query text passed in as 1st parameter) 
        WHEN (CHARINDEX ('sp_executesql', SUBSTRING (s.[text], 1, 200)) > 0) 
        THEN SUBSTRING (s.[text], CHARINDEX ('exec', SUBSTRING (s.[text], 1, 200)), 60) 
        -- CASE #3: any other stored proc -- Retira qualquer parametro
        WHEN CHARINDEX ('exec ', SUBSTRING (s.[text], 1, 200)) > 0 
        THEN SUBSTRING (s.[text], CHARINDEX ('exec', SUBSTRING (s.[text], 1, 4000)), 
          CHARINDEX (' ', SUBSTRING (SUBSTRING (s.[text], 1, 200) + '   ', CHARINDEX ('exec', SUBSTRING (s.[text], 1, 500)), 200), 9) )
        -- CASE #4: procedure que começa com 'sp%' ao invés de 'exec'
        WHEN SUBSTRING (s.[text], 1, 2) IN ('sp', 'xp', 'usp')
        THEN SUBSTRING (s.[text], 1, CHARINDEX (' ', SUBSTRING (s.[text], 1, 200) + ' '))
        -- CASE #5: ad hoc UPD/INS/DEL query (em média, updates/inserts/deletes normalmente
        -- precisa de uma substring mais curta para evitar ferir
        WHEN SUBSTRING (s.[text], 1, 30) LIKE '%UPDATE %' OR SUBSTRING (s.[text], 1, 30) LIKE '%INSERT %' 
          OR SUBSTRING (s.[text], 1, 30) LIKE '%DELETE %' 
        THEN SUBSTRING (s.[text], 1, 30)
        -- CASE #6: outras ad hoc query
        ELSE SUBSTRING (s.[text], 1, 45)
      END
    , CHAR (10), ' '), CHAR (13), ' ')) AS short_qry_text 
  FROM sys.dm_exec_cached_plans p
  CROSS APPLY sys.dm_exec_sql_text (p.plan_handle) s
) 
SELECT   COUNT(*) AS plan_count, SUM (size_in_bytes) AS total_size_in_bytes,
  cacheobjtype, objtype, usecounts, dbid, objectid, short_qry_text 
FROM cached_plans
GROUP BY cacheobjtype, objtype, usecounts, dbid, objectid, short_qry_text
HAVING COUNT(*) > 100
ORDER BY COUNT(*) DESC
RAISERROR ('', 0, 1) WITH NOWAIT