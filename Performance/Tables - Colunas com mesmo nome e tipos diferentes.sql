/********************************************************************************************************************
* Consulta Simples: 	Tables - Colunas com mesmo nome e tipos diferentes											*  
* Objetivo:				Identificar colunas no banco de dados que possuem o mesmo nome, mas tipos diferentes		*  
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

If Object_Id('TempDB.dbo.#Prevalence') Is Not Null
	Drop Table #Prevalence

Select	Column_Name
		,Convert(Decimal(12, 2), Count(Column_Name) * 100.0 / Count(*) Over()) [%]
Into	#Prevalence
From	Information_Schema.Columns
Group By Column_Name

Select	Distinct
		c1.Table_Schema
		,c1.Column_Name
		,c1.Table_Name
		,c1.Character_Maximum_Length
		,c1.Numeric_Precision
		,c1.Numeric_Scale
		,p.[%]
From	Information_Schema.Columns c1
		Join Information_Schema.Columns c2
			On	c1.Column_Name = c2.Column_Name
		Join #Prevalence p
			On	p.Column_Name = c1.Column_Name
Where	(c1.Data_Type != c2.Data_Type) 
		Or (c1.Character_Maximum_Length != c2.Character_Maximum_Length)
		Or (c1.Numeric_Precision != c2.Numeric_Precision)
		Or (c1.Numeric_Scale != c2.Numeric_Scale)
Order By p.[%] Desc
		,c1.Column_Name
		,c1.Table_Schema
		,c1.Table_Name

Drop Table #Prevalence
