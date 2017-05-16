

       /**************************************************************************************
       Data de criação :22/03/2015
       Autor Criação  : Marcio Penna
       Objetivo da criação: Ajudar a equipe de auditoria a identificar as transações não registradas em auditoria.
       Sistemas que utilizam : Auditoria
       Histórico:  
       Data de Criação     Autor                      Linhas Alteradas           Objetivo  
       22/03/2015          Marcio Penna               [20-40]                    Projeto de auditoria
       **************************************************************************************/


CREATE PROCEDURE p_AuditoriaReportUsuario (@Id_Auditoria varchar(200), @DataInicial Datetime,@DataFinal Datetime)
as

--declare  @Id_Auditoria varchar(200) =255
; WITH CTE_Pieces
    AS 
    (
        SELECT
            1 AS ID
            ,1 AS StartString
            ,CHARINDEX(',', @Id_Auditoria) AS StopString
   
        UNION ALL
  
        SELECT
            ID + 1
            ,StopString + 1
            ,CHARINDEX(',', @Id_Auditoria, StopString + 1)
        FROM
            CTE_Pieces
        WHERE
            StopString > 0
    )
    ,CTE_Split
    AS
    (
        SELECT
            SUBSTRING(@Id_Auditoria, StartString, 
                                  CASE 
                                     WHEN StopString > 0 THEN StopString - StartString
                                     ELSE LEN(@Id_Auditoria)
                                     END
                                  )  AS Id_Auditoria
        FROM
            CTE_Pieces 
    ) 
	SELECT * INTO #CTE_Split2 FROM CTE_Split
	CREATE CLUSTERED INDEX INDEX_TEMP_#CTE_Split2 ON #CTE_Split2(ID_AUDITORIA)
;
 WITH CTE_AuditoriaUsuario
as
(
	select au.ID
	,      au.ID_AUDITORIA
	,      au.CODCLI
	,      au.CPF
	,      au.NUMDEP
	,      au.STA
	,      au.DT_INICIAL
	,      au.DT_FINAL
	from auditoria_usuario as au
)
,    CTE_AuditoriaLog
as
(
	select A.Id
	,      A.Usuario
	,      A.Acao
	,      A.Data
	,      b.Data Fim
	from       "log".dbo.AtivacaoAuditoria a
	inner join "log".dbo.AtivacaoAuditoria b on a.Id=b.id-1
)
,    CTE_UsuarioExcecao
as
(
	select ID
	,      CODCLI
	,      CPF
	,      NUMDEP
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from AUDITORIA_USUARIO_EXCECAO
)
,    CTE_AuditoriaCredenciado
as
(
	select *
	from auditoria_credenciado
)
,    CTE_Cliente
as
(
	select ID
	,      ID_AUDITORIA
	,      GRC_CODIGO
	,      CODCLI
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from auditoria_Cliente
)
,    CTE_GrupoCliente
as
(
	select ID
	,      ID_AUDITORIA
	,      GRC_CODIGO
	,      CODCLI
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from auditoria_Cliente
)
,    CTE_AuditoriaProdutos
as
(
	select ID
	,      ID_AUDITORIA
	,      COD_PROD
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from AUDITORIA_PRODUTOS
)
SELECT Distinct 
CONVERT(varchar, avb_datInc, 103) + ' ' + CONVERT(varchar, avb_datInc, 114) 'Data Inclusão'
			,      isnull(convert(varchar,p.nsuaut),'') 'Autorizacao'
			,      p.nsuhos
			,      b.codcli 'Cod Cliente'
			,      grc_descricao 'Cliente'
			,      nomcli 'Unidade'
			,      b.Codcrt 'Cartão'
			,      u.nomusu 'Usuario'
			,      u.numdep
			,      cc.sexo 'Sexo'
			,      ISNULL(CONVERT(varchar, CASE WHEN PATINDEX('%[^0-9]%', cc.nascimento) > 0                                                                       THEN ''
			                                    WHEN CONVERT(integer, SUBSTRING(cc.nascimento, 5, 4)) BETWEEN 1901 AND CONVERT(integer, DATEPART(YEAR, GETDATE())) THEN CONVERT(integer, DATEPART(YEAR, GETDATE())) - CONVERT(integer, SUBSTRING(cc.nascimento, 5, 4))
			                                    WHEN CONVERT(integer, SUBSTRING(cc.nascimento, 1, 4)) BETWEEN 1901 AND CONVERT(integer, DATEPART(YEAR, GETDATE())) THEN CONVERT(integer, DATEPART(YEAR, GETDATE())) - CONVERT(integer, SUBSTRING(cc.nascimento, 1, 4))
			                                    WHEN CONVERT(integer, SUBSTRING(cc.nascimento, 0, 4)) BETWEEN 1901 AND CONVERT(integer, DATEPART(YEAR, GETDATE())) THEN CONVERT(integer, DATEPART(YEAR, GETDATE())) - CONVERT(integer, SUBSTRING(cc.nascimento, 0, 4)) 
END), '') 'Idade'
			,      cr.codcre 'Cod Credenciado'
			,      nomfan 'Credenciado'
			,      loc.nomloc 'Cidade'
			,      cr.siguf0 'Estado'
			,      PAT_DATA  'DataTransacao'
			,      prod.COD_PROD 'Cod Produto'
			,      prod.NOM_PROD 'Nome Produto'
			,      Tr.des_acao 'Classe1'
			,      Mei_Emba+'  '+ p.Des_emba Apresentacao
			,      prod.qtd_limite 'Qtde Sugerida'
			,      p.pai_qtde_vendida 'Qtde Vendida'
			,      CONVERT(int, avb_crm) 'CRM'
			,      avb_datareceita 'Data Receita'
			,      at.DESCRICAO 'Motivo do bloqueio'
			,      p.PAT_TOTAL 'Total da Venda'
			,      CASE WHEN (SELECT COUNT('x')
				FROM      benefit..pre_aut     l WITH (NOLOCK)
				LEFT JOIN autorizador..cttrans t WITH (NOLOCK) ON t.nsuaut = l.nsuaut AND t.codcrt = l.codcrt AND CONVERT(varchar, t.dattra, 103) = CONVERT(varchar, l.pat_data, 103)
				WHERE l.codcrt = b.Codcrt
					AND l.pat_data BETWEEN avb_datInc
					AND DATEADD(DAY, 1, avb_datInc)
					AND t.codrta = 'V')
				> 0     THEN 'S'
			            ELSE 'N' END 'Venda Autorizada na Sequência'
			,      CASE b.ent_receita WHEN 'S' THEN 'Sim'
			                          WHEN 'N' THEN 'Não'
			                                   ELSE '' END 'Entregou Receita?'
			,      b.avb_desbloqueio_username 'Operador'
			,      CASE avb_status WHEN 'Desbloqueio'          THEN 'Desbloqueada'
			                       WHEN 'Bloqueio'             THEN 'Bloqueada sem Análise'
			                       WHEN 'Bloqueio com Análise' THEN 'Bloqueada com Análise' END 'Status da Transação'
			,      avb_data_status 'Data Status'
