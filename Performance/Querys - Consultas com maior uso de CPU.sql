/********************************************************************************************************************
* Consulta Simples: 	Query - Consultas com maior uso de CPU														*  
* Objetivo:				Identificar as consultas que mais utilizam CPU no servidor									*  
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
		Cast((qs.Total_Worker_Time) / 1000000.0 As Decimal(28, 2))												As	[Total CPU time (s)]
		,Cast((qs.Total_Worker_Time * 100) / qs.Total_Elapsed_Time As Decimal(28, 2))							As	[Cpu %]
		,Cast(((qs.Total_Elapsed_Time - qs.Total_Worker_Time) * 100) / qs.Total_Elapsed_Time As Decimal(28, 2))	As	[Waiting %]
		,qs.Execution_Count																						As	[Execution count]
		,Cast((qs.Total_Worker_Time / 1000000.0) / qs.Execution_Count As Decimal(28, 2))						As	[CPU time average (s)]
		,Substring(
					st.Text
					,(qs.Statement_Start_Offset / 2) + 1
					,(
						(
							Case	When Statement_End_Offset = -1 
									Then Len(Convert(NVarchar(Max), st.Text)) * 2 
									Else qs.Statement_End_Offset 
							End - qs.Statement_Start_Offset
						) / 2
					) + 1
		)																										As	[Individual Query]
		,st.Text																								As	[Parent Query]
		,DB_Name(st.DBId)																						As	[Database Name]
		,qp.Query_Plan																							As	[Query_Plan]
From	sys.dm_exec_query_stats qs
		Cross Apply sys.dm_exec_sql_text(qs.Sql_Handle) st
		Cross Apply sys.dm_exec_query_plan(qs.plan_handle) qp
Where	qs.Total_Elapsed_Time > 0
Order By [Total CPU time (s)] Desc

