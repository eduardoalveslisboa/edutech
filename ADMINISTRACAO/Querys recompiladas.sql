--Querys recompiladas

SELECT TOP 100
    qs.plan_generation_num,
    qs.execution_count,
    qs.statement_start_offset,
    qs.statement_end_offset,
    st.text
    FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
    WHERE qs.plan_generation_num > 1
    ORDER BY qs.plan_generation_num DESC
    
