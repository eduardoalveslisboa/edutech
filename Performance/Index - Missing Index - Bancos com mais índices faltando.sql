/********************************************************************************************************************
* Consulta Simples: 	Index - Missing Index - Bancos com mais �ndices faltando									*
* Objetivo:				Identificar bancos com maior ocorr�ncias de missing �ndices									*
* Data Cria��o:			--/--/----																					*
* Autor:				Autor: Ian W. Stirk																			*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Altera��o:		29/01/2015																					*
* Descri��o:			Adequa��es																					*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
Set NoCount On
Set Statistics Time On
Set Statistics IO On

Select	Top 20
		DB_Name(Database_Id)	As	DatabaseName
		,COUNT(*)				As	[Missing Index Count]
From	sys.dm_db_missing_index_details d
Group By Database_Id
Order By [Missing Index Count] Desc