,               case when b.avb_nsuaut is null then 'Não'
                                               else 'Sim' end as Bloqueio
,               'SistemaAuditoriaAtivado'= case when la.acao='ativou' then 'Sim'
                                                                      else 'Não' END
,               'ListaUsuarioAuditoria'= case when AudUsu.ID_AUDITORIA is not null then 'Sim'
                                                                                   else 'Não' END
,               'ListaUsuarioExcecao'= case when Ue.ID is not null then 'Sim'
                                                                          else 'Não' END
,               'ListaCredenciadoAuditoria'= case when Ca.ID is not null then 'Sim'
                                                                         else 'Não' END
,               'ListaClienteAuditoria'= case when Cla.ID is not null then 'Sim'
                                                                           else 'Não' END
,               case when prod.Cod_prod='100001' then 'Sim' else '' end ProdutoManipulado
, p.msg
into #TransacoesAuditadas
FROM       replicacao.dbo.transacao                    t with (Nolock) 
JOIN       Benefit.dbo.Auditoria_Usuario               Au with (nolock) on Au.CodCli=T.Codcli and Au.Cpf=T.Cpf and Au.Numdep=T.NumDep
JOIN       #CTE_Split2                                   CteSplit (Nolock) on CteSplit.Id_Auditoria=Au.Id_Auditoria
JOIN       replicacao.dbo.Grupo_cliente                Gc With (nolock) on Gc.Codcli=t.codcli
JOIN       v_pre_aut                                     p with(nolock)   ON t.nsuaut = ISNULL(p.nsuaut_venda, p.nsuaut)
		AND CONVERT(VARCHAR, t.dattra, 103) =
		CONVERT(VARCHAR, ISNULL( p.pat_data_venda, p.pat_data ), 103 )
		AND p.codcrt = t.codcrt
		AND t.codcre = p.codcre
		INNER JOIN replicacao..usuario                      u    WITH (NOLOCK) ON t.codcli = u.codcli AND t.numdep = u.numdep AND t.cpf = u.cpf
		INNER JOIN replicacao..dados_comp_clientes          cc   WITH (NOLOCK) ON u.CPF = cc.cpf AND u.NUMDEP = cc.numdep
		INNER JOIN replicacao..credenciado                  cr   WITH (NOLOCK) ON t.codcre = cr.codcre
		INNER JOIN replicacao..localidade                   loc  WITH (NOLOCK) ON cr.codloc = loc.codloc
