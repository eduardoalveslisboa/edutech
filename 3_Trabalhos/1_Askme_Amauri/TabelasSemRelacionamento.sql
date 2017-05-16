/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      teste
 * Project :      DATA MODEL
 * Author :       teste
 *
 * Date Created : Sunday, May 07, 2017 18:31:26
 * Target DBMS : Microsoft SQL Server 2008
 */

/* 
 * TABLE: api_avatar 
 */

CREATE TABLE api_avatar(
    id_Avatar          int             IDENTITY(1,1),
    profissionalId     int             NOT NULL,
    imagem             varchar(255)    NULL,
    dataCriacao        char(10)        NULL,
    dataAtualizacao    char(10)        NULL,
    int_Ativo          bit             NULL
)
go



IF OBJECT_ID('api_avatar') IS NOT NULL
    PRINT '<<< CREATED TABLE api_avatar >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE api_avatar >>>'
go

/* 
 * TABLE: api_avatar_elementos 
 */

CREATE TABLE api_avatar_elementos(
    id_Elemento_Avatar    int             IDENTITY(1,1),
    elemento              varchar(255)    NOT NULL,
    tipoElementoId        int             NOT NULL,
    dataInicio            char(10)        NULL,
    dataFim               char(10)        NULL,
    int_Ativo             bit             NOT NULL
)
go



IF OBJECT_ID('api_avatar_elementos') IS NOT NULL
    PRINT '<<< CREATED TABLE api_avatar_elementos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE api_avatar_elementos >>>'
go

/* 
 * TABLE: api_avatar_elementos_tipo 
 */

CREATE TABLE api_avatar_elementos_tipo(
    id_Tipo_Elemento    int            IDENTITY(1,1),
    tipoElemento        varchar(50)    NOT NULL
)
go



IF OBJECT_ID('api_avatar_elementos_tipo') IS NOT NULL
    PRINT '<<< CREATED TABLE api_avatar_elementos_tipo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE api_avatar_elementos_tipo >>>'
go

/* 
 * TABLE: api_avatar_elementos_usuario 
 */

CREATE TABLE api_avatar_elementos_usuario(
    id_Elemento       int             IDENTITY(1,1),
    avatarId          int             NOT NULL,
    elemento          varchar(255)    NOT NULL,
    tipoElementoId    int             NULL
)
go



IF OBJECT_ID('api_avatar_elementos_usuario') IS NOT NULL
    PRINT '<<< CREATED TABLE api_avatar_elementos_usuario >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE api_avatar_elementos_usuario >>>'
go

/* 
 * TABLE: dp_tb_categoria 
 */

CREATE TABLE dp_tb_categoria(
    id              int               IDENTITY(1,1),
    categoria       nvarchar(250)     NULL,
    nv_categoria    nvarchar(250)     NULL,
    nv_site         bit               CONSTRAINT [DF_tb_categoria_nv_site] DEFAULT ((0)) NULL,
    posicao         numeric(18, 0)    NULL
)
go



IF OBJECT_ID('dp_tb_categoria') IS NOT NULL
    PRINT '<<< CREATED TABLE dp_tb_categoria >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dp_tb_categoria >>>'
go

/* 
 * TABLE: dp_tb_clientes 
 */

CREATE TABLE dp_tb_clientes(
    id                int             IDENTITY(1,1),
    str_Nome          varchar(255)    NOT NULL,
    foto_pequena      varchar(255)    NOT NULL,
    foto_principal    varchar(255)    NOT NULL,
    fl_ativo          int             NULL
)
go



IF OBJECT_ID('dp_tb_clientes') IS NOT NULL
    PRINT '<<< CREATED TABLE dp_tb_clientes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dp_tb_clientes >>>'
go

/* 
 * TABLE: dp_tb_experiencias 
 */

CREATE TABLE dp_tb_experiencias(
    id                 int               IDENTITY(1,1),
    id_categoria       int               NULL,
    id_subcategoria    int               NULL,
    destaque           bit               NOT NULL,
    ativo              bit               NOT NULL,
    viva               bit               NOT NULL,
    lancamento         bit               NOT NULL,
    nome               nvarchar(250)     NULL,
    nomeobs            nvarchar(250)     NULL,
    cod                nvarchar(50)      NULL,
    preco              float             NULL,
    duracao            nvarchar(250)     NULL,
    valor              int               NULL,
    nivel              int               NULL,
    descricao          nvarchar(4000)    NULL,
    precisa            nvarchar(4000)    NULL,
    levar              nvarchar(4000)    NULL,
    cidade             nvarchar(50)      NULL,
    estado             nvarchar(50)      NULL,
    pais               nvarchar(50)      NULL,
    id_pais            int               NULL,
    etaria             nvarchar(50)      NULL,
    pessoas            nvarchar(250)     NULL,
    imagem             nvarchar(250)     NULL,
    imagempri          nvarchar(250)     NULL,
    datacad            char(10)          NULL,
    dataatu            char(10)          NULL,
    topo               bit               NOT NULL,
    kids               bit               NOT NULL,
    bebe               bit               NOT NULL,
    casamento          bit               NOT NULL,
    nv_site            bit               NULL
)
go



IF OBJECT_ID('dp_tb_experiencias') IS NOT NULL
    PRINT '<<< CREATED TABLE dp_tb_experiencias >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dp_tb_experiencias >>>'
go

/* 
 * TABLE: dp_tb_pais 
 */

CREATE TABLE dp_tb_pais(
    id         int               IDENTITY(1,1),
    nome       nvarchar(250)     NULL,
    posicao    numeric(18, 0)    NULL
)
go



IF OBJECT_ID('dp_tb_pais') IS NOT NULL
    PRINT '<<< CREATED TABLE dp_tb_pais >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dp_tb_pais >>>'
go

/* 
 * TABLE: dp_vinculo_experiencia 
 */

CREATE TABLE dp_vinculo_experiencia(
    id                 int    IDENTITY(1,1),
    id_categoria       int    NOT NULL,
    id_experiencias    int    NOT NULL,
    CONSTRAINT PK_dp_vinculo_experiencia PRIMARY KEY NONCLUSTERED (id)
)
go



IF OBJECT_ID('dp_vinculo_experiencia') IS NOT NULL
    PRINT '<<< CREATED TABLE dp_vinculo_experiencia >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dp_vinculo_experiencia >>>'
go

/* 
 * TABLE: integracao 
 */

CREATE TABLE integracao(
    id_integracao    bigint            IDENTITY(1,1),
    id_programa      int               NOT NULL,
    id_fase          int               NOT NULL,
    parceiro         varchar(70)       NULL,
    nome_fantazia    varchar(70)       NULL,
    razao_social     varchar(150)      NULL,
    cnpj             numeric(14, 0)    NULL,
    contrato         varchar(10)       NOT NULL,
    cliente          int               NULL,
    campanha         int               NULL,
    url_servico      varchar(250)      NULL,
    ativo            char(1)           NULL,
    dt_insercao      char(10)          NULL,
    dt_alteracao     char(10)          NULL,
    id_usuario       int               NULL
)
go



IF OBJECT_ID('integracao') IS NOT NULL
    PRINT '<<< CREATED TABLE integracao >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE integracao >>>'
go

/* 
 * TABLE: pi_adm_administradores 
 */

CREATE TABLE pi_adm_administradores(
    id_Admin        int              IDENTITY(1,1),
    id_Perfil       int              NULL,
    str_Nome        nvarchar(150)    NULL,
    str_Senha       nvarchar(50)     NULL,
    str_Email       nvarchar(150)    NULL,
    int_Ativo       int              NULL,
    avatar          varchar(50)      CONSTRAINT [DF_pi_adm_administradores_avatar] DEFAULT ('avatar.jpg') NULL,
    dt_Cadastro     char(10)         NULL,
    dt_Alteracao    char(10)         CONSTRAINT [DF_pi_adm_administradores_dt_Alteracao] DEFAULT (getdate()) NULL,
    online          char(1)          CONSTRAINT [DF_pi_adm_administradores_online] DEFAULT ('N') NULL,
    CONSTRAINT PK_pi_adm_administradores PRIMARY KEY NONCLUSTERED (id_Admin)
)
go



IF OBJECT_ID('pi_adm_administradores') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_administradores >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_administradores >>>'
go

/* 
 * TABLE: pi_adm_agenda 
 */

CREATE TABLE pi_adm_agenda(
    id_Agenda       int            IDENTITY(1,1),
    id_Programa     int            NOT NULL,
    id_Fase         int            NOT NULL,
    dt_Evento       date           NOT NULL,
    str_Titulo      varchar(70)    NOT NULL,
    str_Conteudo    text           NOT NULL,
    int_Ativo       int            NOT NULL,
    CONSTRAINT PK_pi_adm_agenda PRIMARY KEY NONCLUSTERED (id_Agenda)
)
go



IF OBJECT_ID('pi_adm_agenda') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_agenda >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_agenda >>>'
go

/* 
 * TABLE: pi_adm_agenda_empresa 
 */

