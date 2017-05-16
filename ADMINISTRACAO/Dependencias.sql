
/***Autor:     Marcio Penna                               23/03/2016***/
/** Objetivo : Encontrar objetos referenciados dentro de alguma procedure , view , função ...etc 
					Exemplo: Passar como parametro uma procedure listar todas as tabelas usadas dentro dessa procedure.
			   encontrar objetos que referenciam esse objeto
					Exemplo: Encontrar todas as procedure que referenciam uma tabela em especifico ***/


/***Encontrando Objetos que referenciam ou são referenciados dentro de um determinado Objeto***/

SELECT
referencing_schema_name = SCHEMA_NAME(o.SCHEMA_ID),
referencing_object_name = o.name,
referencing_object_type_desc = o.type_desc,
referenced_schema_name,
referenced_object_name = referenced_entity_name,
referenced_object_type_desc = o1.type_desc,
referenced_server_name, referenced_database_name
--,sed.* -- Uncomment for all the columns
FROM
sys.sql_expression_dependencies sed
INNER JOIN
sys.objects o ON sed.referencing_id = o.[object_id] LEFT OUTER JOIN
sys.objects o1 ON sed.referenced_id = o1.[object_id] WHERE
referenced_entity_name = 't_FatoVendas'



/***Encontrando Objetos referenciados em procedures no banco de contexto***/

SELECT
referencing_schema_name = SCHEMA_NAME(o.SCHEMA_ID),
referencing_object_name = o.name,
referencing_object_type_desc = o.type_desc,
referenced_schema_name,
referenced_object_name = referenced_entity_name,
referenced_object_type_desc = o1.type_desc,
referenced_server_name, referenced_database_name
--,sed.* -- Uncomment for all the columns
FROM
sys.sql_expression_dependencies sed
INNER JOIN
sys.objects o ON sed.referencing_id = o.[object_id] LEFT OUTER JOIN
sys.objects o1 ON sed.referenced_id = o1.[object_id] WHERE
o.name = 'p_CargaDWAtualizaPrimeiraUltimaCompraProduto'