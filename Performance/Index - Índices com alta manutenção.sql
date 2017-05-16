/********************************************************************************************************************
* Consulta Simples: 	Index - Índices com alta manutenção															*
* Objetivo:				Identificar os índices que são mais onerosos em relação a manutenção						*  
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:																										*
* Data Alteração:		--/--/----																					*
* Descrição:																										*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

If Object_Id('TempDb.dbo.#TempMaintenanceCost') Is Not Null
	Drop Table #TempMaintenanceCost

Select	DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,s.User_Updates				As	[Update Usage]
		,s.User_Seeks + s.User_Scans + s.User_Lookups						As	[Retrieval Usage]
		,s.User_Updates - (s.User_Seeks + s.User_Scans + s.User_Lookups)	As	[Maintenance Cost]
		,s.System_Seeks + s.System_Scans + s.System_Lookups					As	[System Usage]
		,s.Last_User_Seek
		,s.Last_User_Scan
		,s.Last_User_Lookup
Into	#TempMaintenanceCost
From	sys.dm_db_index_usage_stats s
		Join sys.Indexes i
			On	s.Object_Id = i.Object_Id
			And	s.Index_id = i.Index_id
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
Where	1 = 2

Exec SP_MSForEachDB 'Use [?]
Insert Into #TempMaintenanceCost

Select	Top 20
		DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,s.User_Updates				As	[Update Usage]
		,s.User_Seeks + s.User_Scans + s.User_Lookups						As	[Retrieval Usage]
		,s.User_Updates - (s.User_Seeks + s.User_Scans + s.User_Lookups)	As	[Maintenance Cost]
		,s.System_Seeks + s.System_Scans + s.System_Lookups					As	[System Usage]
		,s.Last_User_Seek
		,s.Last_User_Scan
		,s.Last_User_Lookup
From	sys.dm_db_index_usage_stats s
		Join sys.Indexes i
			On	s.Object_Id = i.Object_Id
			And	s.Index_id = i.Index_id
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
Where	s.Database_Id = DB_Id()
		And i.Name Is Not Null
		And ObjectProperty(s.Object_Id, ''IsMsShipped'') = 0
		And s.User_Seeks + s.User_Scans + s.User_Lookups > 0
Order By [Maintenance Cost] Desc'

Select	Top 20 *
From	 #TempMaintenanceCost
Order By [Maintenance Cost] Desc