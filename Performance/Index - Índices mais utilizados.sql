/********************************************************************************************************************
* Consulta Simples: 	Index - �ndices mais utilizados																*
* Objetivo:				Identificar os �ndices mais utilizados														*  
* Data Cria��o:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:																										*
* Data Altera��o:		--/--/----																					*
* Descri��o:																										*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

If Object_Id('TempDb.dbo.#TempUsage') Is Not Null
	Drop Table #TempUsage

Select	DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,s.User_Seeks + s.User_Scans + s.User_Lookups		As	Usage
		,s.User_Updates				As	[Maintenance Cost]
		,i.Fill_Factor				As	[Fill Factor]
Into	#TempUsage
From	sys.dm_db_index_usage_stats s
		Join sys.Indexes i
			On	s.Object_Id = i.Object_Id
			And	s.Index_id = i.Index_id
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
Where	1 = 2

Exec SP_MSForEachDB 'Use [?]
Insert Into #TempUsage

Select	Top 20
		DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,s.User_Seeks + s.User_Scans + s.User_Lookups		As	Usage
		,s.User_Updates				As	[Maintenance Cost]
		,i.Fill_Factor				As	[Fill Factor]
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
Order By Usage Desc'

Select	Top 20 *
From	 #TempUsage
Order By [Maintenance Cost] Desc