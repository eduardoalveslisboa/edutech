/********************************************************************************************************************
* Consulta Simples: 	Querys - Consultas mais demoradas															*
* Objetivo:				Identificar as consultas que mais demoram para finalizar, no servidor						*
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Alteração:		16/01/2015																					*
* Descrição:			Adaptação																					*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On
--Set ANSI_Warnings OFF

Select	TOP 10
		CAST
			(
				(
					(qs.Total_Elapsed_Time / qs.Execution_Count)
				/ 1000000.)
			/ 60. As Numeric(24, 2)
		)							[AVG Time (In minutes)] 
		,qs.Total_Worker_Time		[Total CPU]				--Tempo total de CPU (Em microsegundos), desde a última compilação 
		,qs.Total_Elapsed_Time		[Total Elapsed Time]	--Tempo total gasto (Em microsegundos), desde a última compilação 
		,CAST
			(
				(qs.Total_Worker_Time * 100.) 
				/ qs.Total_Elapsed_Time AS Decimal(28,2)
		)							[% CPU]
		,CAST
			(
				(
					(qs.Total_Elapsed_Time - qs.Total_Worker_Time) 
				* 100.) 
			/ qs.Total_Elapsed_Time AS Decimal(28,2)
		)							[% Wating ]
		,qs.Total_Physical_Reads	[Total Physical Reads]	--Total de Leituras Fisicas(páginas), desde a última compilação
		,qs.Execution_Count			[Execution Count]		--Total de execuções
		,Substring(
					st.Text
					,(qs.Statement_Start_Offset / 2) + 1
					,(
						(
							Case	When qs.Statement_End_Offset = -1
									Then Len(Convert(NVarchar(Max), st.Text)) * 2
									Else qs.Statement_End_Offset
							End - qs.Statement_Start_Offset
						) / 2
					) + 1
		)							[Query Individual]
		,st.Text					[Parent Query]
		,DB_Name(st.DbId)			[Database Name]
		,total_rows					[Total Rows]
		,qp.Query_Plan				[Query Plan]
		,qs.*
From	sys.dm_exec_query_stats qs
		Cross Apply sys.dm_exec_sql_text(qs.Sql_Handle) st
		Cross Apply sys.dm_exec_query_plan (qs.Plan_Handle) qp
Where	qs.Total_Elapsed_Time > 0
		And qs.creation_time >= '2015-01-16 12:40:01.000'
Order by --qs.Total_Worker_Time Desc
		 --qs.Total_Physical_Reads Desc
		 qs.Total_Elapsed_Time / qs.Execution_Count Desc
		 --qs.Execution_Count Desc