-- Cria uma tabela com um campo do tipo de dados hierarchyid
-- DROP TABLE HumanResources.EmployeeOrg  
CREATE TABLE HumanResources.EmployeeOrg  
(  
   OrgNode hierarchyid PRIMARY KEY CLUSTERED,  
   OrgLevel AS OrgNode.GetLevel(),  
   EmployeeID int UNIQUE NOT NULL,  
   EmpName varchar(20) NOT NULL,  
   Title varchar(20) NULL  
) ;  
GO

-- Cria um �ndice Depth-first, em que as linhas de uma sub�rvore s�o armazenadas pr�ximas umas das outras;
CREATE UNIQUE INDEX EmployeeOrgNc1_Depth_First   
ON HumanResources.EmployeeOrg(OrgLevel, OrgNode) ;  
GO

-- Insere os dados do gerente (note que a coluna Level n�o � informada e a coluna Node � definada com o valor do m�todo getRoot())
INSERT HumanResources.EmployeeOrg (OrgNode, EmployeeID, EmpName, Title)  
VALUES (hierarchyid::GetRoot(), 6, 'David', 'Marketing Manager') ;  
GO

-- Consulta dados da tabela. Observe que o valor do Node � chamado por meio da fun��o ToString()
SELECT OrgNode.ToString() AS Text_OrgNode,   
OrgNode, OrgLevel, EmployeeID, EmpName, Title   
FROM HumanResources.EmployeeOrg ; 

-- Insere a funcion�ria Sariya que � do time do gestor David
DECLARE @Manager hierarchyid   
SELECT @Manager = hierarchyid::GetRoot()  
FROM HumanResources.EmployeeOrg ;  

INSERT HumanResources.EmployeeOrg (OrgNode, EmployeeID, EmpName, Title)  
VALUES  
(@Manager.GetDescendant(NULL, NULL), 46, 'Sariya', 'Marketing Specialist') ; 
GO

-- DROP PROCEDURE AddEmp
CREATE PROC AddEmp(@mgrid int, @empid int, @e_name varchar(20), @title varchar(20))   
AS   
BEGIN  
   DECLARE @mOrgNode hierarchyid, @lc hierarchyid  
   SELECT @mOrgNode = OrgNode   
   FROM HumanResources.EmployeeOrg   
   WHERE EmployeeID = @mgrid  
   SET TRANSACTION ISOLATION LEVEL SERIALIZABLE  
   BEGIN TRANSACTION  
      SELECT @lc = max(OrgNode)   
      FROM HumanResources.EmployeeOrg   
      WHERE OrgNode.GetAncestor(1) =@mOrgNode ;  

      INSERT HumanResources.EmployeeOrg (OrgNode, EmployeeID, EmpName, Title)  
      VALUES(@mOrgNode.GetDescendant(@lc, NULL), @empid, @e_name, @title)  
   COMMIT  
END ;  
GO

-- Insere os demais funcion�rios
EXEC AddEmp 6, 271, 'John', 'Marketing Specialist' ;  
EXEC AddEmp 6, 119, 'Jill', 'Marketing Specialist' ;  
EXEC AddEmp 46, 269, 'Wanida', 'Marketing Assistant' ;  
EXEC AddEmp 271, 272, 'Mary', 'Marketing Assistant' ; 


-- Consulta novamente dados da tabela
SELECT OrgNode.ToString() AS Text_OrgNode,   
OrgNode, OrgLevel, EmployeeID, EmpName, Title   
FROM HumanResources.EmployeeOrg 
ORDER BY OrgLevel; 
