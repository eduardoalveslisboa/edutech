/********************************************************************************************************************
* Consulta Simples: 	Index - Indices mais escalados																*  
* Objetivo:				Identificar índices mais escalados a nível de banco de dados								*
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Alteração:		--/--/----																					*
* Descrição:																										*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

Select	TOP 20
		x.Name							[Schema Name]
		,Object_Name(s.Object_Id)		[Table Name]
		,i.Name							[Index Name]
		,s.Row_Lock_Wait_In_Ms			[Row Lock Wait (Ms)]
		,s.Row_Lock_Wait_Count			[Row Wait Count]
		,s.Index_Lock_Promotion_Count	[Scaler Count]
From	sys.dm_db_index_operational_stats(DB_ID(), Null, Null, Null) s
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
		Join sys.indexes i
			On	i.Object_Id = s.Object_Id
		Left Join sys.schemas x
			On	x.Schema_Id = o.Object_Id
Where	s.Index_Lock_Promotion_Count > 0
		And o.Is_Ms_Shipped = 0
Order By s.Index_Lock_Promotion_Count Desc