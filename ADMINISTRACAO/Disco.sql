DECLARE @hr int 
DECLARE @fso int 
DECLARE @drive char(1) 
DECLARE @odrive int 
DECLARE @TotalSize varchar(20) 
DECLARE @MB bigint ; SET @MB = 1048576
 
CREATE TABLE #drives (drive char(1) PRIMARY KEY, 
                      FreeSpace int NULL, 
                      TotalSize int NULL) 
 
INSERT #drives(drive,FreeSpace) 
EXEC master.dbo.xp_fixeddrives 
 
EXEC @hr=sp_OACreate 'Scripting.FileSystemObject',@fso OUT 
IF @hr <> 0 EXEC sp_OAGetErrorInfo @fso 
 
			DECLARE dcur CURSOR LOCAL FAST_FORWARD 
			FOR SELECT drive from #drives 
			ORDER by drive 
 
			OPEN dcur 
 
			FETCH NEXT FROM dcur INTO @drive 
 
					WHILE @@FETCH_STATUS=0 
						BEGIN 
 
						EXEC @hr = sp_OAMethod @fso,'GetDrive', @odrive OUT, @drive 
									IF @hr <> 0 EXEC sp_OAGetErrorInfo @fso 
									EXEC @hr = sp_OAGetProperty @odrive,'TotalSize', @TotalSize OUT 
										IF @hr <> 0 EXEC sp_OAGetErrorInfo @odrive 
											UPDATE #drives 
											SET TotalSize=@TotalSize/@MB 
											WHERE drive=@drive 
			FETCH NEXT FROM dcur INTO @drive 
 
END 
 
CLOSE dcur 
DEALLOCATE dcur 
 
EXEC @hr=sp_OADestroy @fso 
				IF @hr <> 0 EXEC sp_OAGetErrorInfo @fso 
 
						SELECT @@servername Servidor,drive, 
						FreeSpace as 'Livre(MB)', 
						TotalSize as 'Total(MB)', 
						TotalSize-FreeSpace 'Usado(MB)',
						CAST((FreeSpace/(TotalSize*1.0))*100.0 as int) as 'Livre(%)' 
						FROM #drives 
						ORDER BY drive 
 
DROP TABLE #drives 
 
RETURN 
GO

---SELECT DB_NAME(DATABASE_ID),* FROM SYS.MASTER_FILES --ONDE ESTAO OS ARQUIVOS DE BANCO DE DADOS


-- sp_configure 'Ole Automation Procedures',1
--sp_configure 'show advanced options',1 reconfigure