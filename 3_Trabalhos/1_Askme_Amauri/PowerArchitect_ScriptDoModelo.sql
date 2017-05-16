
CREATE TABLE pi_skuPremio (
                skuPremioId INT IDENTITY NOT NULL,
                sku VARCHAR(64) NOT NULL,
                CONSTRAINT pi_skuPremio_pk PRIMARY KEY (skuPremioId)
)

CREATE TABLE pi_skuImagem (
                skuImagemId INT IDENTITY NOT NULL,
                skuPremioId INT NOT NULL,
                imagemMenor VARCHAR(256) NOT NULL,
                imagemMaior VARCHAR(256) NOT NULL,
                imagemZoom VARCHAR(256) NOT NULL,
                CONSTRAINT pi_skuImagem_pk PRIMARY KEY (skuImagemId)
)

CREATE TABLE pi_carrinho (
                carrinhoId INT IDENTITY NOT NULL,
                dataCriacao DATETIME NOT NULL,
                dataAlteracao DATETIME NOT NULL,
                CONSTRAINT pi_carrinho_pk PRIMARY KEY (carrinhoId)
)

CREATE TABLE pi_parceiro (
                parceiroId INT IDENTITY NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT pi_parceiro_pk PRIMARY KEY (parceiroId)
)

CREATE TABLE pi_fichaTecnicaItem (
                fichaTecnicaItemId INT IDENTITY NOT NULL,
                descricao VARCHAR(128) NOT NULL,
                valor VARCHAR(256) NOT NULL,
                CONSTRAINT pi_fichaTecnicaItem_pk PRIMARY KEY (fichaTecnicaItemId)
)

CREATE TABLE pi_produtoCategoria (
                produtoCategoriaId INT IDENTITY NOT NULL,
                paiProdutoCategoriaId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_produtoCategoria_pk PRIMARY KEY (produtoCategoriaId)
)

CREATE TABLE pi_produto (
                produtoId INT IDENTITY NOT NULL,
                produtoCategoriaId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                descricao VARCHAR(256) NOT NULL,
                codigoFabricante VARCHAR(8) NOT NULL,
                fabricante VARCHAR(64) NOT NULL,
                fotoPequena VARCHAR(256) NOT NULL,
                fotoMedia VARCHAR(256) NOT NULL,
                fotoGrande VARCHAR(256) NOT NULL,
                palavraChave VARCHAR(32) NOT NULL,
                ativo BIT NOT NULL,
                dataAtualizacao DATETIME NOT NULL,
                CONSTRAINT pi_produto_pk PRIMARY KEY (produtoId)
)

CREATE TABLE pi_produtoFichaTecnica (
                produtoFichaTecnicaId INT IDENTITY NOT NULL,
                produtoId INT NOT NULL,
                fichaTecnicaItemId INT NOT NULL,
                CONSTRAINT pi_produtoFichaTecnica_pk PRIMARY KEY (produtoFichaTecnicaId)
)

CREATE TABLE pi_pais (
                paisId INT IDENTITY NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT pi_pais_pk PRIMARY KEY (paisId)
)

CREATE TABLE pi_estado (
                estadoId INT IDENTITY NOT NULL,
                paisId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                sigla VARCHAR(2) NOT NULL,
                CONSTRAINT pi_estado_pk PRIMARY KEY (estadoId)
)

CREATE TABLE pi_cidade (
                cidadeId INT IDENTITY NOT NULL,
                estadoId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT pi_cidade_pk PRIMARY KEY (cidadeId)
)

CREATE TABLE pi_bairro (
                bairroId INT IDENTITY NOT NULL,
                cidadeId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT pi_bairro_pk PRIMARY KEY (bairroId)
)

CREATE TABLE pi_tipoLogradouro (
                tipoLogradouroId INT IDENTITY NOT NULL,
                nome VARCHAR(64) NOT NULL,
                sigla VARCHAR(8) NOT NULL,
                CONSTRAINT pi_tipoLogradouro_pk PRIMARY KEY (tipoLogradouroId)
)

CREATE TABLE pi_logradouro (
                logradouroId INT IDENTITY NOT NULL,
                tipoLogradouroId INT NOT NULL,
                bairroId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT pi_logradouro_pk PRIMARY KEY (logradouroId)
)

