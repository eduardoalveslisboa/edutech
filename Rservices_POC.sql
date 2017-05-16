ALTER PROCEDURE GetRPlotInHtml (
       @R NVARCHAR(MAX),
       @SQL NVARCHAR(MAX),
       @TempFilePath NVARCHAR(50) = 'C:\Temp\SQL Server'
)
AS

DECLARE
       @Plot VARBINARY(MAX),
       @PlotBase64 NVARCHAR(MAX),
       @Html XML,
       @FileName NVARCHAR(50),
       @HtmlStr NVARCHAR(MAX)

DECLARE @SqlJob TABLE
(
    Name        NVARCHAR(250),
    DurationSec INT
)
SELECT @R AS R,@SQL AS SQLL

-- Generate plot using "dat" as the input dataset and "Plot" as the output variable
EXEC sp_execute_external_script
       @language = N'R',
       @script = @R,
       @input_data_1 = @SQL,
       @input_data_1_name = N'dat',
       @params = N'@Plot VARBINARY(MAX) OUTPUT',
       @Plot = @Plot OUTPUT



-- Get the plot as a Base-64 string
SET @PlotBase64 = CAST('' AS XML).value('xs:base64Binary(sql:variable("@Plot"))', 'VARCHAR(MAX)')
                   

-- Create HTML
SET @Html = '<html>
<body>
       <img alt="Boxplot of SQL Job Durations" src="data:image/jpeg;base64,' + @PlotBase64 + '" />
</body>
</html>
'

-- Write an HTML file to disk
SET @FileName = CAST(NEWID() AS NVARCHAR(50)) + '.html'
SET @HtmlStr = CONVERT(NVARCHAR(MAX), @Html)

SET @R = 'write.table(HtmlStr, file="' + REPLACE(@TempFilePath, '\', '\\') + '\\' + @FileName + '", quote = FALSE, col.names = FALSE, row.names = FALSE)'



EXEC sys.sp_execute_external_script
       @language = N'R',
       @script = @R,
       @params = N'@HtmlStr NVARCHAR(MAX)',
       @HtmlStr = @HtmlStr

-- Return URL
SELECT @TempFilePath + '\' + @FileName [URL]
