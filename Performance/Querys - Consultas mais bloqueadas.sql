/********************************************************************************************************************
* Consulta Simples: 	Querys - Consultas mais bloqueadas															*
* Objetivo:				Identificar as consultas que passaram mais tempo sendo bloqueados							*
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
		Cast((qs.Total_Elapsed_Time - qs.Total_Worker_Time) / 1000000.0 As Decimal(28, 2))							As	[Total time blocked (s)]
		,Cast((qs.Total_Worker_Time * 100.0) / qs.Total_Elapsed_Time As Decimal(28, 2))								As	[CPU %]
		,CAST(((qs.Total_Elapsed_Time - qs.Total_Worker_Time) * 100.0) / qs.Total_Elapsed_Time As Decimal(28, 2))	As	[Waiting %]
		,qs.Execution_Count																							As	[Execution Count]
		,Cast(((qs.Total_Elapsed_Time - qs.Total_Worker_Time) / 1000000.0) / qs.Execution_Count	As Decimal(28, 2))	As	[Blocking Average (s)]
		,Substring(
					st.Text
					,(qs.Statement_Start_Offset / 2) + 1
					,((Case	When qs.Statement_End_Offset = -1
							Then LEN(Convert(NVarchar(Max), st.Text)) * 2
							Else qs.Statement_End_Offset
					End - qs.Statement_Start_Offset) / 2) + 1) AS [Query Individual]
		,st.Text				As	[Parent Query]
		,DB_Name(st.DBId)		As	DatabaseName
		,qp.Query_Plan			As	[Query Plan ]
From	sys.dm_exec_query_stats qs
		Cross Apply sys.dm_exec_sql_text(qs.Sql_Handle) st
		Cross Apply sys.dm_exec_query_plan(qs.Plan_Handle) qp
Where	qs.Total_Elapsed_Time > 0
Order By [Total time blocked (s)] Desc