CREATE TABLE pi_resgateEndereco (
                resgateEnderecoId INT IDENTITY NOT NULL,
                logradouroId INT NOT NULL,
                numero SMALLINT NOT NULL,
                complemento VARCHAR(32),
                CONSTRAINT pi_resgateEndereco_pk PRIMARY KEY (resgateEnderecoId)
)

CREATE TABLE pi_tipoContato (
                tipoContatoId INT IDENTITY NOT NULL,
                nome VARCHAR NOT NULL,
                mascara VARCHAR,
                validacao VARCHAR,
                CONSTRAINT pi_tipoContato_pk PRIMARY KEY (tipoContatoId)
)

CREATE TABLE pi_tipoRegulamento (
                tipoRegulamentoId INT IDENTITY NOT NULL,
                nome VARCHAR NOT NULL,
                CONSTRAINT pi_tipoRegulamento_pk PRIMARY KEY (tipoRegulamentoId)
)

CREATE TABLE pi_cliente (
                clienteId INT IDENTITY NOT NULL,
                nome VARCHAR(64) NOT NULL,
                dataCriacao DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_cliente_pk PRIMARY KEY (clienteId)
)

CREATE TABLE pi_segmentoTipo (
                segmentoTipoId INT IDENTITY NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT pi_segmentoTipo_pk PRIMARY KEY (segmentoTipoId)
)

CREATE TABLE pi_segmento (
                segmentoId INT IDENTITY NOT NULL,
                paiSegmentoId INT NOT NULL,
                segmentoTipoId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                dataAlteracao DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_segmento_pk PRIMARY KEY (segmentoId)
)

CREATE TABLE pi_programa (
                programaId INT IDENTITY NOT NULL,
                clienteId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                descricao VARCHAR(256) NOT NULL,
                resgateAtivo BIT NOT NULL,
                dataInicio DATETIME NOT NULL,
                dataAlteracao DATETIME NOT NULL,
                urlLogoPrograma VARCHAR(256) NOT NULL,
                urlLogoEmpresa VARCHAR(256) NOT NULL,
                dataCriacao DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_programa_pk PRIMARY KEY (programaId)
)

CREATE TABLE pi_fase (
                faseId INT IDENTITY NOT NULL,
                programaId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                resgateAtivo BIT NOT NULL,
                urlImagemFase VARCHAR(256) NOT NULL,
                urlFase VARCHAR(256) NOT NULL,
                dataInicio DATETIME NOT NULL,
                dataTermino DATETIME NOT NULL,
                fatorConversaoPontoReal FLOAT NOT NULL,
                fatorConversaoRealPonto FLOAT NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_fase_pk PRIMARY KEY (faseId)
)

CREATE TABLE pi_faseSegmento (
                faseSegmentoId INT IDENTITY NOT NULL,
                faseId INT NOT NULL,
                segmentoId INT NOT NULL,
                dataInicio DATETIME NOT NULL,
                dataFim DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_faseSegmento_pk PRIMARY KEY (faseSegmentoId)
)

CREATE TABLE pi_premio (
                premioId INT IDENTITY NOT NULL,
                produtoId INT NOT NULL,
                faseSegmentoId INT NOT NULL,
                parceiroId INT NOT NULL,
                skuPremioId INT NOT NULL,
                valor FLOAT NOT NULL,
                valorDe FLOAT NOT NULL,
                percentualDesconto FLOAT NOT NULL,
                MarkUp FLOAT NOT NULL,
                disponivel BIT NOT NULL,
                dataInclusao DATETIME NOT NULL,
                dataAlterecao DATETIME NOT NULL,
                CONSTRAINT pi_premio_pk PRIMARY KEY (premioId)
)

CREATE TABLE pi_itemCarrinho (
                itemCarrinhoId INT IDENTITY NOT NULL,
                premioId INT NOT NULL,
                carrinhoId INT NOT NULL,
                quantidade SMALLINT NOT NULL,
                pontos INT NOT NULL,
                status VARCHAR(32) NOT NULL,
                valor FLOAT NOT NULL,
                dataInclusao DATETIME NOT NULL,
                CONSTRAINT pi_itemCarrinho_pk PRIMARY KEY (itemCarrinhoId)
)

