/********************************************************************************************************************
* Consulta Simples: 	Cached Plan - Identificando Scans realizados em consultas em cache							*
* Objetivo:				Identificar Scans realizados em consultas em cache na inst�ncia								*
* Data Cria��o:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Altera��o:		--/--/----																					*
* Descri��o:																										*
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
Where	Cast(qp.Query_Plan As NVarchar(Max)) Like '%<IndexScan%'
		Or Cast(qp.Query_Plan As NVarchar(Max)) Like '%<TableScan%'
Order By cp.UseCounts Desc