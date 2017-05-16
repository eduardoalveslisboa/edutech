/********************************************************************************************************************
* Consulta Simples: 	Statistics - Colunas sem estatisticas														*
* Objetivo:				Identificar colunas sem estatisticas através de planos de execução em cache					*
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

Select	Top 20
		st.Text				As	[Query]
		,DB_Name(st.DBId)	As	[Database Name]
		,cp.UseCounts		As	[Usage Count]
		,qp.Query_Plan		As	[Query Plan]
From	sys.dm_exec_cached_plans cp
		Cross Apply sys.dm_exec_sql_Text(cp.Plan_Handle) st
		Cross Apply sys.dm_exec_query_plan(cp.Plan_Handle) qp
Where	Cast(qp.Query_Plan As NVarchar(Max)) Like '%<ColumnsWithNoStatistics>%'
Order By cp.UseCounts Desc