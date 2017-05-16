SELECT top 3000

    'CREATE INDEX IDX_FUNC'

    + CASE WHEN EQUALITY_Columns IS NULL THEN LTRIM('') ELSE  REPLACE(RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(EQUALITY_Columns,',','_'),'[',''),']',''))),CHar(32), '_')  END

    + CASE WHEN INEQUALITY_Columns IS NULL THEN LTRIM('') ELSE REPLACE(RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(INEQUALITY_Columns,',','_'),'[',''),']',''))),CHAR(32), '_') END

    + cast(mid.Index_Handle as varchar)

    + ' ON ' + Statement + ' ('

    + CASE WHEN EQUALITY_Columns IS NULL THEN '' ELSE  REPLACE(REPLACE(EQUALITY_Columns,'[',''),']','') ENd

    + CASE WHEN INEQUALITY_Columns IS NULL THEN ')' ELSE '' END

    + CASE WHEN INEQUALITY_Columns IS NULL THEN '' ELSE + (CASE WHEN EQUALITY_Columns IS NULL THEN '' ELSE  ',' ENd) + INEQUALITY_Columns + ')' ENd

    + CASE WHEN INCluded_Columns IS NULL THEN '' ELSE + ' INCLUDE(' + REPLACE(REPLACE(INCluded_Columns,'[',''),']','') + ')'ENd

FROM sys.dm_db_missing_index_details mid

INNER JOIN sys.dm_db_missing_index_groups mig ON mig.Index_Handle = mid.index_handle

INNER JOIN sys.dm_db_missing_index_group_stats migs ON mig.Index_group_handle = migs.group_handle

ORDER BY avg_total_user_cost * avg_user_impact * (user_seeks + user_scans)DESC;