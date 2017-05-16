/********************************************************************************************************************
* Consulta Simples: 	Index - Indices com mais contencao de travamento de páginas									*  
* Objetivo:				Identificar indices com mais contencao de travamento no banco de dados						*  
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
		,s.Page_Latch_Wait_In_Ms		[Page Latch Wait (Ms)]
		,s.Page_Latch_Wait_Count		[Page Latch Wait Count]
From	sys.dm_db_index_operational_stats(DB_ID(), Null, Null, Null) s
		Join sys.objects o
			On	s.Object_Id = o.Object_Id
		Join sys.indexes i
			On	i.Object_Id = s.Object_Id
		Left Join sys.schemas x
			On	x.Schema_Id = o.Object_Id
Where	s.Page_Latch_Wait_In_Ms > 0
		And o.Is_Ms_Shipped = 0
Order By [Page Latch Wait (Ms)] Desc
