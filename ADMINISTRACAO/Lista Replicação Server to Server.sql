USE Distribution 
GO 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
-- Get the publication name based on article 
SELECT DISTINCT  
case when srv.srvname ='VMBSQLAUT01PRD' then 'BENEFIT4'
      when srv.srvname ='VMBSQLDBS01PRD' then 'DBSERVER3' ELSE srv.srvname END  as ServidorOrigem
, a.publisher_db as BancoOrigem
, p.publication NomePublicacao
, a.article TabelaOrigem
, a.destination_object TabelaDestino
, ss.srvname ServidorDestino
, s.subscriber_db BancoDestino 
--,da.name
--, da.name AS distribution_agent_job_name 
FROM MSArticles a  
JOIN MSpublications p ON a.publication_id = p.publication_id 
JOIN MSsubscriptions s ON p.publication_id = s.publication_id 
JOIN master..sysservers ss ON s.subscriber_id = ss.srvid 
JOIN master..sysservers srv ON srv.srvid = p.publisher_id 
JOIN MSdistribution_agents da ON da.publisher_id = p.publisher_id  
     AND da.subscriber_id = s.subscriber_id 
ORDER BY 1,2,3 






                                                                  





