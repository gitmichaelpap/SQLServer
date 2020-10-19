-- LISTA BÁSICA DE PERFORMANCE
-- SCRIPT TESTADO PARA SQL SERVER 2019
--------------------------------------

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

-- Retorna as 50 consultas mais pesadas por tempo total de execução
SELECT TOP 50 qs.max_elapsed_time, qs.min_elapsed_time,
((qs.total_elapsed_time)/execution_count) as avg_elapsed_time,
last_execution_time, execution_count, 
((total_elapsed_time/1000)/1000) as total_elapsed_time_segundos, 
SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY qs.total_elapsed_time DESC;

-- Retorna as 50 consultas mais pesadas por I/O
select top 50 
    last_logical_reads,
    last_logical_writes,
    last_physical_reads,
    Execution_count, 
    last_execution_time, 
    st.text
from sys.dm_exec_query_stats  
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st
order by 
 (last_logical_reads + last_logical_writes) Desc;

-- Retorna as 50 consultas com maior qtde de recompilação
SELECT TOP 50 qs.plan_generation_num, last_execution_time, execution_count, 
SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY qs.plan_generation_num DESC;

-- Identifica locks ativos na base
select sp.dbid, st.text, sp.spid, sp.waittime, sp.cpu, sp.memusage, sp.last_batch, sp.status
from sys.sysprocesses sp 
CROSS APPLY sys.dm_exec_sql_text(sp.sql_handle) AS st
where sp.blocked <> 0 