CREATE TABLE pi_regulamento (
                regulamentoId INT IDENTITY NOT NULL,
                tipoRegulamentoId INT NOT NULL,
                url VARCHAR(256) NOT NULL,
                texto VARCHAR(2048) NOT NULL,
                versao SMALLINT NOT NULL,
                observacao VARCHAR(256) NOT NULL,
                dataRegistro DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_regulamento_pk PRIMARY KEY (regulamentoId)
)

CREATE TABLE seg_perfil (
                perfilId INT IDENTITY NOT NULL,
                nome VARCHAR(64) NOT NULL,
                descricao VARCHAR(256) NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT seg_perfil_pk PRIMARY KEY (perfilId)
)

CREATE TABLE seg_permissao (
                permissaoId INT IDENTITY NOT NULL,
                paiPermissaoId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                descricao VARCHAR(256) NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT permissao_pk PRIMARY KEY (permissaoId)
)

CREATE TABLE seg_tipoPermissao (
                tipoPermissaoId INT IDENTITY NOT NULL,
                permissaoId INT NOT NULL,
                nome VARCHAR(64) NOT NULL,
                CONSTRAINT seg_tipoPermissao_pk PRIMARY KEY (tipoPermissaoId)
)

CREATE TABLE seg_permissaoPerfil (
                permissaoPerfilId INT IDENTITY NOT NULL,
                perfilId INT NOT NULL,
                permissaoId INT NOT NULL,
                CONSTRAINT seg_permissaoPerfil_pk PRIMARY KEY (permissaoPerfilId)
)

CREATE TABLE seg_usuario (
                usuarioId INT IDENTITY NOT NULL,
                email VARCHAR(64) NOT NULL,
                emailConfirmado BIT DEFAULT (0) NOT NULL,
                senha VARCHAR(64) NOT NULL,
                dataFimBloqueio DATETIME,
                bloqueioHabilitado BIT DEFAULT (0) NOT NULL,
                qtdeFalhasAcesso SMALLINT NOT NULL,
                userName VARCHAR(64) NOT NULL,
                nome VARCHAR(128) NOT NULL,
                dataNascimento DATETIME NOT NULL,
                ativo BIT NOT NULL,
                cpf INT NOT NULL,
                rg INT NOT NULL,
                orgaoEmissorRg VARCHAR(4) NOT NULL,
                genero VARCHAR(16) NOT NULL,
                dataCadastro DATETIME NOT NULL,
                dataUltimoAcesso DATETIME,
                telefone INT NOT NULL,
                urlFotoPerfil VARCHAR,
                estadoCivil VARCHAR(16) NOT NULL,
                CONSTRAINT seg_usuario_pk PRIMARY KEY (usuarioId)
)
CREATE UNIQUE  NONCLUSTERED INDEX seg_usuario_idx_cpf
 ON seg_usuario
 ( cpf )

CREATE  NONCLUSTERED INDEX seg_usuario_idx_nome
 ON seg_usuario
 ( nome )

CREATE  NONCLUSTERED INDEX seg_usuario_idx_email
 ON seg_usuario
 ( email )


CREATE TABLE pi_cadastroUsuario (
                cadastroUsuarioId INT IDENTITY NOT NULL,
                usuarioId INT NOT NULL,
                matricula VARCHAR NOT NULL,
                dataCadastro DATETIME NOT NULL,
                dataAlteracao DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_cadastroUsuario_pk PRIMARY KEY (cadastroUsuarioId)
)

CREATE TABLE pi_usuarioEndereco (
                usuarioEnderecoId INT IDENTITY NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                logradouroId INT NOT NULL,
                numero SMALLINT NOT NULL,
                complemento VARCHAR(32),
                CONSTRAINT pi_usuarioEndereco_pk PRIMARY KEY (usuarioEnderecoId)
)

CREATE TABLE pi_resgate (
                resgateId INT IDENTITY NOT NULL,
                carrinhoId INT NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                resgateEnderecoId INT NOT NULL,
                valorNF FLOAT NOT NULL,
                data DATETIME NOT NULL,
                dataEstimadaEntrega DATETIME NOT NULL,
                dataEntrega DATETIME NOT NULL,
                observacao VARCHAR(256) NOT NULL,
                CONSTRAINT pi_resgate_pk PRIMARY KEY (resgateId)
)

