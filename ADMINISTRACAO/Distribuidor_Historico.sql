USE Distribution
GO
 
SELECT      max(time)Time , 
            s.Name            PublisherServer,
            a.publication     Publication,
            s2.name           SubscriberServer,
SUBSTRING(comments,8,CHARINDEX('''',comments,8)-8) TableName,
            comments          Comments
      FROM dbo.MSdistribution_history  h
       JOIN dbo.MSdistribution_agents   a
         ON h.agent_id = a.id
                  JOIN master.sys.servers s
                    ON a.publisher_id = s.server_id
                        JOIN master.sys.servers s2
                          ON a.subscriber_id = s2.server_id        
      WHERE comments like 'Table %'
	  group by s.name ,publication,s2.name,comments
	  order by Time desc

