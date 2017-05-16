/****************************************************************************************
                    TABLES / TABELAS E TAMANHOS
*****************************************************************************************/
SELECT 
'SELECT TOP 100 * FROM '+ S.name +'.'+ t.name 
,S.name as SchemaName,t.name AS Tabela
,SUM (
CASE  
    WHEN (P.index_id < 2) THEN P.row_count
    ELSE 0  
END  
)								AS linhas
,SUM(P.reserved_page_count * 8) AS reservadoKB
From sys.tables AS T
INNER JOIN sys.schemas  as s on t.schema_id = s.schema_id
INNER JOIN sys.dm_db_partition_stats AS P ON t.object_id = P.object_id
--WHERE t.name = 'City'
GROUP BY S.name,t.name
ORDER BY S.name,t.name

/****************************************************************************************
                    TABLES / TABELAS QUE NÃO POSSUEM RELACIONAMENTO 
*****************************************************************************************/
;WITH TabelasNaoPai AS 
(
    SELECT T.name
    FROM sys.tables AS T
    LEFT JOIN sys.foreign_keys  AS F ON T.object_id = F.parent_object_id
    where F.parent_object_id IS NULL
)
,TabelasNaoFilhas AS 
(
    SELECT T.name
    FROM sys.tables AS T
    LEFT JOIN sys.foreign_keys  AS F ON T.object_id = F.referenced_object_id
    where F.referenced_object_id IS NULL
)

SELECT A.name
FROM TabelasNaoPai AS A
INNER JOIN TabelasNaoFilhas AS B ON A.name = B.name
ORDER BY A.name

/****************************************************************************************
                    TABLES / TABELAS QUE NÃO POSSUEM RELACIONAMENTO 
*****************************************************************************************/

/****************************************************************************************
                    INDEX / ÍNDICES FRAGMENTADOS
*****************************************************************************************/

Select	DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,Round(s.Avg_Fragmentation_In_Percent, 2)	As	[Fragmentation %]
		,s.index_type_desc			As	[Index Type]
From	sys.dm_db_index_physical_stats(DB_Id(), Null, Null, Null, Null) s
INNER JOIN sys.indexes AS i On	s.Object_Id = i.Object_Id And s.Index_Id = i.Index_id
INNER JOIN sys.objects AS o On	i.Object_Id = o.Object_Id
Where	s.Database_Id = DB_Id()
		And i.Name Is Not Null
		And ObjectProperty(s.Object_Id, 'IsMsShipped') = 0
Order By [Fragmentation %] Desc

/****************************************************************************************
                    INDEX / ÍNDICES FRAGMENTADOS
*****************************************************************************************/

/*************************************************************************************
          SECURITY / USER / LOGIN - Seguraça Usuários e logins 
**************************************************************************************/
SELECT * FROM sys.firewall_rules
SELECT * FROM sys.sql_logins

CREATE LOGIN teste WITH PASSWORD = 'edu@ardo001'

create user teste for login teste with default_schema = dbo

ALTER USER teste WITH LOGIN = teste;


ALTER ROLE loginmanager ADD teste
ALTER ROLE loginmanager DROP teste

/* pode liberar o IP no firewall s󠮯 banco sem liberar a n�l de server , o login vai conseguir conectar e ver somente os seus bancos liberados */
SELECT * FROM sys.database_firewall_rules

EXEC sp_set_database_firewall_rule
@name = 'NomeDaRegra'
,@start_ip_Address = '111.222.333.444'
,@end_ip_Address = '111.222.333.444'

EXEC sp_delete_database_firewall_rule
@name = 'NomeDaRegra'

/*************************************************************************************
          SECURITY / USER / LOGIN - Seguraça Usuáos e logins 
**************************************************************************************/