left join  cad_prod                                    prod with (nolock) on prod.cod_prod=p.Cod_prod
INNER JOIN benefit..aca_terap                       tr   WITH (NOLOCK) ON prod.cls1=cod_acao
left join  auditoria_venda_bloqueios                as B        WITH (NOLOCK)  on p.nsuaut = b.avb_nsuaut AND p.nsuhos = b.avb_nsuhos AND p.pat_data >= b.avb_pat_data
left JOIN  benefit..auditoria_venda_bloqueios_itens    i  WITH (NOLOCK)  on b.avb_nsuaut = i.avb_nsuaut AND b.avb_nsuhos = i.avb_nsuhos AND b.avb_pat_data = i.avb_pat_data
INNER JOIN (SELECT avb_nsuaut
				,              MAX(avb_datInc) [datInc]
				FROM auditoria_venda_bloqueios WITH (NOLOCK)
				WHERE avb_pat_data BETWEEN @DataInicial and @DataFinal
				GROUP BY avb_nsuaut
				)                                               b2  ON b.avb_nsuaut = b2.avb_nsuaut AND b.avb_datInc = b2.datInc
left JOIN  Benefit..AUDITORIA_TIPO                     at       WITH (NOLOCK)  on at.CODIGO = i.avm_codigo
inner join CTE_AuditoriaLog                            la       WITH (NOLOCK)  on t.Dattra between la.Data and fim
left join  CTE_AuditoriaUsuario                        AudUsu   WITH (NOLOCK)  on t.Dattra between AudUsu.DT_inicial and isnull(AudUsu.DT_FINAL,getdate()+1) and AudUsu.CODCLI=t.Codcli and AudUsu.CPF=t.cpf and AudUsu.Numdep=t.numdep
left join  CTE_UsuarioExcecao                          Ue       WITH (NOLOCK)  on t.Dattra between Ue.DT_inicial and isnull(Ue.DT_FINAL,getdate()+1) and Ue.CODCLI=t.Codcli and Ue.CPF=t.cpf and Ue.Numdep=t.numdep
left join  CTE_AuditoriaCredenciado                    Ca       WITH (NOLOCK)  on t.Dattra between Ca.DT_inicial and isnull(Ca.DT_FINAL,getdate()+1) and Ca.CodCre=t.CodCre
left join  CTE_Cliente                                 Cla      WITH (NOLOCK)  on t.Dattra between Cla.DT_inicial and isnull(Cla.DT_FINAL,getdate()+1) and Cla.CodCli=GC.CodCli
WHERE  Dattra between @DataInicial and @DataFinal
	AND t.TIPTRA IN (51000, 51001, 51100, 51101, 51010, 51110, 11001, 11002, 51014, 51114, 800000, 11005, 11010, 11007, 11011, 11012, 11013, 11022, 11021, 11024, 11026, 11028, 11031, 800004,11019)



/***** Analise das transacoes correspondendo com as tabelas de auditoria para confrontação*****/

