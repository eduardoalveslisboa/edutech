/********************************************************************************************************************
* Consulta Simples: 	Index - Índices mais onerosos não utilizados												*  
* Objetivo:				Identificar o índices (Em toda a instância) que não são utilizados,							*
*						ordenando por nº de atualizações															* 
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Alteração:		22/01/2015																					*
* Descrição:			Inclusão da coluna ApproximateSizeMB														*
*						e em consequência a troca da view sys.indixes pela sys.SysIndixes 							*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

If Object_Id('TempDb.dbo.#TempUnusedIndexes') Is Not Null
	Drop Table #TempUnusedIndexes

Select	DB_Name()					As	DatabaseName
		,SChema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_id)	AS	TableName
		,i.Name						As	IndexName
		,s.User_Updates				As	UserUpdates
		,s.System_Seeks + s.System_Scans + s.System_Lookups As SystemUsage
		,(i.DPages * 8.) / 1204.	As	ApproximateSizeMB
Into	#TempUnusedIndexes
From	sys.dm_db_index_usage_stats s
		Join sys.SysIndexes i
			On	s.Object_Id = i.Id
			And s.Index_id = i.Indid
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
Where	1 = 2

Exec SP_MSForEachDB 'Use [?];
Insert Into #TempUnusedIndexes

Select	Top 20
		DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_id)	AS	TableName
		,i.Name						As	IndexName
		,s.User_Updates				As	UserUpdates
		,s.System_Seeks + s.System_Scans + s.System_Lookups As SystemUsage
		,(i.DPages * 8.) / 1204.	As	ApproximateSizeMB
From	sys.dm_db_index_usage_stats s
		Join sys.SysIndexes i
			On	s.Object_Id = i.Id
			And s.Index_id = i.Indid
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
Where	s.Database_Id = DB_ID()
		And ObjectProperty(s.Object_id, ''IsMsShipped'') = 0
		And s.User_Seeks = 0
		And s.User_Scans = 0
		And s.User_Lookups = 0
		And i.Name Is Not Null
Order By s.User_Updates Desc'

Select	Top 20 *
From	#TempUnusedIndexes
Order By UserUpdates Desc

--Drop Table #TempUnusedIndexes

