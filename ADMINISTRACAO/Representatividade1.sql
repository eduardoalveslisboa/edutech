alter procedure p_relatorioMensalRepresentatividade1 (@Datade Datetime,@DataAte Datetime,@Produto varchar(100))
as
    SET NOCOUNT ON;
    WITH CTE_Pieces
    AS 
    (
        SELECT
            1 AS ID
            ,1 AS StartString
            ,CHARINDEX(',', @Produto) AS StopString
   
        UNION ALL
  
        SELECT
            ID + 1
            ,StopString + 1
            ,CHARINDEX(',', @Produto, StopString + 1)
        FROM
            CTE_Pieces
        WHERE
            StopString > 0
    )
    ,CTE_Split
    AS
    (
        SELECT
            CONVERT(int,SUBSTRING(@Produto, StartString, 
                                  CASE 
                                     WHEN StopString > 0 THEN StopString - StartString
                                     ELSE LEN(@Produto)
                                     END
                                  )
                   ) AS Produto
        FROM
            CTE_Pieces 
    ) 
select p.nom_prod, p.des_emba, sum(ds.qtdvenda)Qtde, ds.percDescontoAplicado
from benefit..v_compras c with(nolock)
join benefit..mov_cartao_itens m with(nolock) on  m.cod_movi = c.NSUAUT and m.nsuhos = c.NSUHOS and m.DAT_VEND = c.DATTRA 
join benefit..mov_cartao_itens_descontos ds with(nolock) on ds.cod_movi = m.cod_movi and ds.nsuhos = m.nsuhos and ds.dat_vend = m.DAT_VEND and ds.cod_item = m.cod_item
join benefit..cad_prod p with(nolock) on p.cod_prod = m.cod_prod 
join CTE_Split as S on s.Produto = m.cod_prod 
where  m.cod_prod in ('70945', '70948', '70946', '61746','120830', '120831', '120832')
  and m.CD_PROGRAMA = 6
  and c.DATTRA between @Datade and @DataAte
  and c.CODCLI = 1599    
group by p.nom_prod, p.des_emba, ds.percDescontoAplicado
order by p.nom_prod, p.des_emba, ds.percDescontoAplicado











