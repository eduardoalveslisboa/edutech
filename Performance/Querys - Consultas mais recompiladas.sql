/********************************************************************************************************************
* Consulta Simples: 	Querys - Consultas mais recompiladas														*
* Objetivo:				Identificar as consultas mais recompiladas na instância										*
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
		qs.Plan_Generation_Num				As	[Recompilations]
		,qs.Total_Elapsed_Time / 1000000.0	As	[Total Elapsed Time (s)]
		,qs.Execution_Count					As	[Execution Count]
		,Substring
		(
			st.Text
			,(qs.Statement_Start_Offset / 2) + 1
			,((Case	When qs.Statement_End_Offset = -1
					Then LEN(Convert(NVarchar(Max), st.Text)) * 2
					Else qs.Statement_End_Offset
			End - qs.Statement_Start_Offset) / 2) + 1
		)									As	[Query Individual]
		,st.Text							As	[Parent Query]
		,DB_Name(st.DBId)					As	[Database Name]
		,qp.Query_Plan						As	[Query Plan ]
From	sys.dm_exec_query_stats qs
		Cross Apply sys.dm_exec_sql_text(qs.Sql_Handle) st
		Cross Apply sys.dm_exec_query_plan(qs.Plan_Handle) qp
Where	qs.Total_Elapsed_Time > 0
Order By [Recompilations] Desc
