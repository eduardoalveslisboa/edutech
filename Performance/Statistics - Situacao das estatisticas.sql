/********************************************************************************************************************
* Consulta Simples: 	Statistics - Situação das estatisticas														*  
* Objetivo:				Verificar situação das estatisticas na instância											*
* Data Criação:			--/--/----																					*
* Autor:				Ian W. Stirk																				*
/*******************************************************************************************************************/
* Editador por:			Mailson Santana												    							*
* Data Alteração:		05/02/2015																					*
* Descrição:			Automatizar script para rodar em todos os bancos											*
********************************************************************************************************************/
Set Transaction Isolation Level Read Uncommitted
--Set NoCount On
--Set Statistics Time On
--Set Statistics IO On
--Set ANSI_Warnings OFF

If Object_Id('TempDB.dbo.#StatisticsStatus') Is Not Null
	Drop Table #StatisticsStatus

Select	Db_Name()					As	[Database Name]
		,ss.Name					As	[Schema Name]
		,st.Name					As	[Table Name]
		,s.Name						As	[Index Name]
		,Stats_Date(s.Id, s.IndId)	As	[Statistics Last Updated]
		,s.RowCnt					As	[Row Count]
		,s.RowModCtr				As	[Number Of Changes]
		,Cast(
				(
					Cast(s.RowModCtr As Decimal(28, 8)) / 
					Case When s.RowCnt = 0 Then 1. Else Cast(s.RowCnt As Decimal(28, 2)) End
				* 100.0
				)					As Decimal(28, 2)
		)							As	[Rows Changed %]
Into	#StatisticsStatus
From	sys.sysindexes s
		Inner Join sys.tables st
			On	st.Object_Id = s.Id
		Inner Join sys.schemas ss
			On	ss.Schema_Id = st.Schema_Id
Where	1 = 2


EXEC SP_MsForEachDB 'Use ?

Insert Into #StatisticsStatus
Select	Db_Name()					As	[Database Name]
		,ss.Name					As	[Schema Name]
		,st.Name					As	[Table Name]
		,s.Name						As	[Index Name]
		,Stats_Date(s.Id, s.IndId)	As	[Statistics Last Updated]
		,s.RowCnt					As	[Row Count]
		,s.RowModCtr				As	[Number Of Changes]
		,Cast(
				(
					Cast(s.RowModCtr As Decimal(28, 8)) / 
					Cast(s.RowCnt As Decimal(28, 2)) 
				* 100.0
				)					As Decimal(28, 2)
		)							As	[Rows Changed %]
From	sys.sysindexes s
		Inner Join sys.tables st
			On	st.Object_Id = s.Id
		Inner Join sys.schemas ss
			On	ss.Schema_Id = st.Schema_Id
Where	s.Id > 100
		And s.IndId > 0
		And s.RowCnt >= 500
Order By [Schema Name]
		,[Table Name]
		,[Index Name]'

Select	*
From	#StatisticsStatus