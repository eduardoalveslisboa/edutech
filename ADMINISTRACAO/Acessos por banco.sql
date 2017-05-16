SELECT DB_NAME() as DBName ,UserName, 

Max(CASE RoleName WHEN 'db_owner' THEN 'Yes' ELSE 'No' END) AS db_owner,

Max(CASE RoleName WHEN 'db_accessadmin ' THEN 'Yes' ELSE 'No' END) AS db_accessadmin ,

Max(CASE RoleName WHEN 'db_securityadmin' THEN 'Yes' ELSE 'No' END) AS db_securityadmin,

Max(CASE RoleName WHEN 'db_ddladmin' THEN 'Yes' ELSE 'No' END) AS db_ddladmin,

Max(CASE RoleName WHEN 'db_datareader' THEN 'Yes' ELSE 'No' END) AS db_datareader,

Max(CASE RoleName WHEN 'db_datawriter' THEN 'Yes' ELSE 'No' END) AS db_datawriter,

Max(CASE RoleName WHEN 'db_denydatareader' THEN 'Yes' ELSE 'No' END) AS db_denydatareader,

Max(CASE RoleName WHEN 'db_denydatawriter' THEN 'Yes' ELSE 'No' END) AS db_denydatawriter

from (

select b.name as USERName, c.name as RoleName

from sysmembers a join dbo.sysusers b on a.memberuid = b.uid join dbo.sysusers c

on a.groupuid = c.uid )s
where USERName in (SELECT name FROM sys.server_principals where is_disabled=0)

Group by USERName

order by UserName


