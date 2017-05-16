/********************************************************************************************************************
* Consulta Simples: 	Index - Índices não utilizados																*
* Objetivo:				Identificar índices que não foram usados (Desde a última reinicialização do SQL Server)		*
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Alteração:		29/01/2015																					*
* Descrição:			Adaptação																					*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

If Object_Id('TempDB.dbo.#TempNeverUsedIndexes') Is Not Null
		Drop Table #TempNeverUsedIndexes

Select	DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(o.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,i.Type_Desc				As	IndexType
Into	#TempNeverUsedIndexes
From	sys.indexes i
		Join sys.objects o
			On	i.Object_Id = o.Object_Id
Where	1 = 2

Exec SP_MSForEachDB 'Use [?]
Insert Into #TempNeverUsedIndexes

Select	DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(o.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,i.Type_Desc				As	IndexType
From	sys.indexes i
		Join sys.objects o
			On	i.Object_Id = o.Object_Id
		Left Join sys.dm_db_index_usage_stats s
			On	s.Object_Id = i.Object_id
			And s.Index_Id = i.Index_Id
			And s.Database_Id = DB_Id()
Where	ObjectProperty(o.Object_Id, ''IsMsShipped'') = 0
		And i.Name Is Not Null
		And s.object_id Is Null'

Select	*
From	#TempNeverUsedIndexes