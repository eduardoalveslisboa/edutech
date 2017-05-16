

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



CREATE TABLE #drives2 (drive char(1) PRIMARY KEY, 
                      FreeSpace int NULL, 
                      TotalSize int NULL,
                      LivrePercent int)   
 
INSERT INTO #drives2 
SELECT Drive, 
       FreeSpace/1024 as 'Livre(GB)', 
       TotalSize/1024 as 'Total(GB)', 
       CAST((FreeSpace/(TotalSize*1.0))*100.0 as int) as 'LivrePercent' 
FROM #drives 
ORDER BY drive 

DECLARE @VOLUME VARCHAR(100)
DECLARE VOLUME CURSOR FOR 
SELECT DRIVE FROM #DRIVES2
OPEN VOLUME
FETCH NEXT FROM VOLUME INTO @VOLUME
WHILE @@FETCH_STATUS=0
BEGIN
IF (SELECT CAST((FreeSpace/(TotalSize*1.0))*100.0 as int)-50 FROM #drives2 WHERE drive=@drive)<abs(5)
BEGIN
PRINT 'Espaço abaixo do limite no volume: '+@VOLUME
declare @servername varchar(100)

declare @tableHTML as varchar(max)
    SET @tableHTML =

	N'<font size="5" color="Black">Pouco espaço servidor '+@@SERVERNAME+' Volume '+@volume+'</font><BR><BR>' +

  N'<table border="1">' +

    N'<tr><th>Volume </th><th> Espaço livre Gb </th><th> Livre % </th><th> Espaço Total GB </th></tr>' +

    CAST ( ( SELECT td = Drive,       '',

                    td = FreeSpace, '',
                    td = LivrePercent, '',
                    td = TotalSize, ''
                   
              FROM #drives2 WHERE drive=@VOLUME

              FOR XML PATH('tr'), TYPE 

    ) AS NVARCHAR(MAX) ) +


    N'</table>'+'<BR><BR>' ;

exec msdb..sp_send_dbmail @profile_Name='MonitoraSQL' 

                   ,@recipients='mpenna@funcionalmais.com'				   

				   ,@importance='High'

				   ,@subject='Alerta - de espaço SQL Server'

				   ,@body=@tableHTML

				   ,@body_format='HTML';		

END
ELSE
PRINT'ESPAÇO EM '+ @VOLUME +' É SUFICIENTE'
FETCH NEXT FROM VOLUME INTO @VOLUME
END
CLOSE VOLUME 
DEALLOCATE VOLUME
 
 
 
DROP TABLE #drives 
DROP TABLE #Drives2 
RETURN 
GO