CREATE TABLE pi_listaDesejo (
                listaDesejoId INT IDENTITY NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                valorTotal FLOAT NOT NULL,
                dataAlteracao DATETIME NOT NULL,
                CONSTRAINT pi_listaDesejo_pk PRIMARY KEY (listaDesejoId)
)

CREATE TABLE pi_itemListaDesejo (
                itemListaDesejo INT NOT NULL,
                listaDesejoId INT NOT NULL,
                premioId INT NOT NULL,
                valor FLOAT NOT NULL,
                dataInclusao DATETIME NOT NULL,
                CONSTRAINT pi_itemListaDesejo_pk PRIMARY KEY (itemListaDesejo)
)

CREATE TABLE pi_dadoContato (
                dadoContatoId INT IDENTITY NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                tipoContatoId INT NOT NULL,
                conteudo VARCHAR(64) NOT NULL,
                CONSTRAINT pi_dadoContato_pk PRIMARY KEY (dadoContatoId)
)

CREATE TABLE pi_preCadastroUsuario (
                preCadastroUsuarioId INT IDENTITY NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                aprovado BIT NOT NULL,
                analisado BIT NOT NULL,
                dataAnalise DATETIME,
                comoFicouSabendo VARCHAR(256) NOT NULL,
                CONSTRAINT pi_preCadastroUsuario_pk PRIMARY KEY (preCadastroUsuarioId)
)

CREATE TABLE pi_regulamentoAceite (
                regulamentoAceiteId INT IDENTITY NOT NULL,
                regulamentoId INT NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                dataAceite DATETIME NOT NULL,
                aceite BIT NOT NULL,
                CONSTRAINT pi_regulamentoAceite_pk PRIMARY KEY (regulamentoAceiteId)
)

CREATE TABLE pi_usuarioPrograma (
                usuarioProgramaId INT IDENTITY NOT NULL,
                cadastroUsuarioId INT NOT NULL,
                faseSegmentoId INT NOT NULL,
                dataVinculacao DATETIME NOT NULL,
                ativo BIT NOT NULL,
                CONSTRAINT pi_usuarioPrograma_pk PRIMARY KEY (usuarioProgramaId)
)

CREATE TABLE pi_ponto (
                pontoId INT IDENTITY NOT NULL,
                usuarioProgramaId INT NOT NULL,
                quantidadePontos INT NOT NULL,
                ativo BIT NOT NULL,
                data DATETIME NOT NULL,
                descricao VARCHAR(256) NOT NULL,
                CONSTRAINT pi_ponto_pk PRIMARY KEY (pontoId)
)

CREATE TABLE seg_usuarioPerfil (
                usuarioPerfilId INT IDENTITY NOT NULL,
                usuarioId INT NOT NULL,
                perfilId INT NOT NULL,
                dataConcessao DATETIME NOT NULL,
                dataFim DATETIME,
                CONSTRAINT seg_usuarioPerfil_pk PRIMARY KEY (usuarioPerfilId)
)

CREATE TABLE seg_permissaoUsuario (
                permissaoUsuarioId INT IDENTITY NOT NULL,
                usuarioId INT NOT NULL,
                permissaoId INT NOT NULL,
                dataConcessao DATETIME NOT NULL,
                dataFim DATETIME,
                CONSTRAINT seg_permissaoUsuario_pk PRIMARY KEY (permissaoUsuarioId)
)

