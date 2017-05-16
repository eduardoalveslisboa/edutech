
/***********************************************************************************
 *****SCRIPT PARA COLETAR INFORMAÇÕES DE ACESSO NOS SERVIDORES E BASE DE DADOS *****
 ***********************************************************************************/



/* 
Acessos SQL Server
*/
DECLARE @DB_USers TABLE
(DBName sysname, UserName sysname, LoginType sysname, AssociatedRole varchar(max),create_date datetime,modify_date datetime)

INSERT @DB_USers
EXEC sp_MSforeachdb

'
use [?]
SELECT ''?'' AS DB_Name,
case prin.name when ''dbo'' then prin.name + '' (''+ (select SUSER_SNAME(owner_sid) from master.sys.databases where name =''?'') + '')'' else prin.name end AS UserName,
prin.type_desc AS LoginType,
isnull(USER_NAME(mem.role_principal_id),'''') AS AssociatedRole ,create_date,modify_date
FROM sys.database_principals prin
LEFT OUTER JOIN sys.database_role_members mem ON prin.principal_id=mem.member_principal_id
WHERE prin.sid IS NOT NULL and prin.sid NOT IN (0x00) and
prin.is_fixed_role <> 1 AND prin.name NOT LIKE ''##%'''

SELECT

DBName Banco,UserName Usuario ,LoginType TipoLogin,create_date DataCriacao,modify_date DataModificacao ,

STUFF(

(

SELECT ',' + CONVERT(VARCHAR(500),AssociatedRole)

FROM @DB_USers user2

WHERE  

user1.DBName=user2.DBName AND user1.UserName=user2.UserName

FOR XML PATH('')

)

,1,1,'') AS PermissaoUsuario

FROM @DB_USers user1  

GROUP BY

DBName,UserName ,LoginType ,create_date ,modify_date

ORDER BY DBName,UserName




/*Database Level*/


DECLARE @cmd VARCHAR(5000)
SET @cmd ='
Use [?];
SELECT DB_NAME() as DBName ,UserName, 
Max(CASE RoleName WHEN ''db_owner'' THEN ''Yes'' ELSE ''No'' END) AS db_owner,						
Max(CASE RoleName WHEN ''db_accessadmin '' THEN ''Yes'' ELSE ''No'' END) AS db_accessadmin ,						
Max(CASE RoleName WHEN ''db_securityadmin'' THEN ''Yes'' ELSE ''No'' END) AS db_securityadmin,						
Max(CASE RoleName WHEN ''db_ddladmin'' THEN ''Yes'' ELSE ''No'' END) AS db_ddladmin,						
Max(CASE RoleName WHEN ''db_datareader'' THEN ''Yes'' ELSE ''No'' END) AS db_datareader,						
Max(CASE RoleName WHEN ''db_datawriter'' THEN ''Yes'' ELSE ''NO'' END) AS db_datawriter,						
Max(CASE RoleName WHEN ''db_denydatareader'' THEN ''Yes'' ELSE ''No'' END) AS db_denydatareader,						
Max(CASE RoleName WHEN ''db_denydatawriter'' THEN ''Yes'' ELSE ''NO'' END) AS db_denydatawriter

from 
(
    select b.name as UserName, c.name as RoleName
    from sysmembers AS a 
    join dbo.sysusers b on a.memberuid = b.uid join dbo.sysusers c
    on a.groupuid = c.uid 
) AS s
where 
UserName in 
(
    SELECT name COLLATE Latin1_General_100_CI_AS_KS_WS
    FROM sys.server_principals 
    WHERE is_disabled=0
    )
Group by UserName
order by UserName
'

EXEC sp_MSforeachdb @cmd

