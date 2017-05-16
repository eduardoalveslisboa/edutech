/***GERAR A CRIAÇÃO DE LOGINS DOS BANCOS DE PRODUÇÃO
Autor: Marcio Penna 03/11/2015 ***/


SELECT 'IF(SUSER_ID('+QUOTENAME(SP.name,'''')+') IS NULL)BEGIN CREATE LOGIN '+QUOTENAME(SP.name)+
CASE WHEN SP.type_desc = 'SQL_LOGIN' THEN ' WITH PASSWORD = '+CONVERT(NVARCHAR(MAX),SL.password_hash,1)+' HASHED'
                                     ELSE ' FROM WINDOWS' END + ';/*'+SP.type_desc+'*/ END;'
COLLATE SQL_Latin1_General_CP1_CI_AS
FROM      sys.server_principals   AS SP
LEFT JOIN sys.sql_logins          AS SL ON SP.principal_id = SL.principal_id
LEFT JOIN sys.server_role_members as SR ON SR.role_principal_id = SP.principal_id
WHERE SP.type_desc IN ('SQL_LOGIN','WINDOWS_GROUP','WINDOWS_LOGIN')
	AND SP.name NOT LIKE '##%##'
	AND SP.name NOT IN ('SA');

/*** GERA SCRIPT SYSADMIN ***/

SELECT 'ALTER SERVER ROLE [sysadmin] ADD MEMBER [' + member.name + ']'AS MemberName
FROM sys.server_role_members          
JOIN sys.server_principals   AS role   ON sys.server_role_members.role_principal_id = role.principal_id
JOIN sys.server_principals   AS member ON sys.server_role_members.member_principal_id = member.principal_id
WHERE MEMBER.is_disabled <>1
