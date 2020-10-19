-- Exibe o tempo de espera e o tipo 
SELECT wait_type, wait_time_ms FROM sys.dm_os_wait_stats

-- Exibe os locks correntes
SELECT * FROM sys.dm_tran_locks

-- Retorna as 50 consultas mais pesadas por tempo de cpu
SELECT TOP 50 max_worker_time, min_worker_time,  
((qs.total_worker_time)/execution_count) as avg_worker_time,
last_execution_time, execution_count, 
((total_worker_time/1000)/1000) as total_worker_time_segundos, 
SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY qs.total_worker_time DESC;

-- Identifica locks ativos na base
select sp.dbid, st.text, sp.spid, sp.waittime, sp.cpu, sp.memusage, sp.last_batch, sp.status
from sys.sysprocesses sp 
CROSS APPLY sys.dm_exec_sql_text(sp.sql_handle) AS st
where sp.blocked <> 0 

-- Lista a fila de processamento por CPU
SELECT scheduler_id, current_tasks_count, runnable_tasks_count FROM sys.dm_os_schedulers WHERE scheduler_id < 255;

-- Retorna estatísticas de I/O dos arquivos de dados
SELECT DB_NAME(vfs.DbId) DatabaseName, mf.name,
mf.physical_name, vfs.BytesRead, vfs.BytesWritten,
vfs.IoStallMS, vfs.IoStallReadMS, vfs.IoStallWriteMS,
vfs.NumberReads, vfs.NumberWrites,
(Size*8)/1024 Size_MB
FROM ::fn_virtualfilestats(NULL,NULL) vfs
INNER JOIN sys.master_files mf ON mf.database_id = vfs.DbId
AND mf.FILE_ID = vfs.FileId
ORDER BY BytesRead DESC, BytesWritten DESC;

-- Verifica a data de atualização das estatísticas de todos os objetos
SELECT name AS index_name, STATS_DATE(OBJECT_ID, index_id) AS StatsUpdated FROM sys.indexes ORDER BY 2 DESC;

-- Retorna informações sobre a memória disponível no sistema
select 
	total_physical_memory_kb / 1024 as phys_mem_mb,
	available_physical_memory_kb / 1024 as avail_phys_mem_mb,
	system_cache_kb /1024 as sys_cache_mb,
	(kernel_paged_pool_kb+kernel_nonpaged_pool_kb) / 1024 
		as kernel_pool_mb,
	total_page_file_kb / 1024 as total_page_file_mb,
	available_page_file_kb / 1024 as available_page_file_mb,
	system_memory_state_desc
from sys.dm_os_sys_memory