-- Identifica os wait_types com maior tempo de espera
-- Consulte o site abaixo para saber mais sobre os principais wait_types listados pela consulta
-- http://msdn.microsoft.com/en-us/library/ms179984.aspx
WITH Waits AS
(SELECT wait_type, wait_time_ms / 1000. AS wait_time_s,
100. * wait_time_ms / SUM(wait_time_ms) OVER() AS pct,
ROW_NUMBER() OVER(ORDER BY wait_time_ms DESC) AS rn
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ('CLR_SEMAPHORE','LAZYWRITER_SLEEP','RESOURCE_QUEUE','SLEEP_TASK'
,'SLEEP_SYSTEMTASK','SQLTRACE_BUFFER_FLUSH','WAITFOR', 'LOGMGR_QUEUE','CHECKPOINT_QUEUE'
,'REQUEST_FOR_DEADLOCK_SEARCH','XE_TIMER_EVENT','BROKER_TO_FLUSH','BROKER_TASK_STOP','CLR_MANUAL_EVENT'
,'CLR_AUTO_EVENT','DISPATCHER_QUEUE_SEMAPHORE', 'FT_IFTS_SCHEDULER_IDLE_WAIT'
,'XE_DISPATCHER_WAIT', 'XE_DISPATCHER_JOIN', 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP'))
SELECT W1.wait_type,
CAST(W1.wait_time_s AS DECIMAL(12, 2)) AS wait_time_s,
CAST(W1.pct AS DECIMAL(12, 2)) AS pct,
CAST(SUM(W2.pct) AS DECIMAL(12, 2)) AS running_pct
FROM Waits AS W1
INNER JOIN Waits AS W2
ON W2.rn <= W1.rn
GROUP BY W1.rn, W1.wait_type, W1.wait_time_s, W1.pct
HAVING SUM(W2.pct) - W1.pct < 99 OPTION (RECOMPILE); -- percentage threshold

-- Lista a fila de processamento por CPU
SELECT scheduler_id, current_tasks_count, runnable_tasks_count FROM sys.dm_os_schedulers WHERE scheduler_id < 255;

-- Lista a fila de I/O
select 
    database_id, 
    file_id, 
    io_stall,
    io_pending_ms_ticks,
    scheduler_address 
from	sys.dm_io_virtual_file_stats(NULL, NULL)t1,
        sys.dm_io_pending_io_requests as t2
where	t1.file_handle = t2.io_handle

-- Retorna o I/O cumulativo por database_id
WITH Agg_IO_Stats
AS
(
  SELECT
    DB_NAME(database_id) AS database_name,
    CAST(SUM(num_of_bytes_read + num_of_bytes_written) / 1048576 / 1024.
         AS DECIMAL(12, 2)) AS io_in_gb
  FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS DM_IO_Stats
  GROUP BY database_id
),
Rank_IO_Stats
AS
(
  SELECT
    ROW_NUMBER() OVER(ORDER BY io_in_gb DESC) AS row_num,
    database_name,
    io_in_gb,
    CAST(io_in_gb / SUM(io_in_gb) OVER() * 100
         AS DECIMAL(5, 2)) AS pct
  FROM Agg_IO_Stats
)
SELECT R1.row_num, R1.database_name, R1.io_in_gb, R1.pct,
  SUM(R2.pct) AS run_pct
FROM Rank_IO_Stats AS R1
  JOIN Rank_IO_Stats AS R2
    ON R2.row_num <= R1.row_num
GROUP BY R1.row_num, R1.database_name, R1.io_in_gb, R1.pct
ORDER BY R1.row_num;

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

-- Identifica os 50 índices com maior quantidade de manutenções
-- A coluna user_updates indica a quantidade de manutenções realizadas no índice após updates, inserts ou deletes
-- Se o índice realizar várias manutenções e poucos seeks ou scans, ele é um candidato a ser removido
SELECT TOP(50) DB_NAME(Database_ID) DBName,
SCHEMA_NAME(schema_id) AS SchemaName,
OBJECT_NAME(ius.OBJECT_ID) ObjName,
i.type_desc, i.name,
user_seeks, user_scans,
user_lookups, user_updates
FROM sys.dm_db_index_usage_stats ius
INNER JOIN sys.indexes i
ON i.index_id = ius.index_id
AND ius.OBJECT_ID = i.OBJECT_ID
INNER JOIN sys.tables t ON t.OBJECT_ID = i.OBJECT_ID
ORDER BY user_updates DESC;

-- Retorna os novos candidados a criação de índices 
-- Analise a quantidade de user_seeks, user_scans e as datas de última utilização antes de criar o objeto.
-- Para converter a informação retornada pela view sys.dm_db_missing_index_details em CREATE INDEX você deve
-- utilizar o valor da coluna equality columns antes da inequality columns. Juntas elas formarão a chave do índice. 
-- O valor da coluna included_columns deve ser utilizado na clausula INCLUDE do CREATE INDEX.
-- Para determinar a efetividade da ordem das colunas na equality columns, coloque as colunas com maior seletividade a esquerda.
SELECT
	statement AS [database.scheme.table],
	equality_columns, inequality_columns, included_columns, 
	migs.user_seeks, migs.user_scans,
	migs.last_user_seek, migs.avg_total_user_cost,
	migs.avg_user_impact	
FROM sys.dm_db_missing_index_details AS mid
INNER JOIN sys.dm_db_missing_index_groups AS mig ON mig.index_handle = mid.index_handle
INNER JOIN sys.dm_db_missing_index_group_stats  AS migs ON mig.index_group_handle=migs.group_handle
ORDER BY user_seeks DESC, user_scans DESC, avg_user_impact DESC;

-- Verifica a data de atualização das estatísticas de todos os índices
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

-- Visualiza o percentual de fragmentação dos índices
SELECT ps.database_id, ps.OBJECT_ID,
ps.index_id, b.name,
ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS ps
INNER JOIN sys.indexes AS b ON ps.OBJECT_ID = b.OBJECT_ID
AND ps.index_id = b.index_id
WHERE ps.database_id = DB_ID()
ORDER BY ps.avg_fragmentation_in_percent DESC, ps.OBJECT_ID;
GO
	
-- Retorna o tempo gasto com recompilacoes
select * from sys.dm_exec_query_optimizer_info
	
-- Aumento repentino dos valores das colunas rounds_count e removed_all_rounds_count podem indicar problemas memória
select * from sys.dm_os_memory_cache_clock_hands where rounds_count > 0 and removed_all_rounds_count > 0;

-- Retorna estatísticas do I/O latch. Atenção caso os valores de waiting_task_counts e wait_time_ms aumentarem muito.
Select  wait_type, 
        waiting_tasks_count, 
        wait_time_ms
from	sys.dm_os_wait_stats  
where	wait_type like 'PAGEIOLATCH%'  
order by wait_type
