-- Consulta dinâmica com sp_executesql
DECLARE @IntVariable int;  
DECLARE @SQLString nvarchar(500);  
DECLARE @ParmDefinition nvarchar(500);  
  
/* Build the SQL string one time.*/  
SET @SQLString =  
     N'SELECT BusinessEntityID, NationalIDNumber, JobTitle, LoginID  
       FROM HumanResources.Employee   
       WHERE BusinessEntityID = @BusinessEntityID';  
SET @ParmDefinition = N'@BusinessEntityID tinyint';  

/* Execute the string with the first parameter value. */  
SET @IntVariable = 197;  
EXECUTE sp_executesql @SQLString, @ParmDefinition,  
                      @BusinessEntityID = @IntVariable; 
GO

/*SELECT BusinessEntityID, NationalIDNumber, JobTitle, LoginID  
       FROM HumanResources.Employee   
       WHERE BusinessEntityID = 197*/

-- Consulta dinâmica com EXECUTE
DECLARE @IntVariable int;  
DECLARE @SQLString nvarchar(500);   

SET @IntVariable = 197;

SET @SQLString =  
     N'SELECT BusinessEntityID, NationalIDNumber, JobTitle, LoginID  
       FROM HumanResources.Employee   
       WHERE BusinessEntityID = ' + CAST(@IntVariable AS NVARCHAR(10));  
  
EXECUTE (@SQLString);

