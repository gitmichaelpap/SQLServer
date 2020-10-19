-- Chama a sys.dm_db_index_physical_stats e procura por índices com fragmentação maior que 10%
SELECT  
    o.name as table_name, 
	i.name as index_name,
	ips.object_id AS objectid,  
    ips.index_id AS indexid,  
    ips.partition_number AS partitionnum,  
    ips.avg_fragmentation_in_percent AS frag  
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')  ips
JOIN sys.objects o on o.object_id = ips.object_id  
JOIN sys.indexes i ON  o.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.avg_fragmentation_in_percent > 10.0 AND ips.index_id > 0;  

-- Reorganiza o índice AK_Employee_rowguid da tabela HumanResources.Employee
ALTER INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee] REORGANIZE;
GO

-- Rebuild no índice AK_Employee_rowguid da tabela HumanResources.Employee
ALTER INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee] REBUILD;
GO