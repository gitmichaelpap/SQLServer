-- System Catalog Views
SELECT name, object_id, type_desc 
FROM sys.tables;

-- Information Schema (padrão ISO)
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'Product'

-- DMVs
SELECT cpu_count, sqlserver_start_time
FROM sys.dm_os_sys_info

-- System Stored Procedures
EXEC sp_columns @table_name = N'Department', 
@table_owner = N'HumanResources'

-- System Functions
SELECT COLUMNPROPERTY(OBJECT_ID('Person.Person'), 'LastName', 'PRECISION') AS 'Column Length'