;WITH CTE_AuditoriaUsuario
as
(
	select au.ID
	,      au.ID_AUDITORIA
	,      au.CODCLI
	,      au.CPF
	,      au.NUMDEP
	,      au.STA
	,      au.DT_INICIAL
	,      au.DT_FINAL
	from auditoria_usuario as au
)
,    CTE_AuditoriaLog
as
(
	select A.Id
	,      A.Usuario
	,      A.Acao
	,      A.Data
	,      b.Data Fim
	from       "log".dbo.AtivacaoAuditoria a
	inner join "log".dbo.AtivacaoAuditoria b on a.Id=b.id-1
)
,    CTE_UsuarioExcecao
as
(
	select ID
	,      CODCLI
	,      CPF
	,      NUMDEP
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from AUDITORIA_USUARIO_EXCECAO
)
,    CTE_AuditoriaCredenciado
as
(
	select *
	from auditoria_credenciado
)
,    CTE_Cliente
as
(
	select ID
	,      ID_AUDITORIA
	,      GRC_CODIGO
	,      CODCLI
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from auditoria_Cliente
)
,    CTE_GrupoCliente
as
(
	select ID
	,      ID_AUDITORIA
	,      GRC_CODIGO
	,      CODCLI
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from auditoria_Cliente
)
,    CTE_AuditoriaProdutos
as
(
	select ID
	,      ID_AUDITORIA
	,      COD_PROD
	,      STA
	,      DT_INICIAL
	,      DT_FINAL
	from AUDITORIA_PRODUTOS
)
SELECT Distinct 
isnull(CONVERT(varchar, avb_datInc, 103) + ' ' + CONVERT(varchar, avb_datInc, 114),'') 'Data Inclusão'
			,      isnull(convert(varchar,p.nsuaut),'') 'Autorizacao'
			,      p.nsuhos
			,      u.codcli 'Cod Cliente'
			,      grc_descricao 'Cliente'
			,      nomcli 'Unidade'
			,      p.Codcrt 'Cartão'
			,      u.nomusu 'Usuario'
			,      u.numdep
			,      cc.sexo 'Sexo'
			,      ISNULL(CONVERT(varchar, CASE WHEN PATINDEX('%[^0-9]%', cc.nascimento) > 0                                                                       THEN ''
			                                    WHEN CONVERT(integer, SUBSTRING(cc.nascimento, 5, 4)) BETWEEN 1901 AND CONVERT(integer, DATEPART(YEAR, GETDATE())) THEN CONVERT(integer, DATEPART(YEAR, GETDATE())) - CONVERT(integer, SUBSTRING(cc.nascimento, 5, 4))




			                                    WHEN CONVERT(integer, SUBSTRING(cc.nascimento, 1, 4)) BETWEEN 1901 AND CONVERT(integer, DATEPART(YEAR, GETDATE())) THEN CONVERT(integer, DATEPART(YEAR, GETDATE())) - CONVERT(integer, SUBSTRING(cc.nascimento, 1, 4))
			                                    WHEN CONVERT(integer, SUBSTRING(cc.nascimento, 0, 4)) BETWEEN 1901 AND CONVERT(integer, DATEPART(YEAR, GETDATE())) THEN CONVERT(integer, DATEPART(YEAR, GETDATE())) - CONVERT(integer, SUBSTRING(cc.nascimento, 0, 4)) E
ND), '') 'Idade'
			,      cr.codcre 'Cod Credenciado'
			,      nomfan 'Credenciado'
			,      loc.nomloc 'Cidade'
			,      cr.siguf0 'Estado'
			,      PAT_DATA  'DataTransacao'
			,      prod.COD_PROD 'Cod Produto'
			,      prod.NOM_PROD 'Nome Produto'
			,      Tr.des_acao 'Classe1'
			,      Mei_Emba+'  '+ p.Des_emba Apresentacao
			,      prod.qtd_limite 'Qtde Sugerida'
			,      p.pai_qtde_vendida 'Qtde Vendida'
			,      CONVERT(int, avb_crm) 'CRM'
			,      avb_datareceita 'Data Receita'
			,      at.DESCRICAO 'Motivo do bloqueio'
			,      p.PAT_TOTAL 'Total da Venda'
			,      CASE WHEN (SELECT COUNT('x')
				FROM      benefit..pre_aut     l WITH (NOLOCK)
				LEFT JOIN autorizador..cttrans t WITH (NOLOCK) ON t.nsuaut = l.nsuaut AND t.codcrt = l.codcrt AND CONVERT(varchar, t.dattra, 103) = CONVERT(varchar, l.pat_data, 103)
				WHERE l.codcrt = b.Codcrt
					AND l.pat_data BETWEEN avb_datInc
					AND DATEADD(DAY, 1, avb_datInc)
					AND t.codrta = 'V')
				> 0     THEN 'S'
			            ELSE 'N' END 'Venda Autorizada na Sequência'
			,      CASE b.ent_receita WHEN 'S' THEN 'Sim'
			                          WHEN 'N' THEN 'Não'
			                                   ELSE '' END 'Entregou Receita?'
			,      b.avb_desbloqueio_username 'Operador'
			,      CASE avb_status WHEN 'Desbloqueio'          THEN 'Desbloqueada'
			                       WHEN 'Bloqueio'             THEN 'Bloqueada sem Análise'
			                       WHEN 'Bloqueio com Análise' THEN 'Bloqueada com Análise' END 'Status da Transação'
			,      avb_data_status 'Data Status'
,               case when b.avb_nsuaut is null then 'Não'
                                               else 'Sim' end as Bloqueio
,               'SistemaAuditoriaAtivado'= case when la.acao='ativou' then 'Sim'
                                                                      else 'Não' END
,               'ListaUsuarioAuditoria'= case when AudUsu.ID_AUDITORIA is not null then 'Sim'
                                                                                   else 'Não' END
,               'ListaUsuarioExcecao'= case when Ue.ID is not null then 'Sim'
                                                                          else 'Não' END