CREATE TABLE pi_adm_agenda_empresa(
    id_Agenda     int    NOT NULL,
    id_Empresa    int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_agenda_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_agenda_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_agenda_empresa >>>'
go

/* 
 * TABLE: pi_adm_album_categoria 
 */

CREATE TABLE pi_adm_album_categoria(
    id_Categoria     int            IDENTITY(1,1),
    str_Descricao    varchar(50)    NOT NULL,
    CONSTRAINT PK_pi_adm_album_categoria PRIMARY KEY NONCLUSTERED (id_Categoria)
)
go



IF OBJECT_ID('pi_adm_album_categoria') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_album_categoria >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_album_categoria >>>'
go

/* 
 * TABLE: pi_adm_albuns 
 */

CREATE TABLE pi_adm_albuns(
    id_Foto          int            IDENTITY(1,1),
    int_Categoria    int            NOT NULL,
    id_Album         int            NOT NULL,
    str_Legenda      varchar(60)    NULL,
    str_Foto         varchar(60)    NOT NULL,
    CONSTRAINT PK_pi_adm_albuns PRIMARY KEY NONCLUSTERED (id_Foto)
)
go



IF OBJECT_ID('pi_adm_albuns') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_albuns >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_albuns >>>'
go

/* 
 * TABLE: pi_adm_cartao_bandeira 
 */

CREATE TABLE pi_adm_cartao_bandeira(
    id_Cartao_Bandeira        int              IDENTITY(1,1),
    id_Programa               int              NOT NULL,
    id_Fase                   int              NOT NULL,
    val_Valor_Disponivel      numeric(8, 2)    NOT NULL,
    val_Porcentagem_Alerta    nchar(10)        NOT NULL,
    val_Porcentagem_Final     nchar(10)        NULL,
    dt_Periodo_Inicial        char(10)         NULL,
    dt_Periodo_Final          char(10)         NULL,
    int_Alerta                int              NULL,
    int_Ativo                 int              NULL
)
go



IF OBJECT_ID('pi_adm_cartao_bandeira') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_cartao_bandeira >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_cartao_bandeira >>>'
go

/* 
 * TABLE: pi_adm_cartao_rateios 
 */

CREATE TABLE pi_adm_cartao_rateios(
    id                  int          IDENTITY(1,1),
    cpf                 nchar(11)    NULL,
    valor               nchar(15)    NULL,
    dt_resgate          char(10)     NULL,
    taxa_adm            nchar(10)    NULL,
    taxa_adm_imposto    nchar(10)    NULL,
    frete               nchar(10)    NULL,
    frete_imposto       nchar(10)    NULL,
    valor_cobrado       nchar(10)    NULL,
    bv                  nchar(10)    NULL,
    dt_upload           char(10)     NULL,
    cod_admin           int          NULL,
    dt_alteracao        char(10)     CONSTRAINT [DF_pi_adm_cartao_rateios_dt_alteracao] DEFAULT ('1901-01-01 00:00:00') NULL
)
go



IF OBJECT_ID('pi_adm_cartao_rateios') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_cartao_rateios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_cartao_rateios >>>'
go

/* 
 * TABLE: pi_adm_categoria 
 */

CREATE TABLE pi_adm_categoria(
    id_Categoria     int            IDENTITY(1,1),
    str_Descricao    varchar(50)    NOT NULL,
    CONSTRAINT PK_pi_adm_categoria PRIMARY KEY NONCLUSTERED (id_Categoria)
)
go



IF OBJECT_ID('pi_adm_categoria') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_categoria >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_categoria >>>'
go

/* 
 * TABLE: pi_adm_categoria_cliente 
 */

CREATE TABLE pi_adm_categoria_cliente(
    id_Categoria     int     IDENTITY(1,1),
    id_Programa      int     NULL,
    id_Fase          int     NULL,
    str_Nome         text    NULL,
    str_Descricao    text    NULL,
    int_Ativo        int     NULL
)
go



IF OBJECT_ID('pi_adm_categoria_cliente') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_categoria_cliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_categoria_cliente >>>'
go

/* 
 * TABLE: pi_adm_comentario 
 */

CREATE TABLE pi_adm_comentario(
    id_Comentario     int             IDENTITY(1,1),
    id_Noticia        int             NOT NULL,
    id_Usuario        int             NOT NULL,
    str_Comentario    varchar(255)    NOT NULL,
    dt_Postagem       char(10)        NULL,
    int_Aprovado      int             CONSTRAINT [DF_pi_adm_comentario_int_Aprovado] DEFAULT ((0)) NULL,
    CONSTRAINT PK_pi_adm_comentario PRIMARY KEY NONCLUSTERED (id_Comentario)
)
go



IF OBJECT_ID('pi_adm_comentario') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_comentario >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_comentario >>>'
go

/* 
 * TABLE: pi_adm_contato_formulario 
 */

CREATE TABLE pi_adm_contato_formulario(
    id_Contato      int               IDENTITY(1,1),
    str_Programa    nvarchar(50)      NULL,
    str_Pagina      varchar(4000)     NULL,
    str_Nome        varchar(50)       NULL,
    str_Email       varchar(50)       NULL,
    str_Cpf         varchar(50)       NULL,
    str_Telefone    nvarchar(50)      NULL,
    str_Mensagem    varchar(4000)     NULL,
    str_Campo       nvarchar(4000)    NULL,
    dt_Insercao     char(10)          NOT NULL
)
go



IF OBJECT_ID('pi_adm_contato_formulario') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_contato_formulario >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_contato_formulario >>>'
go

/* 
 * TABLE: pi_adm_controle_programa 
 */

CREATE TABLE pi_adm_controle_programa(
    id_Admin       int    NOT NULL,
    id_Programa    int    NOT NULL,
    CONSTRAINT PK_pi_adm_controle_programa PRIMARY KEY NONCLUSTERED (id_Admin, id_Programa)
)
go



IF OBJECT_ID('pi_adm_controle_programa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_controle_programa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_controle_programa >>>'
go

/* 
 * TABLE: pi_adm_dreammoney_troca 
 */

CREATE TABLE pi_adm_dreammoney_troca(
    id                    int             IDENTITY(1,1),
    id_Premio             int             NULL,
    id_Resgate            int             NULL,
    int_Status_Resgate    int             NULL,
    valor_Resgate         real            NULL,
    id_Resgate_Troco      int             NULL,
    valor_Troco           real            NULL,
    data_Troca            datetime2(7)    NULL,
    id_Usuario            int             NULL
)
go



IF OBJECT_ID('pi_adm_dreammoney_troca') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_dreammoney_troca >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_dreammoney_troca >>>'
go

/* 
 * TABLE: pi_adm_empreendimentos 
 */

CREATE TABLE pi_adm_empreendimentos(
    id_Empreendimento    int              IDENTITY(1,1),
    id_Programa          int              NULL,
    id_Fase              int              NULL,
    str_Nome             nvarchar(80)     NOT NULL,
    str_Logo             nvarchar(50)     NOT NULL,
    str_Peso             char(2)          NOT NULL,
    str_Site             nvarchar(150)    NULL,
    str_Mapa             nvarchar(50)     NULL,
    str_Resumo           text             NULL,
    str_Arquivo1         nvarchar(80)     NULL,
    str_Arquivo2         nvarchar(80)     NULL,
    str_Arquivo3         nvarchar(80)     NULL,
    int_Ativo            int              NOT NULL,
    CONSTRAINT PK_pi_adm_empreendimentos PRIMARY KEY NONCLUSTERED (id_Empreendimento)
)
go



IF OBJECT_ID('pi_adm_empreendimentos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_empreendimentos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_empreendimentos >>>'
go

/* 
 * TABLE: pi_adm_empresa_empreendimento 
 */

CREATE TABLE pi_adm_empresa_empreendimento(
    id_Empresa           int    NOT NULL,
    id_Empreendimento    int    NOT NULL,
    CONSTRAINT PK_pi_adm_empresa_empreendimento PRIMARY KEY NONCLUSTERED (id_Empresa, id_Empreendimento)
)
go



IF OBJECT_ID('pi_adm_empresa_empreendimento') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_empresa_empreendimento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_empresa_empreendimento >>>'
go

/* 
 * TABLE: pi_adm_endereco 
 */

CREATE TABLE pi_adm_endereco(
    id_Logradouro      int             IDENTITY(1,1),
    id_Profissional    int             NOT NULL,
    str_Logradouro     varchar(150)    NULL,
    str_Numero         varchar(10)     NULL,
    str_Complemento    varchar(150)    NULL,
    str_Bairro         varchar(100)    NULL,
    int_Regiao         int             NULL,
    str_CEP            varchar(9)      NOT NULL,
    str_Cidade         varchar(100)    NULL,
    str_UF             char(2)         NULL,
    CONSTRAINT PK_pi_adm_endereco PRIMARY KEY NONCLUSTERED (id_Logradouro, id_Profissional)
)
go



IF OBJECT_ID('pi_adm_endereco') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_endereco >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_endereco >>>'
go

/* 
 * TABLE: pi_adm_enigma 
 */

CREATE TABLE pi_adm_enigma(
    id_Enigma    int             IDENTITY(1,1),
    str_Img      varchar(255)    NULL,
    str_Dica     varchar(255)    NULL,
    dt_Ini       char(10)        NULL,
    CONSTRAINT PK_pi_adm_enigma PRIMARY KEY NONCLUSTERED (id_Enigma)
)
go



IF OBJECT_ID('pi_adm_enigma') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_enigma >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_enigma >>>'
go

/* 
 * TABLE: pi_adm_enigma_resp 
 */

CREATE TABLE pi_adm_enigma_resp(
    id_Resposta        int         IDENTITY(1,1),
    id_Profissional    int         NOT NULL,
    str_Resposta       text        NULL,
    dt_Resposta        char(10)    NULL,
    CONSTRAINT PK_pi_adm_enigma_resp PRIMARY KEY NONCLUSTERED (id_Resposta, id_Profissional)
)
go



IF OBJECT_ID('pi_adm_enigma_resp') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_enigma_resp >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_enigma_resp >>>'
go

/* 
 * TABLE: pi_adm_faq 
 */

CREATE TABLE pi_adm_faq(
    id_Faq          int              IDENTITY(1,1),
    id_Programa     int              NOT NULL,
    id_Fase         int              NOT NULL,
    str_Titulo      nvarchar(250)    NOT NULL,
    str_Conteudo    text             NOT NULL,
    int_Ordem       int              NOT NULL,
    int_Ativo       int              NOT NULL,
    str_Praca       varchar(255)     NULL,
    CONSTRAINT PK_pi_adm_faq PRIMARY KEY NONCLUSTERED (id_Faq)
)
go



IF OBJECT_ID('pi_adm_faq') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_faq >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_faq >>>'
go

/* 
 * TABLE: pi_adm_faq_empresa 
 */

CREATE TABLE pi_adm_faq_empresa(
    id_Faq        int    NOT NULL,
    id_Empresa    int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_faq_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_faq_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_faq_empresa >>>'
go

/* 
 * TABLE: pi_adm_faq_praca 
 */

CREATE TABLE pi_adm_faq_praca(
    id_Faq        int    NOT NULL,
    id_Praca      int    NOT NULL,
    id_Empresa    int    NULL
)
go



IF OBJECT_ID('pi_adm_faq_praca') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_faq_praca >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_faq_praca >>>'
go

/* 
 * TABLE: pi_adm_fase_empreendimento 
 */

CREATE TABLE pi_adm_fase_empreendimento(
    id_Fase              int    NOT NULL,
    id_Empreendimento    int    NOT NULL,
    CONSTRAINT PK_pi_adm_fase_empre PRIMARY KEY NONCLUSTERED (id_Fase, id_Empreendimento)
)
go



IF OBJECT_ID('pi_adm_fase_empreendimento') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fase_empreendimento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fase_empreendimento >>>'
go

/* 
 * TABLE: pi_adm_fastshop_rateios 
 */

CREATE TABLE pi_adm_fastshop_rateios(
    id                        int             IDENTITY(1,1),
    dt_pedido                 char(10)        NULL,
    programa_de_incentivos    varchar(50)     NULL,
    nome_do_patrocinador      varchar(50)     NULL,
    cpf                       nchar(11)       NULL,
    participante              varchar(250)    NULL,
    pedido_site               varchar(50)     NULL,
    nf                        varchar(20)     NULL,
    w3                        varchar(20)     NULL,
    produto                   varchar(250)    NULL,
    preco                     nchar(15)       NULL,
    frete                     nchar(15)       NULL,
    sku                       varchar(20)     NULL,
    dt_upload                 char(10)        NULL,
    cod_admin                 int             NULL,
    dt_alteracao              char(10)        CONSTRAINT [DF_pi_adm_fastshop_rateios_dt_alteracao] DEFAULT ('1901-01-01 00:00:00') NULL
)
go



IF OBJECT_ID('pi_adm_fastshop_rateios') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fastshop_rateios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fastshop_rateios >>>'
go

/* 
 * TABLE: pi_adm_fe_bolao 
 */

CREATE TABLE pi_adm_fe_bolao(
    id_Bolao         int             IDENTITY(1,1),
    str_Matricula    varchar(255)    NULL,
    str_Jogo         varchar(50)     NULL,
    val_Time1        nchar(10)       NULL,
    val_Time2        nchar(10)       NULL,
    str_Descricao    varchar(255)    NULL,
    int_Ativo        nchar(10)       NULL,
    dt_Aposta        char(10)        NOT NULL
)
go



IF OBJECT_ID('pi_adm_fe_bolao') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fe_bolao >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fe_bolao >>>'
go

/* 
 * TABLE: pi_adm_fe_pesquisa 
 */

CREATE TABLE pi_adm_fe_pesquisa(
    id_Pesquisa     int              IDENTITY(1,1),
    id_Programa     int              NOT NULL,
    id_Fase         int              NOT NULL,
    str_Pesquisa    nvarchar(255)    NOT NULL,
    int_Ativo       int              NOT NULL
)
go



IF OBJECT_ID('pi_adm_fe_pesquisa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fe_pesquisa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fe_pesquisa >>>'
go

/* 
 * TABLE: pi_adm_fe_pesquisa_pergunta 
 */

CREATE TABLE pi_adm_fe_pesquisa_pergunta(
    id_Pergunta     int              IDENTITY(1,1),
    id_Pesquisa     int              NOT NULL,
    str_Pergunta    nvarchar(255)    NOT NULL,
    str_Opcao1      nvarchar(255)    NULL,
    str_Opcao2      nvarchar(255)    NULL,
    str_Opcao3      nvarchar(255)    NULL,
    str_Opcao4      nvarchar(255)    NULL,
    str_Opcao5      nvarchar(255)    NULL,
    str_Opcao6      nvarchar(255)    NULL,
    str_Opcao7      nvarchar(255)    NULL,
    str_Opcao8      nvarchar(255)    NULL,
    str_Opcao9      nvarchar(255)    NULL,
    str_Opcao10     nvarchar(255)    NULL,
    str_Opcao11     nvarchar(255)    NULL,
    str_Opcao12     nvarchar(255)    NULL,
    str_Opcao13     nvarchar(255)    NULL,
    str_Opcao14     nvarchar(255)    NULL,
    str_Opcao15     nvarchar(255)    NULL,
    str_Opcao16     nvarchar(255)    NULL,
    str_Opcao17     nvarchar(255)    NULL,
    str_Opcao18     nvarchar(255)    NULL,
    str_Opcao19     nvarchar(255)    NULL,
    str_Opcao20     nvarchar(255)    NULL,
    str_Correta     nvarchar(255)    NULL
)
go



IF OBJECT_ID('pi_adm_fe_pesquisa_pergunta') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fe_pesquisa_pergunta >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fe_pesquisa_pergunta >>>'
go

/* 
 * TABLE: pi_adm_fe_pesquisa_resposta 
 */

CREATE TABLE pi_adm_fe_pesquisa_resposta(
    id_Resposta     int              IDENTITY(1,1),
    id_Usuario      int              NOT NULL,
    id_Pesquisa     int              NOT NULL,
    id_Pergunta     int              NOT NULL,
    str_Resposta    nvarchar(255)    NOT NULL,
    dt_Resposta     char(10)         NULL,
    str_sugestao    varchar(250)     NULL
)
go



IF OBJECT_ID('pi_adm_fe_pesquisa_resposta') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fe_pesquisa_resposta >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fe_pesquisa_resposta >>>'
go

/* 
 * TABLE: pi_adm_financeiro 
 */

CREATE TABLE pi_adm_financeiro(
    id_Financeiro          bigint      IDENTITY(1,1),
    id_Resgate             bigint      NULL,
    status_nota            int         NULL,
    emissao                date        NULL,
    status_cliente         int         NULL,
    pag_cliente            int         NULL,
    dt_prev_cliente        date        NULL,
    dt_receb_cliente       date        NULL,
    status_fornecedor      int         NULL,
    pag_fornecedor         int         NULL,
    dt_prev_fornecedor     date        NULL,
    dt_receb_fornecedor    date        NULL,
    id_movimentacao        int         NULL,
    dt_movimentacao        char(10)    NULL,
    CONSTRAINT PK__pi_adm_f__3A1AB24E19169DBB PRIMARY KEY NONCLUSTERED (id_Financeiro)
)
go



IF OBJECT_ID('pi_adm_financeiro') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_financeiro >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_financeiro >>>'
go

/* 
 * TABLE: pi_adm_flores_on_line 
 */

CREATE TABLE pi_adm_flores_on_line(
    id_Flores            int    IDENTITY(1,1),
    id_Premio            int    NOT NULL,
    id_Produto_Flores    int    NOT NULL,
    int_Ativo            int    NULL
)
go



IF OBJECT_ID('pi_adm_flores_on_line') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_flores_on_line >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_flores_on_line >>>'
go

/* 
 * TABLE: pi_adm_flores_on_line_cupom 
 */

CREATE TABLE pi_adm_flores_on_line_cupom(
    id_Cupom     int            IDENTITY(1,1),
    id_Flores    int            NOT NULL,
    str_Cupom    varchar(50)    NOT NULL,
    int_Usado    int            NOT NULL,
    int_Ativo    int            NOT NULL
)
go



IF OBJECT_ID('pi_adm_flores_on_line_cupom') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_flores_on_line_cupom >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_flores_on_line_cupom >>>'
go

/* 
 * TABLE: pi_adm_fotos_empreendimentos 
 */

CREATE TABLE pi_adm_fotos_empreendimentos(
    id_Foto              int             IDENTITY(1,1),
    id_Empreendimento    int             NOT NULL,
    str_Arquivo          nvarchar(70)    NOT NULL,
    str_Tipo             char(1)         NOT NULL,
    str_Legenda          nvarchar(70)    NULL,
    CONSTRAINT PK_pi_adm_fotos_empreendimentos PRIMARY KEY NONCLUSTERED (id_Foto)
)
go



IF OBJECT_ID('pi_adm_fotos_empreendimentos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_fotos_empreendimentos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_fotos_empreendimentos >>>'
go

/* 
 * TABLE: pi_adm_itens_ranking 
 */

CREATE TABLE pi_adm_itens_ranking(
    id_Item             int               IDENTITY(1,1),
    id_Empreedimento    int               NOT NULL,
    str_CPF             varchar(11)       NOT NULL,
    id_Ranking          int               NOT NULL,
    str_Unidade         varchar(20)       NOT NULL,
    str_Torre           varchar(70)       NOT NULL,
    str_Corretor        varchar(100)      NOT NULL,
    dt_Venda            date              NOT NULL,
    int_Visivel         int               NOT NULL,
    val_VGV             numeric(12, 2)    NULL,
    val_VGVP            numeric(12, 2)    NULL,
    int_Ativo           int               NOT NULL,
    int_Fifty           int               CONSTRAINT [DF_pi_adm_itens_ranking_int_Fift] DEFAULT ((0)) NOT NULL,
    str_Peso            char(2)           NULL,
    int_Pontos          int               CONSTRAINT [DF_pi_adm_itens_ranking_int_Pontos] DEFAULT ((0)) NOT NULL,
    int_Resgate         int               NULL,
    int_divisor         int               NULL,
    dt_insercao         char(10)          NULL,
    dt_alteracao        char(10)          NULL,
    id_usuario          int               NULL,
    CONSTRAINT PK_pi_adm_itens_ranking PRIMARY KEY NONCLUSTERED (id_Item, id_Empreedimento, str_CPF)
)
go



IF OBJECT_ID('pi_adm_itens_ranking') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_itens_ranking >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_itens_ranking >>>'
go

/* 
 * TABLE: pi_adm_links 
 */

CREATE TABLE pi_adm_links(
    id_Link           int             IDENTITY(1,1),
    str_JavaScript    nvarchar(30)    NULL,
    str_Arquivo       nvarchar(30)    NULL,
    str_Nome          nvarchar(30)    NULL,
    str_Url           nvarchar(30)    NULL,
    int_Categoria     int             NULL,
    int_Prioridade    int             NULL,
    int_SubLink       int             NULL,
    int_Ativo         int             NULL,
    CONSTRAINT PK_pi_adm_links PRIMARY KEY NONCLUSTERED (id_Link)
)
go



IF OBJECT_ID('pi_adm_links') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_links >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_links >>>'
go

/* 
 * TABLE: pi_adm_log 
 */

CREATE TABLE pi_adm_log(
    id_Log                 int             IDENTITY(1,1),
    str_Tabela             varchar(255)    NOT NULL,
    id_Admin               int             NOT NULL,
    str_Conteudo_Antes     text            NULL,
    str_Conteudo_Depois    text            NULL,
    str_Pagina             varchar(255)    NULL,
    dt_Data                char(10)        NOT NULL
)
go



IF OBJECT_ID('pi_adm_log') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_log >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_log >>>'
go

/* 
 * TABLE: pi_adm_main 
 */

CREATE TABLE pi_adm_main(
    Application    varchar(50)     NULL,
    URL            varchar(150)    NULL,
    Files          varchar(100)    NULL,
    Libraries      varchar(100)    NULL,
    ID             int             CONSTRAINT [DF_pi_adm_main_ID] DEFAULT ((0)) NOT NULL
)
go



IF OBJECT_ID('pi_adm_main') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_main >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_main >>>'
go

/* 
 * TABLE: pi_adm_melhores_equipes 
 */

CREATE TABLE pi_adm_melhores_equipes(
    id             int            IDENTITY(1,1),
    id_Programa    int            NULL,
    id_Fase        int            NULL,
    str_CPF        varchar(11)    NULL,
    str_Nome       nchar(100)     NULL,
    int_Ativo      tinyint        NULL,
    CONSTRAINT PK_pi_adm_melhores_equipes PRIMARY KEY NONCLUSTERED (id)
)
go



IF OBJECT_ID('pi_adm_melhores_equipes') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_melhores_equipes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_melhores_equipes >>>'
go

/* 
 * TABLE: pi_adm_metas 
 */

CREATE TABLE pi_adm_metas(
    id_Meta        int               IDENTITY(1,1),
    id_Programa    int               NULL,
    id_Fase        int               NULL,
    val_Meta       decimal(18, 2)    NULL,
    dt_periodo     date              NULL,
    fl_ativo       char(1)           CONSTRAINT [DF_pi_adm_metas_fl_ativo] DEFAULT ((1)) NULL,
    CONSTRAINT PK_pi_adm_metas PRIMARY KEY NONCLUSTERED (id_Meta)
)
go



IF OBJECT_ID('pi_adm_metas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas >>>'
go

/* 
 * TABLE: pi_adm_metas_empresa 
 */

CREATE TABLE pi_adm_metas_empresa(
    id_Meta       int    NOT NULL,
    id_Empresa    int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_metas_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_empresa >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg 
 */

CREATE TABLE pi_adm_metas_tudook_pdg(
    id_Meta            int             IDENTITY(1,1),
    str_Equipe         varchar(100)    NOT NULL,
    str_Mecanica       varchar(255)    NOT NULL,
    str_Descricao      varchar(255)    NULL,
    str_Trava          varchar(255)    NULL,
    str_Meta           varchar(255)    NULL,
    str_Bronze         varchar(255)    NULL,
    str_Prata          varchar(255)    NULL,
    str_Ouro           varchar(255)    NULL,
    str_Tipo_Pontos    varchar(100)    NULL,
    id_Praca           int             NOT NULL,
    id_Empresa         int             NULL,
    id_Fase            int             NULL,
    id_Perfil          int             NULL,
    int_Periodo        int             NULL,
    int_Ativo          int             NOT NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_metas_assinaturas 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_metas_assinaturas(
    id_Metas_Assinatura    int             IDENTITY(1,1),
    id_Praca               int             NOT NULL,
    str_Regional           varchar(100)    NOT NULL,
    id_Empresa             int             NOT NULL,
    str_Local              varchar(100)    NOT NULL,
    str_Centro_Recurso     varchar(100)    NOT NULL,
    str_Nome               varchar(100)    NULL,
    str_CPF                varchar(50)     NOT NULL,
    str_Tempo_Medio        varchar(50)     NOT NULL,
    str_Devolucao          varchar(50)     NOT NULL,
    int_Periodo            int             NOT NULL,
    int_Periodo_Grupo      int             NULL,
    int_Ativo              int             NOT NULL,
    dt_Atualizacao         date            NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_metas_assinaturas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_metas_assinaturas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_metas_assinaturas >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_metas_montagem 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_metas_montagem(
    id_Meta_Montagem        int             IDENTITY(1,1),
    id_Praca                int             NOT NULL,
    str_Regional            varchar(100)    NOT NULL,
    id_Empresa              int             NOT NULL,
    str_Local               varchar(100)    NOT NULL,
    str_Centro_Recurso      varchar(100)    NOT NULL,
    str_CPF                 varchar(100)    NOT NULL,
    qtd_Pastas_Assinadas    nchar(10)       NOT NULL,
    int_Periodo             int             NOT NULL,
    int_Periodo_Grupo       int             NULL,
    int_Ativo               int             NOT NULL,
    dt_Atualizacao          date            NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_metas_montagem') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_metas_montagem >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_metas_montagem >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_metas_registro 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_metas_registro(
    id_Metas_Registro       int             IDENTITY(1,1),
    id_Praca                int             NOT NULL,
    str_Regional            varchar(100)    NOT NULL,
    id_Empresa              int             NOT NULL,
    str_local               varchar(100)    NOT NULL,
    str_Centro_Recurso      varchar(100)    NOT NULL,
    str_CPF_Coordenador     varchar(50)     NOT NULL,
    str_Tempo_Registro      varchar(100)    NOT NULL,
    str_Meta_Curto_Prazo    varchar(50)     NOT NULL,
    int_Periodo             int             NOT NULL,
    int_Periodo_Grupo       int             NULL,
    int_Ativo               int             NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_metas_registro') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_metas_registro >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_metas_registro >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_periodo 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_periodo(
    id            int             IDENTITY(1,1),
    id_Periodo    int             NOT NULL,
    str_Mes       varchar(100)    NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_periodo') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_periodo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_periodo >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_pontos 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_pontos(
    id_Pontos           int             IDENTITY(1,1),
    str_Tipo            varchar(255)    NULL,
    str_Faixa_Bronze    varchar(50)     NULL,
    str_Faixa_Prata     varchar(50)     NULL,
    str_Faixa_Ouro      varchar(50)     NULL,
    int_Periodo         int             NULL,
    int_Ativo           int             NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_pontos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_pontos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_pontos >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_pontos_extras 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_pontos_extras(
    id_Pontos         int             IDENTITY(1,1),
    str_CPF           varchar(50)     NULL,
    int_Pontos        int             NULL,
    str_Observacao    varchar(255)    NULL,
    int_Ativo         int             NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_pontos_extras') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_pontos_extras >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_pontos_extras >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_ranking 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_ranking(
    id_Ranking     int            IDENTITY(1,1),
    str_CPF        varchar(50)    NULL,
    id_Perfil      int            NULL,
    id_Praca       int            NULL,
    str_Ranking    varchar(50)    NULL,
    str_Mes        varchar(50)    NULL,
    int_Periodo    int            NULL,
    int_Ativo      int            NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_ranking') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_ranking >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_ranking >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_regional 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_regional(
    id_Metas_Regiao      int             IDENTITY(1,1),
    id_Praca             int             NOT NULL,
    str_Regional         varchar(100)    NOT NULL,
    str_Local            varchar(100)    NOT NULL,
    str_CPF              varchar(50)     NOT NULL,
    str_Mes              varchar(50)     NOT NULL,
    str_Meta             varchar(100)    NOT NULL,
    str_Meta_Atingida    varchar(100)    NOT NULL,
    str_Porcentagem      varchar(50)     NOT NULL,
    int_Periodo          int             NOT NULL,
    int_Periodo_Grupo    int             NULL,
    int_Ativo            int             NOT NULL,
    dt_Atualizacao       char(10)        NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_regional') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_regional >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_regional >>>'
go

/* 
 * TABLE: pi_adm_metas_tudook_pdg_vinculo_cpf 
 */

CREATE TABLE pi_adm_metas_tudook_pdg_vinculo_cpf(
    id_Vinculo              int            IDENTITY(1,1),
    str_CPF_Participante    varchar(50)    NOT NULL,
    str_CPF_Coordenador     varchar(50)    NOT NULL,
    int_Periodo             int            NULL
)
go



IF OBJECT_ID('pi_adm_metas_tudook_pdg_vinculo_cpf') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metas_tudook_pdg_vinculo_cpf >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metas_tudook_pdg_vinculo_cpf >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa 
 */

CREATE TABLE pi_adm_metasfemsa(
    id_Meta       int              IDENTITY(1,1),
    id_Praca      int              NOT NULL,
    id_Empresa    int              NOT NULL,
    dt_Inicial    date             NOT NULL,
    dt_Final      date             NOT NULL,
    str_Texto     varchar(4000)    NULL,
    int_Status    int              NOT NULL
)
go



IF OBJECT_ID('pi_adm_metasfemsa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa_acompanhamento 
 */

CREATE TABLE pi_adm_metasfemsa_acompanhamento(
    id_Acompanhamento                int              IDENTITY(1,1),
    str_Matricula                    varchar(50)      NOT NULL,
    str_Meta                         varchar(4000)    NOT NULL,
    str_Atual                        varchar(4000)    NOT NULL,
    str_Porcentagem                  varchar(50)      NOT NULL,
    int_Bateu                        int              NOT NULL,
    int_Copa                         int              NOT NULL,
    str_Periodo                      varchar(50)      NOT NULL,
    id_Meta                          int              NOT NULL,
    id_Foco                          int              NOT NULL,
    id_Perfil                        int              NOT NULL,
    qtd_Pontos                       int              NOT NULL,
    int_Pontos_Ativos                int              NOT NULL,
    int_Pontos_Moderacao             int              NOT NULL,
    dt_Atualizacao                   date             NOT NULL,
    int_Tipo                         int              NULL,
    str_Meta_Diaria                  varchar(255)     NULL,
    dt_Meta_Diaria                   date             NULL,
    str_Justificativa_Meta_Diaria    varchar(255)     NULL,
    str_Matricula_Gerente            varchar(50)      NULL
)
go



IF OBJECT_ID('pi_adm_metasfemsa_acompanhamento') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa_acompanhamento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa_acompanhamento >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa_foco 
 */

CREATE TABLE pi_adm_metasfemsa_foco(
    id_Foco         int              IDENTITY(1,1),
    str_Nome        varchar(4000)    NOT NULL,
    str_Mecanica    varchar(4000)    NOT NULL,
    int_Copa        int              NULL,
    id_Meta         int              NOT NULL,
    int_Reais       int              CONSTRAINT [DF_pi_adm_metasfemsa_foco_int_Reais] DEFAULT ((0)) NOT NULL,
    int_Espera      int              CONSTRAINT [DF_pi_adm_metasfemsa_foco_int_Espera] DEFAULT ((1)) NOT NULL
)
go



IF OBJECT_ID('pi_adm_metasfemsa_foco') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa_foco >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa_foco >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa_foco_premiacao 
 */

CREATE TABLE pi_adm_metasfemsa_foco_premiacao(
    id_Premiacao    int              IDENTITY(1,1),
    id_Nivel        int              NOT NULL,
    str_Valor       varchar(4000)    NOT NULL,
    id_Foco         int              NULL,
    int_Reais       int              CONSTRAINT [DF_pi_adm_metasfemsa_foco_premiacao_int_Reais] DEFAULT ((0)) NULL
)
go



IF OBJECT_ID('pi_adm_metasfemsa_foco_premiacao') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa_foco_premiacao >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa_foco_premiacao >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa_metadiaria_gerente 
 */

CREATE TABLE pi_adm_metasfemsa_metadiaria_gerente(
    id                            int             IDENTITY(1,1),
    str_Matricula_Participante    varchar(255)    NOT NULL,
    str_Matricula_Gerente         varchar(255)    NULL,
    dt_Inicial                    char(10)        NOT NULL,
    dt_Final                      char(10)        NOT NULL,
    str_Periodo                   varchar(100)    NULL,
    int_Executivo                 bit             NULL,
    int_Ativo                     int             NOT NULL
)
go



IF OBJECT_ID('pi_adm_metasfemsa_metadiaria_gerente') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa_metadiaria_gerente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa_metadiaria_gerente >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa_tipo 
 */

CREATE TABLE pi_adm_metasfemsa_tipo(
    tipoMetaId    int           NOT NULL,
    nome          nchar(150)    NOT NULL,
    CONSTRAINT PK__pi_adm_m__FEC6EDF4C0134C24 PRIMARY KEY NONCLUSTERED (tipoMetaId)
)
go



IF OBJECT_ID('pi_adm_metasfemsa_tipo') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa_tipo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa_tipo >>>'
go

/* 
 * TABLE: pi_adm_metasfemsa_upload 
 */

CREATE TABLE pi_adm_metasfemsa_upload(
    id_Acompanhamento    int              IDENTITY(1,1),
    str_Matricula        varchar(50)      NOT NULL,
    str_Meta             varchar(4000)    NOT NULL,
    str_Atual            varchar(4000)    NOT NULL,
    str_Porcentagem      varchar(50)      NOT NULL,
    int_Bateu            int              NOT NULL,
    qtd_Pontos           int              NOT NULL,
    int_Copa             int              NOT NULL,
    str_Periodo          varchar(50)      NOT NULL,
    pontos_rs            int              NOT NULL,
    str_Foco             varchar(4000)    NOT NULL,
    str_Praca            varchar(50)      NOT NULL,
    str_Empresa          varchar(50)      NULL,
    id_Meta              int              NULL,
    id_Foco              int              NULL,
    id_Perfil            int              NULL,
    int_Subido           int              NULL,
    dt_Upload            char(10)         NOT NULL
)
go



IF OBJECT_ID('pi_adm_metasfemsa_upload') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_metasfemsa_upload >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_metasfemsa_upload >>>'
go

/* 
 * TABLE: pi_adm_noticia_empresa 
 */

CREATE TABLE pi_adm_noticia_empresa(
    id_Noticia    int    NOT NULL,
    id_Empresa    int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_noticia_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_noticia_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_noticia_empresa >>>'
go

/* 
 * TABLE: pi_adm_nova_rateios 
 */

CREATE TABLE pi_adm_nova_rateios(
    id_nova                 int               IDENTITY(1,1),
    agencia                 varchar(50)       NULL,
    campanha                varchar(20)       NULL,
    cnpj                    numeric(14, 0)    NULL,
    cnpj_filial_emissora    numeric(14, 0)    NULL,
    nome                    varchar(250)      NULL,
    endereco                varchar(250)      NULL,
    referencia              varchar(50)       NULL,
    titc_id_nota            numeric(18, 0)    NULL,
    nfca_id_nota            numeric(18, 0)    NULL,
    titc_serie              numeric(18, 0)    NULL,
    nfca_dt_emissao         date              NULL,
    pedc_id_pedido          numeric(18, 0)    NULL,
    pedc_ped_cliente        numeric(18, 0)    NULL,
    pedc_id_cliente_ent     numeric(18, 0)    NULL,
    pedc_dt_emissao         date              NULL,
    clie_nome               varchar(150)      NULL,
    nfde_id_item            numeric(18, 0)    NULL,
    nfde_nome               varchar(250)      NULL,
    qt_ped                  nchar(10)         NULL,
    pr_final_unit           numeric(18, 2)    NULL,
    vl_mercadoria           numeric(18, 2)    NULL,
    vl_desc_inc_total       numeric(18, 2)    NULL,
    vl_total_frete          numeric(18, 2)    NULL,
    vl_total_item           numeric(18, 2)    NULL,
    nfcc_chave_acesso       varchar(150)      NULL,
    pedc_utm_medium         nchar(10)         NULL,
    campaign                varchar(50)       NULL,
    pedido_parceiro         numeric(18, 0)    NULL,
    base_icms               numeric(18, 2)    NULL,
    vl_icms                 numeric(18, 2)    NULL,
    valor_base_rat_ant      numeric(18, 2)    NULL,
    valor_icms_rat_ant      numeric(18, 2)    NULL,
    valor_base_rat          numeric(18, 2)    NULL,
    valor_icms_rat          numeric(18, 2)    NULL,
    desconto                numeric(18, 2)    NULL,
    vlr_boleto              numeric(18, 2)    NULL
)
go



IF OBJECT_ID('pi_adm_nova_rateios') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_nova_rateios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_nova_rateios >>>'
go

/* 
 * TABLE: pi_adm_parceiro 
 */

CREATE TABLE pi_adm_parceiro(
    parceiroId          int           IDENTITY(1,1),
    nomeParceiro        nchar(150)    NOT NULL,
    ativoParaResgate    bit           NOT NULL,
    CONSTRAINT PK_pi_adm_parceiro PRIMARY KEY NONCLUSTERED (parceiroId)
)
go



IF OBJECT_ID('pi_adm_parceiro') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_parceiro >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_parceiro >>>'
go

/* 
 * TABLE: pi_adm_pdg_planilha 
 */

CREATE TABLE pi_adm_pdg_planilha(
    id                          int             IDENTITY(1,1),
    dt_insercao                 char(10)        NULL,
    regional                    varchar(50)     NULL,
    imobiliaria                 varchar(50)     NULL,
    nome_empreendimento         varchar(150)    NULL,
    bloco                       varchar(150)    NULL,
    unidade                     varchar(50)     NULL,
    data_venda                  varchar(10)     NULL,
    mes                         char(2)         NULL,
    vgv_total                   varchar(50)     NULL,
    pontos_extra_vgv            varchar(50)     NULL,
    peso_na_venda               varchar(50)     NULL,
    fifty                       varchar(10)     NULL,
    cpf_corretor                varchar(20)     NULL,
    pontos_corretor             varchar(50)     NULL,
    pontos_extra_corretor       varchar(50)     NULL,
    cpf_gerente                 varchar(20)     NULL,
    pontos_gerente              varchar(50)     NULL,
    pontos_extra_gerente        varchar(50)     NULL,
    cpf_coordenador             varchar(20)     NULL,
    pontos_coordenador          varchar(50)     NULL,
    pontos_extra_coordenador    varchar(50)     NULL
)
go



IF OBJECT_ID('pi_adm_pdg_planilha') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pdg_planilha >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pdg_planilha >>>'
go

/* 
 * TABLE: pi_adm_perfil 
 */

CREATE TABLE pi_adm_perfil(
    id_Perfil        int             IDENTITY(1,1),
    str_Descricao    nvarchar(80)    NULL,
    poderes          char(10)        NULL,
    CONSTRAINT PK_pi_adm_perfil PRIMARY KEY NONCLUSTERED (id_Perfil)
)
go



IF OBJECT_ID('pi_adm_perfil') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_perfil >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_perfil >>>'
go

/* 
 * TABLE: pi_adm_perfilsc_teste 
 */

CREATE TABLE pi_adm_perfilsc_teste(
    id_Perfil        int            IDENTITY(1,1),
    str_Descricao    varchar(80)    NULL,
    CONSTRAINT PK_pi_adm_perfilsc_teste PRIMARY KEY NONCLUSTERED (id_Perfil)
)
go



IF OBJECT_ID('pi_adm_perfilsc_teste') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_perfilsc_teste >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_perfilsc_teste >>>'
go

/* 
 * TABLE: pi_adm_perguntas 
 */

CREATE TABLE pi_adm_perguntas(
    id_Pergunta     int     IDENTITY(1,1),
    id_Pesquisa     int     NOT NULL,
    str_Pergunta    text    NULL,
    str_Opcao       text    NULL,
    str_Opcao2      text    NULL,
    str_Opcao3      text    NULL,
    str_Opcao4      text    NULL,
    str_Opcao5      text    NULL,
    str_Opcao6      text    NULL
)
go



IF OBJECT_ID('pi_adm_perguntas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_perguntas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_perguntas >>>'
go

/* 
 * TABLE: pi_adm_permissoes 
 */

CREATE TABLE pi_adm_permissoes(
    id_Permissao     int    IDENTITY(1,1),
    id_Admin         int    NOT NULL,
    id_Item          int    NOT NULL,
    int_Inclusao     int    NOT NULL,
    int_Alteracao    int    NOT NULL,
    int_Exclusao     int    NOT NULL,
    int_Pesquisa     int    NOT NULL,
    CONSTRAINT PK_pi_adm_permissoes PRIMARY KEY NONCLUSTERED (id_Permissao)
)
go



IF OBJECT_ID('pi_adm_permissoes') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_permissoes >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_permissoes >>>'
go

/* 
 * TABLE: pi_adm_pesquisa_geral 
 */

CREATE TABLE pi_adm_pesquisa_geral(
    id             int             IDENTITY(1,1),
    id_Programa    int             NOT NULL,
    id_Fase        int             NOT NULL,
    pergunta       varchar(255)    NOT NULL,
    resposta       varchar(255)    NOT NULL,
    str_Email      nvarchar(50)    NOT NULL,
    parametro      varchar(150)    NULL,
    str_Nome       varchar(200)    NULL,
    dt_Resposta    char(10)        NULL
)
go



IF OBJECT_ID('pi_adm_pesquisa_geral') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pesquisa_geral >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pesquisa_geral >>>'
go

/* 
 * TABLE: pi_adm_pesquisa_premios 
 */

CREATE TABLE pi_adm_pesquisa_premios(
    id_pergunta     int           IDENTITY(1,1),
    tp_pergunta     nchar(1)      NULL,
    str_pergunta    nchar(255)    NULL,
    fl_ativo        int           NULL,
    CONSTRAINT PK_pi_adm_pesquisa_premios PRIMARY KEY NONCLUSTERED (id_pergunta)
)
go



IF OBJECT_ID('pi_adm_pesquisa_premios') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pesquisa_premios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pesquisa_premios >>>'
go

/* 
 * TABLE: pi_adm_pesquisa_premios_respostas 
 */

CREATE TABLE pi_adm_pesquisa_premios_respostas(
    id_resposta     int             IDENTITY(1,1),
    id_pergunta     int             NULL,
    id_usuario      int             NULL,
    id_resgate      int             NULL,
    str_resposta    varchar(255)    NULL,
    dt_resposta     char(10)        NULL,
    CONSTRAINT PK_pi_adm_pesquisa_premios_respostas PRIMARY KEY NONCLUSTERED (id_resposta)
)
go



IF OBJECT_ID('pi_adm_pesquisa_premios_respostas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pesquisa_premios_respostas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pesquisa_premios_respostas >>>'
go

/* 
 * TABLE: pi_adm_pesquisas 
 */

CREATE TABLE pi_adm_pesquisas(
    id_Pesquisa     int            IDENTITY(1,1),
    id_Programa     int            NOT NULL,
    id_Fase         int            NOT NULL,
    id_Empresa      int            NULL,
    str_Pesquisa    varchar(50)    NULL,
    CONSTRAINT PK_pi_adm_pesquisas PRIMARY KEY NONCLUSTERED (id_Pesquisa)
)
go



IF OBJECT_ID('pi_adm_pesquisas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pesquisas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pesquisas >>>'
go

/* 
 * TABLE: pi_adm_pontos 
 */

CREATE TABLE pi_adm_pontos(
    id_Pontos        int            IDENTITY(1,1),
    str_Pontos       int            NULL,
    int_Faixa        int            NULL,
    int_Participa    int            NULL,
    str_Img          varchar(50)    NULL,
    str_Img_ov       varchar(50)    NULL,
    str_Descr        nchar(50)      NULL,
    int_tp_faixa     int            NULL,
    CONSTRAINT PK_pi_adm_pontos PRIMARY KEY NONCLUSTERED (id_Pontos)
)
go



IF OBJECT_ID('pi_adm_pontos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pontos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pontos >>>'
go

/* 
 * TABLE: pi_adm_pontos_extras 
 */

CREATE TABLE pi_adm_pontos_extras(
    id_Pontos             int             IDENTITY(1,1),
    id_Fase               int             NOT NULL,
    str_Identificacao     varchar(100)    NOT NULL,
    tipo_Identificacao    varchar(100)    NULL,
    int_Pontos            int             NOT NULL,
    str_Observacao        varchar(255)    NULL,
    int_Ativo             bit             NULL,
    dt_inicio             date            CONSTRAINT [DF_pi_adm_pontos_extras_dt_inicio] DEFAULT (getdate()) NULL,
    dt_fim                date            NULL
)
go



IF OBJECT_ID('pi_adm_pontos_extras') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pontos_extras >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pontos_extras >>>'
go

/* 
 * TABLE: pi_adm_pracas_programa_old 
 */

CREATE TABLE pi_adm_pracas_programa_old(
    id             int    IDENTITY(1,1),
    id_Praca       int    NOT NULL,
    id_Programa    int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_pracas_programa_old') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_pracas_programa_old >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_pracas_programa_old >>>'
go

/* 
 * TABLE: pi_adm_premios_decoding 
 */

CREATE TABLE pi_adm_premios_decoding(
    id_Premio              int              IDENTITY(1,1),
    id_Programa            int              NOT NULL,
    id_Fase                int              NOT NULL,
    str_Tipo               char(1)          NOT NULL,
    int_Participante       int              NOT NULL,
    int_Faixa              int              NOT NULL,
    str_Titulo             varchar(255)     NULL,
    str_Resumo             text             NULL,
    str_Texto              text             NULL,
    val_ValorOriginal      numeric(8, 2)    NULL,
    val_Valor              numeric(8, 2)    NULL,
    val_Valor_NF           numeric(8, 2)    NULL,
    val_Valor_Padrinho     numeric(8, 2)    NULL,
    int_Quantidade         int              NOT NULL,
    str_Imagem             nvarchar(60)     NOT NULL,
    int_Album              int              NOT NULL,
    str_Flash              nvarchar(60)     NULL,
    str_Video              nvarchar(60)     NULL,
    dt_Cadastro            date             NOT NULL,
    int_Disponivel         int              NOT NULL,
    int_Ativo              int              NOT NULL,
    str_Obs                text             NULL,
    int_estrela            int              NULL,
    id_ProdutoCategoria    int              NULL,
    int_Campanha           int              NULL,
    int_Subsidio           int              NULL,
    int_DreamMoney         int              NULL,
    Decoded                bit              NULL
)
go



IF OBJECT_ID('pi_adm_premios_decoding') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_decoding >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_decoding >>>'
go

/* 
 * TABLE: pi_adm_premios_empresa 
 */

CREATE TABLE pi_adm_premios_empresa(
    id_Premio     int          NOT NULL,
    id_Empresa    int          NOT NULL,
    alt           nchar(10)    NULL
)
go



IF OBJECT_ID('pi_adm_premios_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_empresa >>>'
go

/* 
 * TABLE: pi_adm_premios_empresa_ 
 */

CREATE TABLE pi_adm_premios_empresa_(
    id_Premio     int    NOT NULL,
    id_Empresa    int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_premios_empresa_') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_empresa_ >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_empresa_ >>>'
go

/* 
 * TABLE: pi_adm_premios_faixa 
 */

CREATE TABLE pi_adm_premios_faixa(
    id            int            IDENTITY(1,1),
    faixa         varchar(10)    NULL,
    descricao     varchar(50)    NULL,
    int_Exibir    int            NULL
)
go



IF OBJECT_ID('pi_adm_premios_faixa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_faixa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_faixa >>>'
go

/* 
 * TABLE: pi_adm_premios_lista_de_desejos 
 */

CREATE TABLE pi_adm_premios_lista_de_desejos(
    id                int          IDENTITY(1,1),
    idProfissional    nchar(10)    NULL,
    idPremio          nchar(10)    NULL,
    dataInclusao      char(10)     NULL,
    dataAlteracao     char(10)     NULL,
    ativo             nchar(1)     CONSTRAINT [DF_pi_adm_premios_lista_de_desejos_ativo] DEFAULT ((1)) NULL
)
go



IF OBJECT_ID('pi_adm_premios_lista_de_desejos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_lista_de_desejos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_lista_de_desejos >>>'
go

/* 
 * TABLE: pi_adm_premios_participante 
 */

CREATE TABLE pi_adm_premios_participante(
    id              int            IDENTITY(1,1),
    participante    int            NULL,
    descricao       varchar(50)    NULL
)
go



IF OBJECT_ID('pi_adm_premios_participante') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_participante >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_participante >>>'
go

/* 
 * TABLE: pi_adm_premios_tipo 
 */

CREATE TABLE pi_adm_premios_tipo(
    id           int            IDENTITY(1,1),
    tipo         varchar(3)     NULL,
    descricao    varchar(30)    NULL
)
go



IF OBJECT_ID('pi_adm_premios_tipo') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_premios_tipo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_premios_tipo >>>'
go

/* 
 * TABLE: pi_adm_produtos_fastshop_atuais 
 */

CREATE TABLE pi_adm_produtos_fastshop_atuais(
    id_Produto    nvarchar(100)    NULL,
    OK            bit              CONSTRAINT [DF__pi_adm_produ__OK__4E498009] DEFAULT ((0)) NULL
)
go



IF OBJECT_ID('pi_adm_produtos_fastshop_atuais') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_produtos_fastshop_atuais >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_produtos_fastshop_atuais >>>'
go

/* 
 * TABLE: pi_adm_produtos_fastshop_sku 
 */

CREATE TABLE pi_adm_produtos_fastshop_sku(
    id           int              IDENTITY(1,1),
    ProdutoId    nvarchar(20)     NULL,
    Sku          nvarchar(50)     NULL,
    Nome         nvarchar(250)    NULL,
    Descricao    text             NULL
)
go



IF OBJECT_ID('pi_adm_produtos_fastshop_sku') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_produtos_fastshop_sku >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_produtos_fastshop_sku >>>'
go

/* 
 * TABLE: pi_adm_programa_empresa 
 */

CREATE TABLE pi_adm_programa_empresa(
    id_Programa    int    NOT NULL,
    id_Empresa     int    NOT NULL,
    CONSTRAINT PK_pi_adm_programa_empresa PRIMARY KEY NONCLUSTERED (id_Programa, id_Empresa)
)
go



IF OBJECT_ID('pi_adm_programa_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_programa_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_programa_empresa >>>'
go

/* 
 * TABLE: pi_adm_promocao 
 */

CREATE TABLE pi_adm_promocao(
    id_Profissional    int             NULL,
    id_Padrinho        int             NULL,
    chave              varchar(255)    NOT NULL,
    id_Premio          int             NOT NULL,
    data               date            NULL
)
go



IF OBJECT_ID('pi_adm_promocao') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_promocao >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_promocao >>>'
go

/* 
 * TABLE: pi_adm_ranking 
 */

CREATE TABLE pi_adm_ranking(
    id_Ranking        int     NOT NULL,
    id_Programa       int     NOT NULL,
    id_Fase           int     NOT NULL,
    id_Empresa        int     NOT NULL,
    id_Perfil         int     NOT NULL,
    dt_Atualizacao    date    NOT NULL,
    int_Ativo         int     NOT NULL,
    CONSTRAINT PK_pi_adm_ranking PRIMARY KEY NONCLUSTERED (id_Ranking, id_Programa, id_Fase, id_Empresa, id_Perfil)
)
go



IF OBJECT_ID('pi_adm_ranking') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking >>>'
go

/* 
 * TABLE: pi_adm_ranking_participa 
 */

CREATE TABLE pi_adm_ranking_participa(
    id_RankingPerfil    int    IDENTITY(1,1),
    id_Programa         int    NOT NULL,
    id_Fase             int    NOT NULL,
    id_Praca            int    NOT NULL,
    id_Empresa          int    NOT NULL,
    id_Perfil           int    NOT NULL,
    int_Participa       int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_ranking_participa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_participa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_participa >>>'
go

/* 
 * TABLE: pi_adm_ranking_pontos_extras 
 */

CREATE TABLE pi_adm_ranking_pontos_extras(
    id_Pontos_Extras           int    IDENTITY(1,1),
    id_Fase                    int    NOT NULL,
    id_Perfil                  int    NOT NULL,
    id_Pontos                  int    NOT NULL,
    int_Pontos_Participante    int    NULL,
    int_Pontos_Padrinho        int    NULL,
    int_Ativo                  bit    NULL
)
go



IF OBJECT_ID('pi_adm_ranking_pontos_extras') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_pontos_extras >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_pontos_extras >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg 
 */

CREATE TABLE pi_adm_ranking_toppdg(
    id_Ranking                           int               IDENTITY(1,1),
    id_Fase                              int               NULL,
    id_Perfil                            int               NULL,
    id_Praca                             int               NOT NULL,
    id_Empresa                           int               NOT NULL,
    id_Empreendimento                    int               NOT NULL,
    str_Bloco                            varchar(100)      NULL,
    str_Unidade                          varchar(20)       NOT NULL,
    dt_Venda                             date              NOT NULL,
    str_Mes                              varchar(50)       NULL,
    val_VGV                              numeric(12, 2)    NULL,
    int_Pontos_Extras_VGV                int               NULL,
    str_Peso                             varchar(10)       NULL,
    int_Fifty                            varchar(10)       NULL,
    str_CPF_Corretor                     varchar(14)       NULL,
    int_Pontos_Corretor                  int               NULL,
    int_Pontos_Extras_Corretor           int               NULL,
    str_CPF_Gerente                      varchar(14)       NULL,
    int_Pontos_Gerente                   int               NULL,
    int_Pontos_Extras_Gerente            int               NULL,
    str_CPF_Coordenador                  varchar(14)       NULL,
    int_Pontos_Coordenador               int               NULL,
    int_Pontos_Extras_Coordenador        int               NULL,
    str_CPF_Superintendente              varchar(14)       NULL,
    int_Pontos_Superintendente           int               NULL,
    int_Pontos_Extras_Superintendente    int               NULL,
    str_CPF_Diretor                      varchar(14)       NULL,
    int_Pontos_Diretor                   int               NULL,
    int_Pontos_Extras_Diretor            int               NULL,
    str_Distrato                         varchar(50)       NULL,
    dt_Insercao                          char(10)          NULL,
    dt_Alteracao                         char(10)          NULL,
    id_Usuario                           int               NULL,
    periodo                              int               NULL,
    id_Planilha                          int               NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_codigo_sistema 
 */

CREATE TABLE pi_adm_ranking_toppdg_codigo_sistema(
    id_Toppdg                         int             IDENTITY(1,1),
    str_Regional                      varchar(255)    NULL,
    str_Cod_Pdg                       varchar(255)    NOT NULL,
    str_Empreendimento_Sistema_Pdg    varchar(255)    NOT NULL,
    int_Participa_Campanha            int             NULL,
    str_Nome_Inicial                  varchar(255)    NULL,
    id_Empreendimento                 int             NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_codigo_sistema') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_codigo_sistema >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_codigo_sistema >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_periodo 
 */

CREATE TABLE pi_adm_ranking_toppdg_periodo(
    id_periodo     int     IDENTITY(1,1),
    data_inicio    date    NULL,
    data_fim       date    NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_periodo') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_periodo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_periodo >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_teste 
 */

CREATE TABLE pi_adm_ranking_toppdg_teste(
    id_Ranking                           int               IDENTITY(1,1),
    id_Fase                              int               NULL,
    id_Perfil                            int               NULL,
    id_Praca                             int               NOT NULL,
    id_Empresa                           int               NOT NULL,
    id_Empreendimento                    int               NOT NULL,
    str_Bloco                            varchar(100)      NULL,
    str_Unidade                          varchar(20)       NOT NULL,
    dt_Venda                             date              NOT NULL,
    str_Mes                              varchar(50)       NULL,
    val_VGV                              numeric(12, 2)    NULL,
    int_Pontos_Extras_VGV                int               NULL,
    str_Peso                             varchar(10)       NULL,
    int_Fifty                            varchar(10)       NULL,
    str_CPF_Corretor                     varchar(14)       NULL,
    int_Pontos_Corretor                  int               NULL,
    int_Pontos_Extras_Corretor           int               NULL,
    str_CPF_Gerente                      varchar(14)       NULL,
    int_Pontos_Gerente                   int               NULL,
    int_Pontos_Extras_Gerente            int               NULL,
    str_CPF_Coordenador                  varchar(14)       NULL,
    int_Pontos_Coordenador               int               NULL,
    int_Pontos_Extras_Coordenador        int               NULL,
    str_CPF_Superintendente              varchar(14)       NULL,
    int_Pontos_Superintendente           int               NULL,
    int_Pontos_Extras_Superintendente    int               NULL,
    str_CPF_Diretor                      varchar(14)       NULL,
    int_Pontos_Diretor                   int               NULL,
    int_Pontos_Extras_Diretor            int               NULL,
    str_Distrato                         varchar(50)       NULL,
    dt_Insercao                          char(10)          NULL,
    dt_Alteracao                         char(10)          NULL,
    id_Usuario                           int               NULL,
    periodo                              int               NULL,
    id_Planilha                          int               NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_teste') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_teste >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_teste >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_upload 
 */

CREATE TABLE pi_adm_ranking_toppdg_upload(
    id                               int             IDENTITY(1,1),
    str_Motivo                       text            NULL,
    id_Planilha                      int             NULL,
    str_Regional                     varchar(150)    NULL,
    str_Imobiliaria                  text            NULL,
    str_Codigo_Do_Empreendimento     varchar(50)     NULL,
    str_Nome_Do_Empreendimento       varchar(255)    NULL,
    str_Bloco                        varchar(255)    NULL,
    str_Unidade                      varchar(50)     NULL,
    str_Data_Da_Venda                varchar(50)     NULL,
    str_Mes                          varchar(50)     NULL,
    str_VGV_Total                    varchar(50)     NULL,
    str_Pontos_Extra_Em_VGV          varchar(50)     NULL,
    str_Peso_Na_Venda                varchar(50)     NULL,
    str_Fifty                        varchar(50)     NULL,
    str_CPF_Do_Corretor              varchar(50)     NULL,
    str_Pts_Corretor                 varchar(50)     NULL,
    str_Pts_Extra_Corretor           varchar(50)     NULL,
    str_CPF_Do_Gerente               varchar(50)     NULL,
    str_Pts_Gerente                  varchar(50)     NULL,
    str_Pts_Extra_Gerente            varchar(50)     NULL,
    str_CPF_Do_Coordenador           varchar(50)     NULL,
    str_Pts_Coordenador              varchar(50)     NULL,
    str_Pts_Extra_Coordenador        varchar(50)     NULL,
    str_CPF_Do_Superintendente       varchar(50)     NULL,
    str_Pts_Superintendente          varchar(50)     NULL,
    str_Pts_Extra_Superintendente    varchar(50)     NULL,
    str_CPF_Do_Diretor               varchar(50)     NULL,
    str_Pts_Diretor                  varchar(50)     NULL,
    str_Pts_Extra_Diretor            varchar(50)     NULL,
    str_Distrato                     varchar(50)     NULL,
    periodo                          int             NULL,
    id_Admin                         int             NULL,
    dt_Upload                        char(10)        NULL,
    int_Subido                       int             NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_upload') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_upload >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_upload >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_upload_planilha 
 */

CREATE TABLE pi_adm_ranking_toppdg_upload_planilha(
    id_Planilha    int              IDENTITY(1,1),
    str_Nome       nvarchar(250)    NOT NULL,
    dt_Insercao    char(10)         NOT NULL,
    id_Admin       int              NOT NULL,
    int_Subido     int              NOT NULL,
    id_Fase        int              NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_upload_planilha') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_upload_planilha >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_upload_planilha >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_upload_planilha_teste 
 */

CREATE TABLE pi_adm_ranking_toppdg_upload_planilha_teste(
    id_Planilha    int              IDENTITY(1,1),
    str_Nome       nvarchar(250)    NOT NULL,
    dt_Insercao    char(10)         NOT NULL,
    id_Admin       int              NOT NULL,
    int_Subido     int              NOT NULL,
    id_Fase        int              NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_upload_planilha_teste') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_upload_planilha_teste >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_upload_planilha_teste >>>'
go

/* 
 * TABLE: pi_adm_ranking_toppdg_upload_teste 
 */

CREATE TABLE pi_adm_ranking_toppdg_upload_teste(
    id                               int             IDENTITY(1,1),
    str_Motivo                       text            NULL,
    id_Planilha                      int             NULL,
    str_Regional                     varchar(150)    NULL,
    str_Imobiliaria                  text            NULL,
    str_Codigo_Do_Empreendimento     varchar(50)     NULL,
    str_Nome_Do_Empreendimento       varchar(255)    NULL,
    str_Bloco                        varchar(255)    NULL,
    str_Unidade                      varchar(50)     NULL,
    str_Data_Da_Venda                varchar(50)     NULL,
    str_Mes                          varchar(50)     NULL,
    str_VGV_Total                    varchar(50)     NULL,
    str_Pontos_Extra_Em_VGV          varchar(50)     NULL,
    str_Peso_Na_Venda                varchar(50)     NULL,
    str_Fifty                        varchar(50)     NULL,
    str_CPF_Do_Corretor              varchar(50)     NULL,
    str_Pts_Corretor                 varchar(50)     NULL,
    str_Pts_Extra_Corretor           varchar(50)     NULL,
    str_CPF_Do_Gerente               varchar(50)     NULL,
    str_Pts_Gerente                  varchar(50)     NULL,
    str_Pts_Extra_Gerente            varchar(50)     NULL,
    str_CPF_Do_Coordenador           varchar(50)     NULL,
    str_Pts_Coordenador              varchar(50)     NULL,
    str_Pts_Extra_Coordenador        varchar(50)     NULL,
    str_CPF_Do_Superintendente       varchar(50)     NULL,
    str_Pts_Superintendente          varchar(50)     NULL,
    str_Pts_Extra_Superintendente    varchar(50)     NULL,
    str_CPF_Do_Diretor               varchar(50)     NULL,
    str_Pts_Diretor                  varchar(50)     NULL,
    str_Pts_Extra_Diretor            varchar(50)     NULL,
    str_Distrato                     varchar(50)     NULL,
    periodo                          int             NULL,
    id_Admin                         int             NULL,
    dt_Upload                        char(10)        NULL,
    int_Subido                       int             NULL
)
go



IF OBJECT_ID('pi_adm_ranking_toppdg_upload_teste') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_ranking_toppdg_upload_teste >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_ranking_toppdg_upload_teste >>>'
go

/* 
 * TABLE: pi_adm_regulamento 
 */

CREATE TABLE pi_adm_regulamento(
    id_Regulamento    int              IDENTITY(1,1),
    id_Programa       int              NOT NULL,
    id_Fase           int              NOT NULL,
    str_Titulo        nvarchar(250)    NOT NULL,
    str_Conteudo      text             NOT NULL,
    str_Arquivo       varchar(255)     NULL,
    int_Ordem         int              NOT NULL,
    int_Ativo         int              NOT NULL,
    CONSTRAINT PK_pi_adm_regulamento PRIMARY KEY NONCLUSTERED (id_Regulamento)
)
go



IF OBJECT_ID('pi_adm_regulamento') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_regulamento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_regulamento >>>'
go

/* 
 * TABLE: pi_adm_regulamento_empresa 
 */

CREATE TABLE pi_adm_regulamento_empresa(
    id_Regulamento    int    NOT NULL,
    id_Empresa        int    NOT NULL
)
go



IF OBJECT_ID('pi_adm_regulamento_empresa') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_regulamento_empresa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_regulamento_empresa >>>'
go

/* 
 * TABLE: pi_adm_resgate 
 */

CREATE TABLE pi_adm_resgate(
    id_Resgate            int               IDENTITY(1,1),
    id_Programa           int               NOT NULL,
    id_Fase               int               NOT NULL,
    id_Usuario            int               NOT NULL,
    int_Faixa             int               NOT NULL,
    id_Premio             int               NULL,
    id_Gift               int               NULL,
    num_Protocolo         varchar(20)       NULL,
    num_PIT               varchar(20)       NULL,
    num_Orcamento         varchar(20)       NULL,
    str_Treking           varchar(20)       NULL,
    dt_Resgate            date              NULL,
    int_Status            int               NULL,
    int_Entrega           int               NOT NULL,
    dt_Entrega            date              NULL,
    val_Valor_NF          numeric(8, 2)     NULL,
    val_Valor_Padrinho    numeric(8, 2)     NULL,
    int_Pontos            int               NOT NULL,
    str_Observacao        text              NULL,
    str_num_pedido_fs     nchar(10)         NULL,
    val_Verba_Extra       numeric(18, 2)    CONSTRAINT [DF_pi_adm_resgate_val_Verba_Extra] DEFAULT ((0.00)) NULL,
    val_Neto              numeric(18, 2)    CONSTRAINT [DF_pi_adm_resgate_val_Neto] DEFAULT ((0.00)) NULL,
    val_Receita           numeric(18, 2)    CONSTRAINT [DF_pi_adm_resgate_val_Receita] DEFAULT ((0.00)) NULL,
    periodo               int               NULL,
    val_Experiencia       numeric(18, 2)    CONSTRAINT [DF_pi_adm_resgate_val_Experiencia] DEFAULT ((0.00)) NULL,
    val_Imposto           numeric(18, 2)    CONSTRAINT [DF_pi_adm_resgate_val_Imposto] DEFAULT ((0.00)) NULL,
    dt_Solicitado         date              NULL,
    dt_Realizacao         date              NULL,
    dt_Termino            date              NULL,
    verba_pax             numeric(18, 2)    NULL,
    cod_stur              varchar(20)       NULL,
    validade              int               NULL,
    porc_Imposto          numeric(18, 2)    NULL,
    cod_ag_antigo         varchar(20)       NULL,
    val_Repasse           numeric(18, 2)    CONSTRAINT [DF_pi_adm_resgate_val_Repasse] DEFAULT ((10.00)) NULL,
    Faturado              int               NULL,
    dt_Faturado           date              NULL,
    Pgto_Fornecedor       int               NULL,
    dt_Fornecedor         date              NULL,
    solicitado            int               NULL,
    dt_solicitadof        date              NULL,
    cliente               int               NULL,
    dt_cliente            date              NULL,
    porc_Repasse          numeric(18, 2)    NULL,
    int_PontosUsuario     int               NULL,
    porc_Subsidio         int               NULL,
    int_Ativo             int               CONSTRAINT [DF_pi_adm_resgate_int_Ativo] DEFAULT ((1)) NULL,
    CarrinhoId            int               NULL,
    markup                decimal(5, 2)     NULL,
    CONSTRAINT PK_pi_adm_resgate PRIMARY KEY NONCLUSTERED (id_Resgate, id_Programa, id_Fase, id_Usuario, int_Faixa)
)
go



IF OBJECT_ID('pi_adm_resgate') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_resgate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_resgate >>>'
go

/* 
 * TABLE: pi_adm_resgate_pedido_fastshop 
 */

CREATE TABLE pi_adm_resgate_pedido_fastshop(
    id_Pedido               int              IDENTITY(1,1),
    id_Resgate              int              NOT NULL,
    str_Pedido_Dreampass    nvarchar(50)     NOT NULL,
    str_Pedido_Fastshop     nvarchar(50)     NOT NULL,
    int_Prazo_Dias          int              NOT NULL,
    str_Status              nvarchar(50)     NOT NULL,
    dat_Criacao             char(10)         NOT NULL,
    str_Endereco            nvarchar(150)    NULL,
    str_Nome                nvarchar(250)    NULL,
    CONSTRAINT PK_pi_adm_resgate_pedido_fastshop PRIMARY KEY NONCLUSTERED (id_Pedido)
)
go



IF OBJECT_ID('pi_adm_resgate_pedido_fastshop') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_resgate_pedido_fastshop >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_resgate_pedido_fastshop >>>'
go

/* 
 * TABLE: pi_adm_respostas 
 */

CREATE TABLE pi_adm_respostas(
    id_Respostas    int             IDENTITY(1,1),
    id_Usuario      int             NOT NULL,
    id_Pergunta     varchar(50)     NOT NULL,
    str_Resposta    varchar(255)    NULL,
    dt_Resposta     char(10)        NULL
)
go



IF OBJECT_ID('pi_adm_respostas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_respostas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_respostas >>>'
go

/* 
 * TABLE: pi_adm_restricoes_links 
 */

CREATE TABLE pi_adm_restricoes_links(
    id_Admin    int    NULL,
    id_Link     int    NULL
)
go



IF OBJECT_ID('pi_adm_restricoes_links') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_restricoes_links >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_restricoes_links >>>'
go

/* 
 * TABLE: pi_adm_sorte 
 */

CREATE TABLE pi_adm_sorte(
    id_Sorte           int             IDENTITY(1,1),
    id_Programa        int             NOT NULL,
    id_Fase            int             NOT NULL,
    str_Frase          varchar(250)    NULL,
    id_Profissional    int             NULL,
    id_Padrinho        int             NULL,
    CONSTRAINT PK_pi_adm_sorte PRIMARY KEY NONCLUSTERED (id_Sorte)
)
go



IF OBJECT_ID('pi_adm_sorte') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_sorte >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_sorte >>>'
go

/* 
 * TABLE: pi_adm_status_resgate 
 */

CREATE TABLE pi_adm_status_resgate(
    statusid    int          IDENTITY(1,1),
    status      nchar(50)    NULL,
    ativo       bit          NOT NULL,
    CONSTRAINT PK_pi_adm_status_resgate PRIMARY KEY NONCLUSTERED (statusid)
)
go



IF OBJECT_ID('pi_adm_status_resgate') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_status_resgate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_status_resgate >>>'
go

/* 
 * TABLE: pi_adm_sublinks 
 */

CREATE TABLE pi_adm_sublinks(
    id_Sub            int             NOT NULL,
    id_Link           int             IDENTITY(1,1),
    str_JavaScript    nvarchar(30)    NULL,
    str_Arquivo       nvarchar(30)    NULL,
    str_Nome          nvarchar(30)    NULL,
    str_URL           nvarchar(30)    NULL,
    int_Prioridade    int             NULL,
    CONSTRAINT PK_pi_adm_sublinks PRIMARY KEY NONCLUSTERED (id_Sub)
)
go



IF OBJECT_ID('pi_adm_sublinks') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_sublinks >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_sublinks >>>'
go

/* 
 * TABLE: pi_adm_token 
 */

CREATE TABLE pi_adm_token(
    id_token    int             IDENTITY(1,1),
    token       varchar(70)     NULL,
    validade    char(10)        NULL,
    email       varchar(250)    NULL,
    data        char(10)        NULL
)
go



IF OBJECT_ID('pi_adm_token') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_token >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_token >>>'
go

/* 
 * TABLE: pi_adm_upload_cliente 
 */

CREATE TABLE pi_adm_upload_cliente(
    id_Upload               int             IDENTITY(1,1),
    id_Programa             int             NULL,
    id_Fase                 int             NULL,
    id_Categoria_Cliente    int             NULL,
    str_Nome                varchar(255)    NULL,
    str_Descricao           text            NULL,
    str_Arquivo             varchar(255)    NULL,
    dt_Upload               char(10)        NULL,
    dt_Alteracao            char(10)        NULL,
    int_Ativo               int             NULL
)
go



IF OBJECT_ID('pi_adm_upload_cliente') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_upload_cliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_upload_cliente >>>'
go

/* 
 * TABLE: pi_adm_urls 
 */

CREATE TABLE pi_adm_urls(
    ID           int             NOT NULL,
    Parametro    varchar(255)    NOT NULL,
    Arquivo      varchar(255)    NOT NULL
)
go



IF OBJECT_ID('pi_adm_urls') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_urls >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_urls >>>'
go

/* 
 * TABLE: pi_adm_usuarios 
 */

CREATE TABLE pi_adm_usuarios(
    id_Usuario         int             IDENTITY(1,1),
    id_Profissional    int             NOT NULL,
    id_Programa        int             NOT NULL,
    id_Fase            int             NOT NULL,
    id_Empresa         int             NOT NULL,
    id_Perfil          int             NOT NULL,
    str_Email          varchar(150)    NULL,
    str_Senha          varchar(255)    NULL,
    id_Praca           int             NULL,
    CONSTRAINT PK_pi_adm_usuarios PRIMARY KEY NONCLUSTERED (id_Usuario, id_Profissional, id_Programa, id_Fase, id_Empresa, id_Perfil)
)
go



IF OBJECT_ID('pi_adm_usuarios') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_usuarios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_usuarios >>>'
go

/* 
 * TABLE: pi_adm_valor_premio 
 */

CREATE TABLE pi_adm_valor_premio(
    id_Premio         int              NOT NULL,
    val_Valor         numeric(8, 2)    NOT NULL,
    dt_Atualizacao    date             NULL
)
go



IF OBJECT_ID('pi_adm_valor_premio') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_valor_premio >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_valor_premio >>>'
go

/* 
 * TABLE: pi_adm_valor_premio_financeiro 
 */

CREATE TABLE pi_adm_valor_premio_financeiro(
    id_Premio             int              NOT NULL,
    val_Valor_NF          numeric(8, 2)    NOT NULL,
    val_Valor_Padrinho    numeric(8, 2)    NOT NULL,
    dt_Atualizacao        date             NULL
)
go



IF OBJECT_ID('pi_adm_valor_premio_financeiro') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_valor_premio_financeiro >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_valor_premio_financeiro >>>'
go

/* 
 * TABLE: pi_adm_vinculo_acumulos 
 */

CREATE TABLE pi_adm_vinculo_acumulos(
    id_acumulo         int    IDENTITY(1,1),
    id_Faixa           int    NULL,
    id_Profissional    int    NULL,
    a_Resgatado        int    NULL
)
go



IF OBJECT_ID('pi_adm_vinculo_acumulos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_vinculo_acumulos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_vinculo_acumulos >>>'
go

/* 
 * TABLE: pi_adm_vinculo_pontos 
 */

CREATE TABLE pi_adm_vinculo_pontos(
    id_Ponto       int    NULL,
    id_Empresa     int    NULL,
    id_Perfil      int    NULL,
    id_Programa    int    NULL,
    id_Fase        int    NULL
)
go



IF OBJECT_ID('pi_adm_vinculo_pontos') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_vinculo_pontos >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_vinculo_pontos >>>'
go

/* 
 * TABLE: pi_adm_vinculo_usuarios 
 */

CREATE TABLE pi_adm_vinculo_usuarios(
    id_Profissional    int    NOT NULL,
    id_Subordinado     int    NOT NULL,
    CONSTRAINT PK_pi_adm_vinculo_usuarios PRIMARY KEY NONCLUSTERED (id_Profissional, id_Subordinado)
)
go



IF OBJECT_ID('pi_adm_vinculo_usuarios') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_vinculo_usuarios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_vinculo_usuarios >>>'
go

/* 
 * TABLE: pi_adm_visitas 
 */

CREATE TABLE pi_adm_visitas(
    id_Visita      int        IDENTITY(1,1),
    id_Programa    int        NULL,
    id_Perfil      int        NULL,
    id_Usuario     int        NULL,
    dt_Visita      date       NULL,
    ti_Visita      time(7)    NULL,
    int_Visitas    int        NULL,
    CONSTRAINT PK_pi_adm_visitas PRIMARY KEY NONCLUSTERED (id_Visita)
)
go



IF OBJECT_ID('pi_adm_visitas') IS NOT NULL
    PRINT '<<< CREATED TABLE pi_adm_visitas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE pi_adm_visitas >>>'
go

/* 
 * TABLE: post 
 */

CREATE TABLE post(
    id              int             IDENTITY(1,1),
    nome            varchar(50)     NULL,
    enderecoPost    varchar(50)     NULL,
    email           varchar(150)    NULL
)
go



IF OBJECT_ID('post') IS NOT NULL
    PRINT '<<< CREATED TABLE post >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE post >>>'
go

/* 
 * TABLE: post2 
 */

CREATE TABLE post2(
    id               int             IDENTITY(1,1),
    nome             varchar(50)     NULL,
    enderecoPost2    varchar(150)    NULL,
    emailPost2       varchar(150)    NULL
)
go



IF OBJECT_ID('post2') IS NOT NULL
    PRINT '<<< CREATED TABLE post2 >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE post2 >>>'
go

/* 
 * TABLE: proj_op_cpf 
 */

CREATE TABLE proj_op_cpf(
    id          int             IDENTITY(1,1),
    cpf         varchar(11)     NULL,
    data        date            NULL,
    hora        time(7)         NULL,
    praca       int             NULL,
    nome        varchar(250)    NULL,
    telefone    varchar(16)     NULL,
    celular     varchar(16)     NULL,
    email       varchar(250)    NULL
)
go



IF OBJECT_ID('proj_op_cpf') IS NOT NULL
    PRINT '<<< CREATED TABLE proj_op_cpf >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE proj_op_cpf >>>'
go

/* 
 * TABLE: rankingpdgcopia 
 */

CREATE TABLE rankingpdgcopia(
    praca             nchar(20)    NULL,
    empresa           nchar(30)    NULL,
    empreendimento    nchar(20)    NULL,
    bloco             nchar(30)    NULL,
    unidade           nchar(10)    NULL,
    datavenda         date         NULL,
    mes               int          NULL,
    valorVGV          nchar(20)    NULL,
    pontsextrasvgv    int          NULL,
    peso              int          NULL,
    fifty             int          NULL,
    cpf_corretor      nchar(20)    NULL,
    ptsCorretor       int          NULL,
    cpf_gerente       nchar(20)    NULL,
    ptsGerente        int          NULL
)
go



IF OBJECT_ID('rankingpdgcopia') IS NOT NULL
    PRINT '<<< CREATED TABLE rankingpdgcopia >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE rankingpdgcopia >>>'
go

/* 
 * TABLE: sc_administradores 
 */

CREATE TABLE sc_administradores(
    id               int             IDENTITY(1,1),
    nome             varchar(250)    NULL,
    email            varchar(200)    NULL,
    senha            varchar(50)     NULL,
    administrador    int             NULL,
    programa         varchar(50)     NULL,
    ativo            int             NULL,
    data             date            CONSTRAINT [DF_sc_administradores_data] DEFAULT (sysdatetime()) NULL,
    data_alt         date            NULL,
    CONSTRAINT PK_sc_administradores PRIMARY KEY NONCLUSTERED (id)
)
go



IF OBJECT_ID('sc_administradores') IS NOT NULL
    PRINT '<<< CREATED TABLE sc_administradores >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sc_administradores >>>'
go

/* 
 * TABLE: sc_perfil 
 */

CREATE TABLE sc_perfil(
    id         int            IDENTITY(1,1),
    perfil     varchar(50)    NULL,
    local      varchar(2)     NULL,
    ativo      int            NULL,
    listar     int            NULL,
    ordem      int            NULL,
    empresa    nchar(100)     NULL,
    CONSTRAINT PK_sc_perfil PRIMARY KEY NONCLUSTERED (id)
)
go



IF OBJECT_ID('sc_perfil') IS NOT NULL
    PRINT '<<< CREATED TABLE sc_perfil >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sc_perfil >>>'
go

/* 
 * TABLE: sc_premios 
 */

CREATE TABLE sc_premios(
    id             int             IDENTITY(1,1),
    id_site        int             NULL,
    titulo         varchar(250)    NULL,
    texto          text            NULL,
    id_programa    int             NULL,
    apelido        varchar(50)     NULL,
    faixa          int             NULL,
    pessoas        int             NULL,
    img            varchar(250)    NULL,
    ativo          int             CONSTRAINT [DF_sc_premios_ativo] DEFAULT ((1)) NULL,
    descricao      text            NULL,
    nome_cinema    text            NULL,
    CONSTRAINT PK_sc_premios PRIMARY KEY NONCLUSTERED (id)
)
go



IF OBJECT_ID('sc_premios') IS NOT NULL
    PRINT '<<< CREATED TABLE sc_premios >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sc_premios >>>'
go

/* 
 * TABLE: sc_programa 
 */

CREATE TABLE sc_programa(
    id          int             IDENTITY(1,1),
    programa    varchar(200)    NOT NULL,
    resgate     int             NOT NULL
)
go



IF OBJECT_ID('sc_programa') IS NOT NULL
    PRINT '<<< CREATED TABLE sc_programa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sc_programa >>>'
go

/* 
 * TABLE: sc_programas 
 */

CREATE TABLE sc_programas(
    ProgramaID         int             IDENTITY(1,1),
    Programa           nvarchar(80)    NULL,
    Ativo              bit             CONSTRAINT [DF_sc_programas_Ativo] DEFAULT ((1)) NOT NULL,
    Resgate            bit             CONSTRAINT [DF_sc_programas_Resgate] DEFAULT ((0)) NOT NULL,
    DataCadastro       char(10)        NOT NULL,
    DataAlteracao      char(10)        NULL,
    AdministradorID    int             NULL,
    CNPJ               nvarchar(50)    NULL,
    Email              nvarchar(50)    NULL,
    CONSTRAINT PK_sc_programas PRIMARY KEY NONCLUSTERED (ProgramaID)
)
go



IF OBJECT_ID('sc_programas') IS NOT NULL
    PRINT '<<< CREATED TABLE sc_programas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sc_programas >>>'
go

/* 
 * TABLE: seg_tela 
 */

CREATE TABLE seg_tela(
    telaId         int             IDENTITY(1,1),
    nome           varchar(150)    NOT NULL,
    urlRelativa    varchar(250)    NOT NULL,
    menuId         int             NULL,
    CONSTRAINT PK_seg_tela PRIMARY KEY NONCLUSTERED (telaId)
)
go



IF OBJECT_ID('seg_tela') IS NOT NULL
    PRINT '<<< CREATED TABLE seg_tela >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE seg_tela >>>'
go

/* 
 * TABLE: Sessions 
 */

CREATE TABLE Sessions(
    SessionId          nchar(80)         NOT NULL,
    ApplicationName    nchar(255)        NOT NULL,
    Created            char(10)          NULL,
    Expires            char(10)          NULL,
    LockDate           char(10)          NULL,
    LockId             numeric(18, 0)    NULL,
    TimeOut            numeric(18, 0)    NULL,
    Locked             bit               NULL,
    SessionItems       text              NULL,
    Flags              int               NULL,
    CONSTRAINT PK_Sessions PRIMARY KEY NONCLUSTERED (SessionId, ApplicationName)
)
go



IF OBJECT_ID('Sessions') IS NOT NULL
    PRINT '<<< CREATED TABLE Sessions >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Sessions >>>'
go

/* 
 * TABLE: sys_tabela 
 */

CREATE TABLE sys_tabela(
    id      int            IDENTITY(1,1),
    name    varchar(50)    NULL
)
go



IF OBJECT_ID('sys_tabela') IS NOT NULL
    PRINT '<<< CREATED TABLE sys_tabela >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sys_tabela >>>'
go

/* 
 * TABLE: sysdiagrams 
 */

CREATE TABLE sysdiagrams(
    diagram_id      int               IDENTITY(1,1),
    name            char(10)          NOT NULL,
    principal_id    int               NOT NULL,
    version         int               NULL,
    definition      varbinary(max)    NULL,
    CONSTRAINT PK__sysdiagr__C2B05B61731A00F7 PRIMARY KEY NONCLUSTERED (diagram_id)
)
go



IF OBJECT_ID('sysdiagrams') IS NOT NULL
    PRINT '<<< CREATED TABLE sysdiagrams >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sysdiagrams >>>'
go

/* 
 * TABLE: tb_femsa 
 */

CREATE TABLE tb_femsa(
    id           int             IDENTITY(1,1),
    matricula    varchar(100)    NULL,
    tipo         varchar(250)    NULL,
    nome         varchar(250)    NULL,
    celular      varchar(50)     NULL,
    email        varchar(250)    NULL,
    senha        varchar(50)     NULL,
    praca        int             NULL,
    nivel        int             NULL
)
go



IF OBJECT_ID('tb_femsa') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_femsa >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_femsa >>>'
go

/* 
 * TABLE: tb_resultado_quiz 
 */

CREATE TABLE tb_resultado_quiz(
    id          int               IDENTITY(1,1),
    nome        varchar(250)      NULL,
    corretor    varchar(250)      NULL,
    pontos      numeric(18, 0)    NULL,
    tempo       time(7)           NULL,
    inicio      date              NULL,
    semana      numeric(18, 0)    NULL
)
go



IF OBJECT_ID('tb_resultado_quiz') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_resultado_quiz >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_resultado_quiz >>>'
go

/* 
 * TABLE: tb_subcategoria 
 */

CREATE TABLE tb_subcategoria(
    id              int               IDENTITY(1,1),
    id_categoria    int               NULL,
    nome            nvarchar(250)     NULL,
    descricao       nvarchar(4000)    NULL,
    imagem          nvarchar(250)     NULL,
    ativo           bit               NOT NULL
)
go



IF OBJECT_ID('tb_subcategoria') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_subcategoria >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_subcategoria >>>'
go

/* 
 * TABLE: tb_telhanorte 
 */

CREATE TABLE tb_telhanorte(
    id           int             IDENTITY(1,1),
    matricula    int             NOT NULL,
    nome         nvarchar(50)    NOT NULL,
    admissao     date            NOT NULL,
    cargo        nvarchar(50)    NOT NULL,
    empresa      int             NOT NULL,
    cpf          nvarchar(50)    NOT NULL,
    celular      nvarchar(50)    NULL,
    email        nvarchar(50)    NULL,
    senha        nchar(10)       NULL
)
go



IF OBJECT_ID('tb_telhanorte') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_telhanorte >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_telhanorte >>>'
go

/* 
 * TABLE: tb_telhanorte_temp 
 */

CREATE TABLE tb_telhanorte_temp(
    id           int             IDENTITY(1,1),
    matricula    int             NOT NULL,
    nome         nvarchar(50)    NOT NULL,
    admissao     date            NOT NULL,
    cargo        nvarchar(50)    NOT NULL,
    empresa      int             NOT NULL,
    cpf          nvarchar(50)    NOT NULL,
    celular      nvarchar(50)    NULL,
    email        nvarchar(50)    NULL,
    senha        nchar(10)       NULL
)
go



IF OBJECT_ID('tb_telhanorte_temp') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_telhanorte_temp >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_telhanorte_temp >>>'
go

/* 
 * TABLE: tb_tudook_pdg 
 */

CREATE TABLE tb_tudook_pdg(
    id                     int               IDENTITY(1,1),
    nome                   varchar(150)      NULL,
    str_cpf                varchar(11)       NULL,
    sexo                   nchar(1)          NULL,
    cargo                  varchar(150)      NULL,
    id_Perfilsc            int               NULL,
    cpf_Coordenador        varchar(50)       NULL,
    centro_de_resultado    varchar(50)       NULL,
    id_Empresa             int               NULL,
    id_Praca               int               NULL,
    email                  varchar(150)      NULL,
    senha                  varchar(16)       NULL,
    celular                numeric(18, 0)    NULL
)
go



IF OBJECT_ID('tb_tudook_pdg') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_tudook_pdg >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_tudook_pdg >>>'
go

/* 
 * TABLE: tb_tudook_pdg_temp 
 */

CREATE TABLE tb_tudook_pdg_temp(
    cpf    varchar(50)    NULL
)
go



IF OBJECT_ID('tb_tudook_pdg_temp') IS NOT NULL
    PRINT '<<< CREATED TABLE tb_tudook_pdg_temp >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tb_tudook_pdg_temp >>>'
go

/* 
 * TABLE: tbnv_cb_categoria 
 */

CREATE TABLE tbnv_cb_categoria(
    IdCategoria       bigint           NOT NULL,
    IdCategoriaPai    bigint           NULL,
    IdDepartamento    bigint           NOT NULL,
    CatLevel          int              NOT NULL,
    Nome              nvarchar(250)    NOT NULL,
    Ativo             bit              NOT NULL,
    CONSTRAINT PK_tbnv_cb_categoria PRIMARY KEY NONCLUSTERED (IdCategoria)
)
go



IF OBJECT_ID('tbnv_cb_categoria') IS NOT NULL
    PRINT '<<< CREATED TABLE tbnv_cb_categoria >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tbnv_cb_categoria >>>'
go

/* 
 * TABLE: tbnv_pf_categoria 
 */

CREATE TABLE tbnv_pf_categoria(
    IdCategoria       bigint           NOT NULL,
    IdCategoriaPai    bigint           NULL,
    IdDepartamento    bigint           NOT NULL,
    CatLevel          int              NOT NULL,
    Nome              nvarchar(250)    NOT NULL,
    Ativo             bit              NOT NULL,
    CONSTRAINT PK_tbnv_pf_categoria PRIMARY KEY NONCLUSTERED (IdCategoria)
)
go



IF OBJECT_ID('tbnv_pf_categoria') IS NOT NULL
    PRINT '<<< CREATED TABLE tbnv_pf_categoria >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tbnv_pf_categoria >>>'
go

