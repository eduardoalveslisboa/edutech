

alter PROCEDURE CRESCIMENTO_BASE
@Servername sysname,
@DatabaseName sysname
AS
begin
declare @SQL nvarchar(max)
set @sql=('SELECT UPPER(Database_Name) Database_Name,File_Name,File_Path,File_Size_in_MB,Space_Used_in_MB,polldate,upper(File_Type) File_Type FROM '+quotename(@Servername)+'.MONITORSQL.dbo.db_file_info 
where Database_name= '''+@DatabaseName+''' 
 ORDER BY Polldate DESC')
exec sp_executesql @sql
end
