-- To get database users and their roles for each user database --
-- lines added to include ALL users even those without roles --
-- lines added to add instance login names and status --

create table #userlist (
[Server Name] varchar(200)
,[Database Name] varchar(200)
,[Database User] varchar(50)
, [Database Role] varchar(50)
, [Instance Login] varchar(50)
, [Status] varchar(15)
)
go
insert into #userlist
exec sp_MSforeachdb @command1 ='
USE [?]
IF      ''?''     NOT IN ("tempdb","model","msdb","master")
BEGIN
select @@servername as instance_name
, ''?'' as database_name
, rp.name as database_user
, mp.name as database_role
, sp.name as instance_login
,case 
when sp.is_disabled = 1 then ''Disabled''
when sp.is_disabled = 0 then ''Enabled''
end
[login_status]
from sys.database_principals rp 
left outer join sys.database_role_members drm on (drm.member_principal_id = rp.principal_id) 
left outer join sys.database_principals mp on (drm.role_principal_id = mp.principal_id)
left outer join sys.server_principals sp on (rp.sid=sp.sid)
where rp.type_desc in (''WINDOWS_USER'',''SQL_USER'')
END'
go
select * from #userlist where [Database User]='FUNCIONAL\FUNCIONALPLANT'
go
drop table #userlist


SELECT * FROM sys.database_principals 