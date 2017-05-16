



SELECT DB_NAME(db.database_id) DatabaseName,
       (CAST(mfrows.RowSize AS FLOAT)*8)/1024 RowSizeMB,
       (CAST(mflog.LogSize AS FLOAT)*8)/1024 LogSizeMB,
       ROUND((CAST(mfrows.RowSize AS FLOAT)*8)/1024/1024+(CAST(mflog.LogSize AS FLOAT)*8)/1024/1024,2) DBSizeG
FROM sys.databases db
LEFT JOIN
  (SELECT database_id,
          SUM(SIZE) RowSize
   FROM sys.master_files
   WHERE TYPE = 0
   GROUP BY database_id,
            TYPE) mfrows ON mfrows.database_id = db.database_id
LEFT JOIN
  (SELECT database_id,
          SUM(SIZE) LogSize
   FROM sys.master_files
   WHERE TYPE = 1
   GROUP BY database_id,
            TYPE) mflog ON mflog.database_id = db.database_id
LEFT JOIN
  (SELECT database_id,
          SUM(SIZE) StreamSize
   FROM sys.master_files
   WHERE TYPE = 2
   GROUP BY database_id,
            TYPE) mfstream ON mfstream.database_id = db.database_id
LEFT JOIN
  (SELECT database_id,
          SUM(SIZE) TextIndexSize
   FROM sys.master_files
   WHERE TYPE = 4
   GROUP BY database_id,
            TYPE) mftext ON mftext.database_id = db.database_id --WHERE DB_NAME(db.database_id) IN ('funcional_sgs','log_integracao', 'wsgs', 'gestao_integrada','data_source')
ORDER BY 4 DESC 




--SELECT d.name,
--       ROUND(SUM(mf.size) * 8 /1024/1024.0, 0) Size_MBs
--FROM sys.master_files mf
--INNER JOIN sys.databases d ON d.database_id = mf.database_id
--WHERE d.database_id > 4
--GROUP BY d.name
--ORDER BY d.name
--SELECT DB_NAME(db.database_id) DatabaseName,
--       (CAST(mfrows.RowSize AS FLOAT)*8)/1024 RowSizeMB,
--       (CAST(mflog.LogSize AS FLOAT)*8)/1024 LogSizeMB,
--       (CAST(mfstream.StreamSize AS FLOAT)*8)/1024 StreamSizeMB,
--       (CAST(mftext.TextIndexSize AS FLOAT)*8)/1024 TextIndexSizeMB
--FROM sys.databases db
--LEFT JOIN
--  (SELECT database_id,
--          SUM(SIZE) RowSize
--   FROM sys.master_files
--   WHERE TYPE = 0
--   GROUP BY database_id,
--            TYPE) mfrows ON mfrows.database_id = db.database_id
--LEFT JOIN
--  (SELECT database_id,
--          SUM(SIZE) LogSize
--   FROM sys.master_files
--   WHERE TYPE = 1
--   GROUP BY database_id,
--            TYPE) mflog ON mflog.database_id = db.database_id
--LEFT JOIN
--  (SELECT database_id,
--          SUM(SIZE) StreamSize
--   FROM sys.master_files
--   WHERE TYPE = 2
--   GROUP BY database_id,
--            TYPE) mfstream ON mfstream.database_id = db.database_id
--LEFT JOIN
--  (SELECT database_id,
--          SUM(SIZE) TextIndexSize
--   FROM sys.master_files
--   WHERE TYPE = 4
--   GROUP BY database_id,
--            TYPE) mftext ON mftext.database_id = db.database_id
