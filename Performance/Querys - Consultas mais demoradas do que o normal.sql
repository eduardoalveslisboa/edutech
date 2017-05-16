/********************************************************************************************************************
* Consulta Simples: 	Querys - Consultas mais demoradas do que o normal											*  
* Objetivo:				Identificar as consultas que demoraram mais que o normal com base na ultima execução		*  
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

If Object_ID('TempDB.dbo.#SlowQueries') Is Not Null
	Drop Table #SlowQueries

If Object_ID('TempDB.dbo.#SlowQueriesByIO') Is Not Null
	Drop Table #SlowQueriesByIO

Select	Top 100
		qs.Execution_Count	As	[Runs]
		,(qs.Total_Worker_Time - qs.Last_Worker_Time) / (qs.Execution_Count - 1)	As	[Avg Time]
		,qs.Last_Worker_Time														As	[Last Time]
		,(qs.Last_Worker_Time - ((qs.Total_Worker_Time - qs.Last_Worker_Time) / (qs.Execution_Count - 1)))	As	[Time Deviation]
		,Case When qs.Last_Worker_Time = 0
				Then 100
				Else (qs.Last_Worker_Time - ((qs.Total_Worker_Time - qs.Last_Worker_Time) / (qs.Execution_Count - 1))) * 100.0 
		End / (((qs.Total_Worker_Time - qs.Last_Worker_Time) / (qs.Execution_Count - 1.0)))					As [% Time Deviation] 
		,qs.Last_Logical_Reads + qs.Last_Logical_Writes + qs.Last_Physical_reads							As [Last IO]
		,(	
			(qs.Total_Logical_Reads + qs.Total_Logical_Writes + qs.Total_Physical_Reads) - 
			(qs.Last_Logical_Reads + qs.Last_Logical_Writes + qs.Last_Physical_Reads)
		) / (qs.Execution_Count - 1)																		As	[Avg IO]
		,Substring(
					st.Text
					,(qs.Statement_Start_Offset / 2) + 1
					,((Case	When qs.Statement_End_Offset = -1
							Then LEN(Convert(NVarchar(Max), st.Text)) * 2
							Else qs.Statement_End_Offset
					End - qs.Statement_Start_Offset) / 2) + 1) AS [Individual Query]
		,st.Text				As	[Parent Query]
		,DB_Name(st.DBId)		As	DatabaseName
Into	#SlowQueries
From	sys.dm_exec_query_stats qs
		Cross Apply sys.dm_exec_sql_text(qs.Plan_Handle) st
Where	qs.Execution_Count > 1
		And qs.Total_Worker_Time != qs.Last_Worker_Time
Order By [% Time Deviation] Desc

Select	Top 100
		[Runs]
		,[Avg Time]
		,[Last Time]
		,[Time Deviation]
		,[% Time Deviation]
		,[Last IO]
		,[Avg IO]
		,[Last IO] - [Avg IO]	As	[IO Deviation]
		,Case When [Avg IO] = 0 Then 0 Else ([Last IO] - [Avg IO]) * 100 / [Avg IO] End	As	[% IO Deviation]
		,[Individual Query]
		,[Parent Query]
		,[DatabaseName]
Into	#SlowQueriesByIO
From	#SlowQueries
Order By [% Time Deviation] Desc

Select	Top 100
		[Runs]
		,[Avg Time]
		,[Last Time]
		,[Time Deviation]
		,[% Time Deviation]
		,[Last IO]
		,[Avg IO]
		,[IO Deviation]
		,[% IO Deviation]
		,[% Time Deviation] - [% IO Deviation]	As	[Impedance]
		,[Individual Query]
		,[Parent Query]
		,[DatabaseName]
From	#SlowQueriesByIO
Where	[% Time Deviation] - [% IO Deviation] > 20
Order By [Impedance] Desc