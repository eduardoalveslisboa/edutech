--********** Execute at the Distributor in the master database **********--

use master
go

--Is the current server a Distributor?
--Is the distribution database installed?
--Are there other Publishers using this Distributor?
exec sp_get_distributor

--Is the current server a Distributor?
select is_distributor from sys.servers where name='repl_distributor' and data_source=@@servername

--Which databases on the Distributor are distribution databases?
select name from sys.databases where is_distributor = 1

--What are the Distributor and distribution database properties?
exec sp_helpdistributor
exec sp_helpdistributiondb
exec sp_helpdistpublisher


--********** Execute at the Publisher in the master database **********--

--Which databases are published for replication and what type of replication?
exec sp_helpreplicationdboption

--Which databases are published using snapshot replication or transactional replication?
select name as tran_published_db from sys.databases where is_published = 1
--Which databases are published using merge replication?
select name as merge_published_db from sys.databases where is_merge_published = 1

--What are the properties for Subscribers that subscribe to publications at this Publisher?
exec sp_helpsubscriberinfo


--********** Execute at the Publisher in the publication database **********--

use AdventureWorks
go

--What are the snapshot and transactional publications in this database? 
exec sp_helppublication
--What are the articles in snapshot and transactional publications in this database?
--REMOVE COMMENTS FROM NEXT LINE AND REPLACE <PublicationName> with the name of a publication
--exec sp_helparticle @publication='<PublicationName>'

--What are the merge publications in this database? 
exec sp_helpmergepublication
--What are the articles in merge publications in this database?
exec sp_helpmergearticle -- to return information on articles for a single publication, specify @publication='<PublicationName>'

--Which objects in the database are published?
select name as published_object, schema_id, is_published as is_tran_published, is_merge_published, is_schema_published
from sys.tables where is_published = 1 or is_merge_published = 1 or is_schema_published = 1
union
select name as published_object, schema_id, 0, 0, is_schema_published
from sys.procedures where is_schema_published = 1
union
select name as published_object, schema_id, 0, 0, is_schema_published
from sys.views where is_schema_published = 1

--Which columns are published in snapshot or transactional publications in this database?
select object_name(object_id) as tran_published_table, name as published_column from sys.columns where is_replicated = 1

--Which columns are published in merge publications in this database?
select object_name(object_id) as merge_published_table, name as published_column from sys.columns where is_merge_published = 1