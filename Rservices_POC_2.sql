USE EduTech;
GO
DECLARE
       @R NVARCHAR(MAX) = '
# Initialize a temporary file and set the graphics device to use it
image_file = tempfile()
jpeg(filename = image_file, width=400, height = 600)

# Render plot to the graphics device
hist(dat$SizeInKB, col = c("lightgrey"), main = "Cached Plan Size Distribution")
dev.off()

# Binarize the temporary file and assign it to our output variable
Plot <- readBin(file(image_file, "rb"), what=raw(), n=1e6)
'

EXEC GetRPlotInHtml
    @R = @R,
    @SQL = N'SELECT size_in_bytes / 1024 SizeInKB FROM sys.dm_exec_cached_plans'


/*

--# Initialize a temporary file and set the graphics device to use it  
image_file = tempfile()  jpeg(filename = image_file, width=400, height = 600)    

--# Render plot to the graphics device  

hist(dat$SizeInKB, col = c("lightgrey"), main = "Cached Plan Size Distribution")  dev.off()    

--# Binarize the temporary file and assign it to our output variable  

Plot <- readBin(file(image_file, "rb"), what=raw(), n=1e6)  


*/

