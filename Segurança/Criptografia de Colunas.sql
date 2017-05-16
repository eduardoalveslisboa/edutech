/********************************************************************************************************************
* Consulta Simples: 	Config - Criptografando dados																*
* Objetivo:				Criptografar colunas no SQL Server															*
* Data Criação:			14/05/2015																					*
* Autor:				Mailson Santana																				*
********************************************************************************************************************/ 
Use Master
Go

If DB_Id('Teste') Is Not Null
	Drop Database Teste

Create Database Teste
Go

Use Teste
Go

--Passo 1
/************************
*	Database Master Key	*
************************/
--Criando database master key
Create Master Key Encryption By Password = 'P@ssw0rd'

--Passo 2
/****************************************
*	Criando certificado	Auto-Assinado	*
****************************************/
--Certificado ão criados para servir de conteiner para chaves assimetricas

Create Certificate Cert_Teste
Encryption By Password = 'CertP@ssw0rd'
With	Subject = 'Meu Cert Teste'
		,Expiry_Date = '2017/12/12'

--Passo 3
/********************************************
*	Criando Chave Simetrica ou Assimetrica	*
********************************************/

CREATE SYMMETRIC KEY Key_Teste 
WITH	ALGORITHM = AES_256
		ENCRYPTION BY Certificate Cert_Teste 

--Passo 4
/****************************
*	Encriptando a coluna	*
****************************/
Create Table Teste
(
	Cod Int Identity
	,Nome	Varchar(100)
	,Senha	Varbinary(4000)
	,DataAtual	As	GetDate()
)

Open Symmetric Key Key_Teste
Decryption By Certificate Cert_Teste With Password = 'CertP@ssw0rd'

Insert into Teste
Values (
		'Mailson', 
		EncryptByKey(Key_GUID('Key_Teste'), 'Essa informação será criptografada')
		)

Close Symmetric Key Key_Teste
--Passo 4
/****************************
*	Descriptando a coluna	*
****************************/
Open Symmetric Key Key_Teste
Decryption By Certificate Cert_Teste With Password = 'CertP@ssw0rd'

Select	Cod
		,Nome
		,Convert(Varchar, DecryptByKey(Senha)) Senha
		,Senha
		,DataAtual
From Teste

Close Symmetric Key Key_Teste
Go

/**********************
*	Funcao de leitura *
**********************/
Alter Procedure dbo.p_Usuario
(
	@CodigoUsuario Int = Null
)
With Execute As Owner
	,Encryption
As Begin
	
	Open Symmetric Key Key_Teste
	Decryption By Certificate Cert_Teste With Password = 'CertP@ssw0rd'

	Select	Cod
			,Nome
			,Convert(Varchar, DecryptByKey(Senha)) Senha
			,DataAtual
	From	Teste
	WHere	Cod = IsNull(@CodigoUsuario, Cod)

	Close Symmetric Key Key_Teste

	Return
End


Exec p_Usuario