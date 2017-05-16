Use MONITORSQL
GO

with CTE_Polldate_Max AS (select distinct DatabaseName,
                          MAX(polldate)over(partition by DatabaseName) as Pollmax 
						      from tablespace)

select DatabaseName,
		SchemaName,
		name,
		rows,
		convert(int,reserved)/1024 reserved_MB,data/1024 Data_MB,
		index_size,unused,
		Max(Polldate) over (Partition by DatabaseName, name)Data 
			from TableSpace
			where Polldate  in (select Pollmax from CTE_Polldate_Max)
			order by reserved_MB desc


