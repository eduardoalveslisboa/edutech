
/**** Contagem media por ANO ,MES , DIA , HORA , MINUTO , SEGUNDO - Compras***/

USE Benefit
GO
WITH CONTAGEM_VALIDA AS( SELECT COUNT(NSUAUT) CONTAGEM
FROM PRE_AUT WITH (NOLOCK)
WHERE NSUAUT_VENDA IS NOT NULL
  AND PAT_DATA BETWEEN '2014-07-01' AND '2015-07-31 23:59:59')


/**** Contagem media por ANO ,MES , DIA , HORA , MINUTO , SEGUNDO - Transacoes***/

, CONTAGEM_GERAL AS( SELECT COUNT(NSUAUT) CONTAGEM
FROM PRE_AUT WITH (NOLOCK)
WHERE PAT_DATA BETWEEN '2014-01-01' AND '2015-07-31 23:59:59')

SELECT  'Pre-Autorizacoes - Apenas Compras'TipoTransacao,
		SUM (CONTAGEM) [Jul2014 - Jul2015],
	   (SUM (CONTAGEM)/19) MediaMes,
	   (SUM (CONTAGEM)/19/30)MediaDia , 
	   (SUM (CONTAGEM)/19/30/24)MediaHora,
	   (SUM (CONTAGEM)/19/24/60)MediaMinuto,
	   (SUM (CONTAGEM)/19/30/60/60)MediaSegundo
	  FROM CONTAGEM_VALIDA
	  UNION ALL
	  SELECT 'Pre-Autorizacoes - Geral Compras e consultas' TipoTransacao,
        SUM (CONTAGEM)[Jul2014 - Jul2015],
	   (SUM (CONTAGEM)/12) MediaMes,
	   (SUM (CONTAGEM)/12/30)MediaDia , 
	   (SUM (CONTAGEM)/12/30/24)MediaHora,
	   (SUM (CONTAGEM)/12/24/60)MediaMinuto,
	   (SUM (CONTAGEM)/12/30/60/60)MediaSegundo
	  FROM CONTAGEM_GERAL


