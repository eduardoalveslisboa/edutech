/********************************************************************************************************************
* Consulta Simples: 	Index - Índice inexistente (Missing Index)													*  
* Objetivo:				Identificar índices úteis não existentes no banco de dados									*  
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Alteração:		16/01/2015																					*
* Descrição:			Adequações																					*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On

Select	Top 20
		Round(s.avg_total_user_cost * s.avg_user_impact * (s.user_seeks + s.user_scans), 0) As [Total Cost]
		,d.statement AS [Table Name]
		,s.avg_user_impact
		,equality_columns
		,inequality_columns
		,included_columns
From	sys.dm_db_missing_index_groups g
		Join sys.dm_db_missing_index_group_stats s
			On	s.group_handle = g.index_group_handle
		Join sys.dm_db_missing_index_details d
			On	d.index_handle = g.index_handle
Where	d.Database_Id = DB_ID('Usstrategy')
Order By [Total Cost] Desc