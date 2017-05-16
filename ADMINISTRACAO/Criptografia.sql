USE DESENV
GO
IF EXISTS(SELECT * FROM  SYS.TABLES WHERE NAME ='CADASTRODEPESSOAS' AND type_desc='USER_TABLE')
DROP TABLE [CADASTRODEPESSOAS]

CREATE TABLE [dbo].[CadastroDePessoas](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[NomeCompleto] [nvarchar](50) NOT NULL,
	[RG] [varbinary](MAX) NOT NULL,
	[CPF] [varbinary](MAX) NOT NULL,
	[Login] [varbinary](MAX) NOT NULL,
	[Senha] VARCHAR(50) NOT NULL,
	[Ativo] [bit] NOT NULL,
 CONSTRAINT [PK_CadastroDePessoas] PRIMARY KEY CLUSTERED
(
	[Codigo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CadastroDePessoas] ADD  CONSTRAINT [DF_CadastroDePessoas_Ativo]  DEFAULT ((0)) FOR [Ativo]
GO


CREATE SYMMETRIC KEY ChaveSimetrica01 WITH ALGORITHM = TRIPLE_DES_3KEY ENCRYPTION BY PASSWORD = N'@Funcional2016'


SELECT * FROM sys.symmetric_keys

--truncate table [CadastroDePessoas]
/**
	ABRIMOS A CHAVE SIMÉTRICA ANTES DE USAR
*/
OPEN SYMMETRIC KEY ChaveSimetrica01 DECRYPTION BY PASSWORD = N'@Funcional2016';
/*
INCLUIMOS OS DADOS NA TABELA
*/
INSERT INTO [CadastroDePessoas]([NomeCompleto], [RG], [CPF], [Login], [Senha], [Ativo])
VALUES('Marcio Penna',
		EncryptByKey(Key_GUID('ChaveSimetrica01'), ('00.000.000-0'))  ,
		EncryptByKey(Key_GUID('ChaveSimetrica01'), ('111.111.111-11'))  ,
		EncryptByKey(Key_GUID('ChaveSimetrica01'), ('Marcio')) ,
		EncryptByKey(Key_GUID('ChaveSimetrica01'), ('1')), 1);
		
		SELECT RG, CPF, [Login],[Senha] FROM dbo.CadastroDePessoas
		
CLOSE SYMMETRIC KEY ChaveSimetrica01


OPEN SYMMETRIC KEY ChaveSimetrica01 DECRYPTION BY PASSWORD = N'@Funcional2016';
GO
SELECT CONVERT(VARCHAR(200), DECRYPTBYKEY(RG)) AS RG,
	   CONVERT(VARCHAR(200), DECRYPTBYKEY(CPF)) AS CPF,
	   CONVERT(VARCHAR(200), DECRYPTBYKEY([Login])) AS [Login] 
       --CONVERT(VARCHAR(50), DECRYPTBYKEY(Senha)) [senha]
       FROM dbo.CadastroDePessoas
	   
	DROP SYMMETRIC KEY  ChaveSimetrica01   
	   
	--Gerando chave assimetrica   
CREATE ASYMMETRIC KEY ChaveAssimetrica001
    WITH ALGORITHM = RSA_2048
    ENCRYPTION BY PASSWORD = N'@Funcional2016';
GO

SELECT * FROM sys.asymmetric_keys

INSERT INTO [CadastroDePessoas]([NomeCompleto], [RG], [CPF], [Login], [Senha], [Ativo])
VALUES('Fabiano Costa',
		EncryptByAsymKey(AsymKey_ID('ChaveAssimetrica001'), CONVERT(VARBINARY, '11.111.111-1'))  ,
		EncryptByAsymKey(AsymKey_ID('ChaveAssimetrica001'), CONVERT(VARBINARY, '111.111.111-11'))  ,
		EncryptByAsymKey(AsymKey_ID('ChaveAssimetrica001'), CONVERT(VARBINARY, 'fabiano')) ,
		'40bd001563085fc35165329ea1ff5c5ecbdbbeef', 1);
		
	

    OPEN SYMMETRIC KEY ChaveSimetrica01 DECRYPTION BY PASSWORD = N'@Funcional2016';
    SELECT 
       CONVERT(VARCHAR(200), DECRYPTBYKEY(A.RG)) AS RG,
	   CONVERT(VARCHAR(200), DECRYPTBYKEY(A.CPF)) AS CPF,
	   CONVERT(VARCHAR(200), DECRYPTBYKEY(A.Login)) AS [Login]     
       FROM dbo.CadastroDePessoas AS A INNER JOIN dbo.CadastroDePessoas AS B
    ON CONVERT(VARCHAR(200), DECRYPTBYKEY(A.Login))=CONVERT(VARCHAR(200), DECRYPTBYKEY(B.Login))
    WHERE CONVERT(VARCHAR(200), DECRYPTBYKEY(A.Login)) LIKE '%MARCELO%'
    CLOSE SYMMETRIC KEY ChaveSimetrica01


    SELECT 
        CONVERT(VARCHAR(20),RG)  ,
		CONVERT(VARCHAR(20),CPF)  ,
		CONVERT(VARCHAR(20),LOGIN)  FROM [CADASTRODEPESSOAS]

    
INSERT INTO [CadastroDePessoas]([NomeCompleto], [RG], [CPF], [Login], [Senha], [Ativo])
VALUES( 'Marcio Penna',
		CONVERT(VARBINARY,'00.000.000-0')  ,
		CONVERT(VARBINARY,'111.111.111-11')  ,
		CONVERT(VARBINARY,'MARCELO') ,
        '12345',
		'1');