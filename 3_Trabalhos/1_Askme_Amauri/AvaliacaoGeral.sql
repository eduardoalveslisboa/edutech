


/*  
    2016-10-01 00:00:00	 /  2017-05-05 10:34:00
*/

SELECT MIN(DataAcesso),MAX(DataAcesso)
FROM appfemsa_historico_requisicao

EXEC sp_spaceused appfemsa_valida_token


/********************************************************************************
                                PERFIS
*********************************************************************************/

SELECT TOP 10 * FROM pi_adm_nivel_hierarquico
SELECT TOP 10 * FROM pi_adm_hierarquia

SELECT * FROM pi_adm_empresa_perfil
SELECT * FROM pi_adm_perfilsc

/********************************************************************************
                                ACESSOS
*********************************************************************************/
SELECT TOP 20 * 
FROM appfemsa_usuario_dispositivo 
WHERE ProfissionalID = 19210
ORDER BY DataUltimoAcesso DESC


SELECT TOP 20 * 
FROM appfemsa_dispositivo

SELECT ProfissionalID,COUNT(UserDispID)
FROM appfemsa_usuario_dispositivo
GROUP BY ProfissionalID HAVING COUNT(UserDispID) > 1

/********************************************************************************
                TROCA DE MENSAGENS - TALVEZ CANAL DE DÚVIDAS
*********************************************************************************/
SELECT TOP 20 * FROM pi_adm_contatos
SELECT TOP 20 * FROM pi_adm_mensagens

/********************************************************************************
                GERAÇÃO DE ARQUIVOS DE PONTOS PARA UPLOAD
*********************************************************************************/

SELECT * FROM api_ponto_planilha where planilhaId = 1
SELECT * FROM api_ponto_venda where planilhaId = 1
SELECT * FROM api_ponto  where vendaid in (SELECT vendaid FROM api_ponto_venda where planilhaId = 1)
SELECT * FROM api_ponto_venda where vendaid = 33

SELECT TOP 10 * FROM api_ponto_tipo 



SELECT TOP 10 * FROM api_pontoupload


SELECT COUNT(DISTINCT titulo,COUNT(planilhaId)
FROM api_ponto_planilha
GROUP BY titulo HAVING COUNT(planilhaId) > 1


SELECT TOP 10 * FROM api_ponto_erro
SELECT TOP 30 * FROM api_ponto_tipo_erro
SP_DEPENDS api_pontoupload

SELECT * FROM sys.tables WHERE name like 'api_%'

/********************************************************************************
                                QUIZ
*********************************************************************************/

SELECT TOP 10 * FROM quiz_pergunta WHERE titulo like '%prem%'

SELECT TOP 10 * FROM quiz_pergunta WHERE id = 449

SELECT TOP 10 * FROM quiz_resposta WHERE pergunta_id = 449

SELECT TOP 10 * FROM quiz_profissional_resposta WHERE resposta_id = 1850


/********************************************************************************
                                PRODUTOS
*********************************************************************************/
SELECT * FROM tbnv_ex_ficha_tecnica

SELECT * FROM tbnv_ex_categoria

SELECT * FROM tbnv_ex_produto
SELECT * FROM tbnv_ex_ficha_item

SELECT * FROM tbnv_ex_produto_imagens
SELECT * FROM tbnv_ex_sku
SELECT * FROM tbnv_ex_sku_imagem

/* WTF isso não é usado? */
SELECT TOP 10 * FROM tbnv_mv_produto_imagem
SELECT TOP 10 * FROM tbnv_mv_produto_caracteristica
SELECT TOP 10 * FROM tbnv_mv_produto
SELECT TOP 10 * FROM tbnv_mv_premio_produto


/********************************************************************************
                    EMPRESAS E REGULAMENTO          
*********************************************************************************/

SELECT * FROM pi_adm_empresas
SELECT * FROM pi_adm_pracas
SELECT * FROM api_tipo_regulamento
SELECT * FROM api_regulamento
SELECT * FROM api_regulamento_vinculo


/********************************************************************************
        NOTÍCIAS   / FORMULÁRIO ???? PRA QUE SERVEM ESSAS TABELAS?
*********************************************************************************/


SELECT * FROM sys.tables WHERE name like '%empreend%'

SELECT * FROM pi_adm_fase
SELECT * FROM pi_adm_fase_empreendimento
SELECT * FROM pi_adm_empreendimentos


SELECT * FROM pi_adm_noticias WHERE str_titulo LIKE '%dia%'

SELECT * FROM pi_adm_star_rating
SELECT * FROM pi_adm_programa

SELECT * FROM programa_acao

SELECT * FROM acao
SELECT * FROM campo_posicao WHERE id_programa_acao <= 5
SELECT * FROM campos_formulario



/********************************************************************************
                    EMPRESAS E REGULAMENTO          
*********************************************************************************/
EXEC sp_spaceused pi_adm_premios_produtos_extra

SELECT ProdutoID,count(*)
FROM pi_adm_premios_produtos_extra
GROUP BY ProdutoID HAVING count(*) > 1


/********************************************************************************
                            METAS
*********************************************************************************/


SELECT * FROM sys.tables WHERE name like '%meta%'


SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_metas_assinaturas
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_metas_montagem
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_metas_registro
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_periodo
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_pontos
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_pontos_extras
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_ranking
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_regional
SELECT TOP 10 * FROM pi_adm_metas_tudook_pdg_vinculo_cpf