ALTER TABLE pi_premio ADD CONSTRAINT pi_skuPremio_pi_premio_fk
FOREIGN KEY (skuPremioId)
REFERENCES pi_skuPremio (skuPremioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_skuImagem ADD CONSTRAINT pi_skuPremio_pi_skuImagem_fk
FOREIGN KEY (skuPremioId)
REFERENCES pi_skuPremio (skuPremioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_itemCarrinho ADD CONSTRAINT pi_carrinho_pi_itemCarrinho_fk
FOREIGN KEY (carrinhoId)
REFERENCES pi_carrinho (carrinhoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_resgate ADD CONSTRAINT pi_carrinho_pi_resgate_fk
FOREIGN KEY (carrinhoId)
REFERENCES pi_carrinho (carrinhoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_premio ADD CONSTRAINT pi_parceiro_pi_premio_fk
FOREIGN KEY (parceiroId)
REFERENCES pi_parceiro (parceiroId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_produtoFichaTecnica ADD CONSTRAINT pi_fichaTecnicaItem_pi_produtoFichaTecnica_fk
FOREIGN KEY (fichaTecnicaItemId)
REFERENCES pi_fichaTecnicaItem (fichaTecnicaItemId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_produto ADD CONSTRAINT pi_produtoCategoria_pi_produto_fk
FOREIGN KEY (produtoCategoriaId)
REFERENCES pi_produtoCategoria (produtoCategoriaId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_produtoCategoria ADD CONSTRAINT pi_produtoCategoria_pi_produtoCategoria_fk
FOREIGN KEY (paiProdutoCategoriaId)
REFERENCES pi_produtoCategoria (produtoCategoriaId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_produtoFichaTecnica ADD CONSTRAINT pi_produto_pi_produtoFichaTecnica_fk
FOREIGN KEY (produtoId)
REFERENCES pi_produto (produtoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_premio ADD CONSTRAINT pi_produto_pi_premio_fk
FOREIGN KEY (produtoId)
REFERENCES pi_produto (produtoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_estado ADD CONSTRAINT pi_pais_pi_estado_fk
FOREIGN KEY (paisId)
REFERENCES pi_pais (paisId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_cidade ADD CONSTRAINT pi_estado_pi_cidade_fk
FOREIGN KEY (estadoId)
REFERENCES pi_estado (estadoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_bairro ADD CONSTRAINT pi_cidade_pi_bairro_fk
FOREIGN KEY (cidadeId)
REFERENCES pi_cidade (cidadeId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_logradouro ADD CONSTRAINT pi_bairro_pi_logradouro_fk
FOREIGN KEY (bairroId)
REFERENCES pi_bairro (bairroId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_logradouro ADD CONSTRAINT pi_tipoLogradouro_pi_logradouro_fk
FOREIGN KEY (tipoLogradouroId)
REFERENCES pi_tipoLogradouro (tipoLogradouroId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_resgateEndereco ADD CONSTRAINT pi_logradouro_pi_resgateEndereco_fk
FOREIGN KEY (logradouroId)
REFERENCES pi_logradouro (logradouroId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_usuarioEndereco ADD CONSTRAINT pi_logradouro_pi_usuarioEndereco_fk
FOREIGN KEY (logradouroId)
REFERENCES pi_logradouro (logradouroId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_resgate ADD CONSTRAINT pi_resgateEndereco_pi_resgate_fk
FOREIGN KEY (resgateEnderecoId)
REFERENCES pi_resgateEndereco (resgateEnderecoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_resgate ADD CONSTRAINT pi_resgateEndereco_pi_resgate_fk1
FOREIGN KEY (resgateEnderecoId)
REFERENCES pi_resgateEndereco (resgateEnderecoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_dadoContato ADD CONSTRAINT pi_tipoContato_pi_dadoContato_fk
FOREIGN KEY (tipoContatoId)
REFERENCES pi_tipoContato (tipoContatoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_regulamento ADD CONSTRAINT pi_tipoRegulamento_pi_regulamento_fk
FOREIGN KEY (tipoRegulamentoId)
REFERENCES pi_tipoRegulamento (tipoRegulamentoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_programa ADD CONSTRAINT pi_cliente_pi_programa_fk
FOREIGN KEY (clienteId)
REFERENCES pi_cliente (clienteId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_segmento ADD CONSTRAINT pi_segmentoTipo_pi_segmento_fk
FOREIGN KEY (segmentoTipoId)
REFERENCES pi_segmentoTipo (segmentoTipoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_segmento ADD CONSTRAINT pi_segmento_pi_segmento_fk
FOREIGN KEY (paiSegmentoId)
REFERENCES pi_segmento (segmentoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_faseSegmento ADD CONSTRAINT pi_segmento_pi_faseSegmento_fk
FOREIGN KEY (segmentoId)
REFERENCES pi_segmento (segmentoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_fase ADD CONSTRAINT pi_programa_pi_fase_fk
FOREIGN KEY (programaId)
REFERENCES pi_programa (programaId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_faseSegmento ADD CONSTRAINT pi_fase_pi_faseSegmento_fk
FOREIGN KEY (faseId)
REFERENCES pi_fase (faseId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_usuarioPrograma ADD CONSTRAINT pi_faseSegmento_pi_usuarioPrograma_fk
FOREIGN KEY (faseSegmentoId)
REFERENCES pi_faseSegmento (faseSegmentoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_premio ADD CONSTRAINT pi_faseSegmento_pi_premio_fk
FOREIGN KEY (faseSegmentoId)
REFERENCES pi_faseSegmento (faseSegmentoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_itemCarrinho ADD CONSTRAINT pi_premio_pi_itemCarrinho_fk
FOREIGN KEY (premioId)
REFERENCES pi_premio (premioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_itemListaDesejo ADD CONSTRAINT pi_premio_pi_itemListaDesejo_fk
FOREIGN KEY (premioId)
REFERENCES pi_premio (premioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_regulamentoAceite ADD CONSTRAINT pi_regulamento_pi_regulamentoAceite_fk
FOREIGN KEY (regulamentoId)
REFERENCES pi_regulamento (regulamentoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_permissaoPerfil ADD CONSTRAINT seg_perfil_seg_permissaoPerfil_fk
FOREIGN KEY (perfilId)
REFERENCES seg_perfil (perfilId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_usuarioPerfil ADD CONSTRAINT seg_perfil_seg_usuarioPerfil_fk
FOREIGN KEY (perfilId)
REFERENCES seg_perfil (perfilId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_permissaoUsuario ADD CONSTRAINT seg_permissao_seg_permissaoUsuario_fk
FOREIGN KEY (permissaoId)
REFERENCES seg_permissao (permissaoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_permissao ADD CONSTRAINT seg_permissao_seg_permissao_fk
FOREIGN KEY (paiPermissaoId)
REFERENCES seg_permissao (permissaoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_permissaoPerfil ADD CONSTRAINT seg_permissao_seg_permissaoPerfil_fk
FOREIGN KEY (permissaoId)
REFERENCES seg_permissao (permissaoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_tipoPermissao ADD CONSTRAINT seg_permissao_seg_tipoPermissao_fk
FOREIGN KEY (permissaoId)
REFERENCES seg_permissao (permissaoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_permissaoUsuario ADD CONSTRAINT seg_usuario_seg_permissaoUsuario_fk
FOREIGN KEY (usuarioId)
REFERENCES seg_usuario (usuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE seg_usuarioPerfil ADD CONSTRAINT seg_usuario_seg_usuarioPerfil_fk
FOREIGN KEY (usuarioId)
REFERENCES seg_usuario (usuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_cadastroUsuario ADD CONSTRAINT seg_usuario_pi_cadastroUsuario_fk
FOREIGN KEY (usuarioId)
REFERENCES seg_usuario (usuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_usuarioPrograma ADD CONSTRAINT pi_cadastroUsuario_pi_usuarioPrograma_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_regulamentoAceite ADD CONSTRAINT pi_cadastroUsuario_pi_regulamentoAceite_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_preCadastroUsuario ADD CONSTRAINT pi_cadastroUsuario_pi_preCadastroUsuario_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_dadoContato ADD CONSTRAINT pi_cadastroUsuario_pi_dadoContato_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_listaDesejo ADD CONSTRAINT pi_cadastroUsuario_pi_listaDesejo_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_resgate ADD CONSTRAINT pi_cadastroUsuario_pi_resgate_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_usuarioEndereco ADD CONSTRAINT pi_cadastroUsuario_pi_usuarioEndereco_fk
FOREIGN KEY (cadastroUsuarioId)
REFERENCES pi_cadastroUsuario (cadastroUsuarioId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_itemListaDesejo ADD CONSTRAINT pi_listaDesejo_pi_itemListaDesejo_fk
FOREIGN KEY (listaDesejoId)
REFERENCES pi_listaDesejo (listaDesejoId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE pi_ponto ADD CONSTRAINT pi_usuarioPrograma_pi_ponto_fk
FOREIGN KEY (usuarioProgramaId)
REFERENCES pi_usuarioPrograma (usuarioProgramaId)
ON DELETE NO ACTION
ON UPDATE NO ACTION
