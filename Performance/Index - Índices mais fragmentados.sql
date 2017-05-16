/********************************************************************************************************************
* Consulta Simples: 	Index - Índices mais fragmentados															*
* Objetivo:				Identificar os índices mais fragmentados na instância										*  
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana																				*
* Data Alteração:		28/01/2015																					*
* Descrição:			Adaptação																					*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

If Object_Id('TempDB.dbo.#TempFragmentation') Is Not Null
	Drop Table #TempFragmentation

Select	DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,Round(s.Avg_Fragmentation_In_Percent, 2)	As	[Fragmentation %]
		,s.index_type_desc			As	[Index Type]
Into	#TempFragmentation
From	sys.dm_db_index_physical_stats(DB_Id(), Null, Null, Null, Null) s
		Join sys.indexes i
			On	s.Object_Id = i.Object_Id
			And s.Index_Id = i.Index_id
		Join sys.objects o
			On	i.Object_Id = o.Object_Id
Where	1 = 2

EXEC SP_MSForEachDB 'Use [?]
Insert Into	#TempFragmentation
Select	Top 20
		DB_Name()					As	DatabaseName
		,Schema_Name(o.Schema_Id)	As	SchemaName
		,Object_Name(s.Object_Id)	As	TableName
		,i.Name						As	IndexName
		,Round(s.Avg_Fragmentation_In_Percent, 2)	As	[Fragmentation %]
		,s.index_type_desc			As	[Index Type]
From	sys.dm_db_index_physical_stats(DB_Id(), Null, Null, Null, Null) s
		Join sys.indexes i
			On	s.Object_Id = i.Object_Id
			And s.Index_Id = i.Index_id
		Join sys.objects o
			On	i.Object_Id = o.Object_Id
Where	s.Database_Id = DB_Id()
		And i.Name Is Not Null
		And ObjectProperty(s.Object_Id, ''IsMsShipped'') = 0
Order By [Fragmentation %] Desc'

Select	Top 20 *
From	#TempFragmentation
Order By [Fragmentation %] Desc