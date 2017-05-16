/********************************************************************************************************************
* Consulta Simples: 	Index - Indices com mais PageSplit															*  
* Objetivo:				Identificar índices com maior incidencia de divisão de páginas								*  
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
		,s.Leaf_Allocation_Count		[Leaf Allocation Count]
		,s.NonLeaf_Allocation_Count		[NonLeaf Allocation Count]
From	sys.dm_db_index_operational_stats(DB_ID(), Null, Null, Null) s
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
		Join sys.indexes i
			On	i.Object_Id = s.Object_Id
		Left Join sys.schemas x
			On	x.Schema_Id = o.Object_Id
Where	s.Leaf_Allocation_Count > 0
		And o.Is_Ms_Shipped = 0
Order By [Leaf Allocation Count] Desc
