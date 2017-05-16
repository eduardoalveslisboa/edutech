/*

RELATORIO DE AUDITORIA DE SEGURANÇA
 
 1)Lista todos os acesso para o usuário SQL ou windows user /grupo diretamente
 2)Lista todos os acessos para o usuario SQL ou windows user/gupo através de um banco de dados ou uma aplicação
 3)Lista todos os acessos para a Role Public
 
Colunas retornadas:

UserName        :SQL ou conta Windows. Pode ser também um grupo do active diretory.
UserType        :O Valor pode ser ou "SQL User" ou "Windows User". Isso reflete o tipo de de usuario definido para a conta do usuário SQL 
DatabaseUserName:Nome do usuário associado como usuario definido no banco de dados. O nome do usuario de banco não pode ser o mesmo como o usuário de servidor.
Role:           : Nome da Regra. Ele pode retornar nulo se a permissão associada para o objeto estiver definida diretamente na conta do usuário
				,de outra forma pode ser o nome da regra que o usuário é membro.

PermissionType  : Tipo de permissão. Esse valores podem não ser populados para todas as regras.
                  Algumas regras tem valores de permissões implicitas
PermissionState : Reflete o status da permissão (DENY,GRANT,etc...)
ObjectType      : Tipo de objeto as quais a permissoes são atribuidas.  Exemplos  USER_TABLE, 
                  SQL_SCALAR_FUNCTION, SQL_INLINE_TABLE_VALUED_FUNCTION, SQL_STORED_PROCEDURE, VIEW, etc.   
                  Esse valores podem não ser populados para todas as regras.
                  Algumas regras tem valores de permissões implicitas
ObjectName      : Nome de objeto ao qual se aplica a regra
ColumnName      : Nome da coluna do objeto que o usuário tem permissão atribuida. Esses valores penas podem ser populados se o objeto é uma tabela, view ou table value function
            
*/
--LIsta de acessos fornecidos para o usuário SQL ou Windows User/Group diretamente 

SELECT  
    [LoginName] = CASE princ.[type] 
                    WHEN 'S' THEN princ.[name]
                    WHEN 'U' THEN ulogin.[name] COLLATE Latin1_General_CI_AI
                 END,
    [UserType] = CASE princ.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                 END,  
    [DatabaseUserName] = princ.[name],       
    [Role] = null,      
    [PermissionType] = perm.[permission_name],       
    [PermissionState] = perm.[state_desc],       
    [ObjectType] = obj.type_desc,--perm.[class_desc],       
    [ObjectName] = OBJECT_NAME(perm.major_id),
    [ColumnName] = col.[name]
FROM    
    --database user
    sys.database_principals princ  
LEFT JOIN
    --Login accounts
    sys.login_token ulogin on princ.[sid] = ulogin.[sid]
LEFT JOIN        
    --Permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = princ.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col ON col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]
LEFT JOIN
    sys.objects obj ON perm.[major_id] = obj.[object_id]
WHERE 
    princ.[type] in ('S','U')
UNION
--Lista de todos os acessos fornecidos para um usuário SQL ou Windows User/Group através de um database ou aplicação

SELECT  
    [LoginName] = CASE memberprinc.[type] 
                    WHEN 'S' THEN memberprinc.[name]
                    WHEN 'U' THEN ulogin.[name] COLLATE Latin1_General_CI_AI
                 END,
    [UserType] = CASE memberprinc.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                 END, 
    [DatabaseUserName] = memberprinc.[name],   
    [Role] = roleprinc.[name],      
    [PermissionType] = perm.[permission_name],       
    [PermissionState] = perm.[state_desc],       
    [ObjectType] = obj.type_desc,--perm.[class_desc],   
    [ObjectName] = OBJECT_NAME(perm.major_id),
    [ColumnName] = col.[name]
FROM    
    --Role/member associations
    sys.database_role_members members
JOIN
    --Roles
    sys.database_principals roleprinc ON roleprinc.[principal_id] = members.[role_principal_id]
JOIN
    --Role members (database users)
    sys.database_principals memberprinc ON memberprinc.[principal_id] = members.[member_principal_id]
LEFT JOIN
    --Login accounts
    sys.login_token ulogin on memberprinc.[sid] = ulogin.[sid]
LEFT JOIN        
    --Permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = roleprinc.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col on col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]
LEFT JOIN
    sys.objects obj ON perm.[major_id] = obj.[object_id]
UNION
-- lista todos os acessos forncecidos para a role "Public" , a qual todos recebem acesso

SELECT  
    [UserName] = '{All Users}',
    [UserType] = '{All Users}', 
    [DatabaseUserName] = '{All Users}',       
    [Role] = roleprinc.[name],      
    [PermissionType] = perm.[permission_name],       
    [PermissionState] = perm.[state_desc],       
    [ObjectType] = obj.type_desc,--perm.[class_desc],  
    [ObjectName] = OBJECT_NAME(perm.major_id),
    [ColumnName] = col.[name]
FROM    
    --Roles
    sys.database_principals roleprinc
LEFT JOIN        
    --Role permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = roleprinc.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col on col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]                   
JOIN 
    --All objects   
    sys.objects obj ON obj.[object_id] = perm.[major_id]
WHERE
    --Only roles
    roleprinc.[type] = 'R' AND
    --Only public role
    roleprinc.[name] = 'public' AND
    --Only objects of ours, not the MS objects
    obj.is_ms_shipped = 0
ORDER BY
    princ.[Name],
    OBJECT_NAME(perm.major_id),
    col.[name],
    perm.[permission_name],
    perm.[state_desc],
    obj.type_desc--perm.[class_desc] 
