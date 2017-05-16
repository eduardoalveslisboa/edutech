USE tabelas_temp
GO


/* criação de chave simetrica para criptografar os nomes de beneficiarios */

CREATE SYMMETRIC KEY ChaveSimetricaFuncionalHML WITH ALGORITHM = TRIPLE_DES_3KEY ENCRYPTION BY PASSWORD = N'@Funcional2016'


/* consulta a exitencia da chave */

SELECT * FROM sys.symmetric_keys




/* INCLUIMOS OS DADOS NA TABELA */

USE tabelas_temp
GO

/* ABRIMOS A CHAVE SIMÉTRICA ANTES DE USAR */

OPEN SYMMETRIC KEY ChaveSimetricaFuncionalHML DECRYPTION BY PASSWORD = N'@Funcional2016';

INSERT INTO tabelas_temp.dbo.t_tmp_usuario
SELECT   U.CODCLI, U.CPF, U.NUMDEP, CODFIL, CODPAR,EncryptByKey(Key_GUID('ChaveSimetricaFuncionalHML'),(NOMUSU)), NUMPAC, NUMULTPAC, DATRENANU, DATATV, PMO, LIMPAD, DATINC, CODSET, MAT, DATANU, DATGERCRT, GERCRT, VALANU, CODCRT, STA, DATSTA, CTRATV, U.GENERICO, ACRESPAD, U.BANCO, U.AGENCIA, U.CONTA
FROM netcardpj.dbo.usuario                                      AS U     WITH   (NOLOCK) 
INNER JOIN netcardpj.dbo.Grupo_Cliente                          AS G     WITH   (NOLOCK)  ON U.CODCLI=G.CODCLI
INNER JOIN funcionalcard.dbo.dados_comp_clientes                AS DC    WITH   (NOLOCK)  ON U.CPF=DC.CPF AND U.NUMDEP=DC.NUMDEP AND DC.GRC_CODIGO=G.GRC_CODIGO
WHERE U.CPF='27435381802'


		
CLOSE SYMMETRIC KEY ChaveSimetrica01


OPEN SYMMETRIC KEY ChaveSimetrica01 DECRYPTION BY PASSWORD = N'@Funcional2016';
GO
SELECT U.CODCLI, U.CPF, U.NUMDEP, CODFIL, CODPAR,EncryptByKey(Key_GUID('ChaveSimetricaFuncionalHML'),(NOMUSU)), NUMPAC, NUMULTPAC, DATRENANU, DATATV, PMO, LIMPAD, DATINC, CODSET, MAT, DATANU, DATGERCRT, GERCRT, VALANU, CODCRT, STA, DATSTA, CTRATV, U.GENERICO, ACRESPAD, U.BANCO, U.AGENCIA, U.CONTA
       FROM tabelas_temp.dbo.t_tmp_usuario
	   
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