,               'ListaCredenciadoAuditoria'= case when Ca.ID is not null then 'Sim'
                                                                         else 'Não' END
,               'ListaClienteAuditoria'= case when Cla.ID is not null then 'Sim'
                                                                           else 'Não' END
,               case when prod.Cod_prod='100001' then 'Sim' else '' end ProdutoManipulado
, p.msg
into #TransacoesNaoAuditadas
FROM       replicacao.dbo.transacao                    t with (Nolock)
JOIN       Benefit.dbo.Auditoria_Usuario               Au with (nolock) on Au.CodCli=T.Codcli and Au.Cpf=T.Cpf and Au.Numdep=T.NumDep
JOIN       #CTE_Split2                                CteSplit (Nolock) on CteSplit.Id_Auditoria=Au.Id_Auditoria 
JOIN       replicacao.dbo.Grupo_cliente                Gc With (nolock) on Gc.Codcli=t.codcli
JOIN       v_pre_aut                                     p with(nolock)   ON t.nsuaut = ISNULL(p.nsuaut_venda, p.nsuaut)
		AND CONVERT(VARCHAR, t.dattra, 103) =
		CONVERT(VARCHAR, ISNULL( p.pat_data_venda, p.pat_data ), 103 )
		AND p.codcrt = t.codcrt
		AND t.codcre = p.codcre
		INNER JOIN replicacao..usuario                      u    WITH (NOLOCK) ON t.codcli = u.codcli AND t.numdep = u.numdep AND t.cpf = u.cpf
		INNER JOIN replicacao..dados_comp_clientes          cc   WITH (NOLOCK) ON u.CPF = cc.cpf AND u.NUMDEP = cc.numdep
		INNER JOIN replicacao..credenciado                  cr   WITH (NOLOCK) ON t.codcre = cr.codcre
		INNER JOIN replicacao..localidade                   loc  WITH (NOLOCK) ON cr.codloc = loc.codloc
left join  cad_prod                                    prod with (nolock) on prod.cod_prod=p.Cod_prod
INNER JOIN benefit..aca_terap                       tr   WITH (NOLOCK) ON prod.cls1=cod_acao
left join  auditoria_venda_bloqueios                as B        WITH (NOLOCK)  on p.nsuaut = b.avb_nsuaut AND p.nsuhos = b.avb_nsuhos AND p.pat_data >= b.avb_pat_data
left JOIN  benefit..auditoria_venda_bloqueios_itens    i        WITH (NOLOCK)  on b.avb_nsuaut = i.avb_nsuaut AND b.avb_nsuhos = i.avb_nsuhos AND b.avb_pat_data = i.avb_pat_data
left JOIN  Benefit..AUDITORIA_TIPO                     at       WITH (NOLOCK)  on at.CODIGO = i.avm_codigo
inner join CTE_AuditoriaLog                            la       WITH (NOLOCK)  on t.Dattra between la.Data and fim
left join  CTE_AuditoriaUsuario                        AudUsu   WITH (NOLOCK)  on t.Dattra between AudUsu.DT_inicial and isnull(AudUsu.DT_FINAL,getdate()+1) and AudUsu.CODCLI=t.Codcli and AudUsu.CPF=t.cpf and AudUsu.Numdep=t.numdep
left join  CTE_UsuarioExcecao                          Ue       WITH (NOLOCK)  on t.Dattra between Ue.DT_inicial and isnull(Ue.DT_FINAL,getdate()+1) and Ue.CODCLI=t.Codcli and Ue.CPF=t.cpf and Ue.Numdep=t.numdep
left join  CTE_AuditoriaCredenciado                    Ca       WITH (NOLOCK)  on t.Dattra between Ca.DT_inicial and isnull(Ca.DT_FINAL,getdate()+1) and Ca.CodCre=t.CodCre
left join  CTE_Cliente                                 Cla      WITH (NOLOCK)  on t.Dattra between Cla.DT_inicial and isnull(Cla.DT_FINAL,getdate()+1) and Cla.CodCli=GC.CodCli
WHERE  Dattra between @DataInicial and @DataFinal
	AND t.TIPTRA IN (51000, 51001, 51100, 51101, 51010, 51110, 11001, 11002, 51014, 51114, 800000, 11005, 11010, 11007, 11011, 11012, 11013, 11022, 11021, 11024, 11026, 11028, 11031, 800004,11019)
	and b.avb_Nsuaut is null
order by Autorizacao desc

select * from #TransacoesAuditadas
union all
select * from #TransacoesNaoAuditadas

drop table #TransacoesAuditadas
drop table #TransacoesNaoAuditadas
drop table #CTE_Split2




