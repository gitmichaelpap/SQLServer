-- Configura��o do Resource Governor
BEGIN TRAN
USE Master;

-- Cria um resource pool que determina utiliza��o m�xima de 10% de CPU
CREATE RESOURCE POOL pMAX_CPU_PERCENT_10 WITH (MAX_CPU_PERCENT = 10)
GO

-- Cria um workload group para usar o resource pool criado acima
CREATE WORKLOAD GROUP gMAX_CPU_PERCENT_10 USING pMAX_CPU_PERCENT_10
GO

-- Cria uma fun��o de classifica��o que se aplica apenas �s requisi��es feitas pelo usu�rio sa
-- Note que qualquer requisi��o que n�o se enquadrar nessa fun��o ser� redirecionada para o grupo default
CREATE FUNCTION rgclassifier_MAX_CPU() RETURNS SYSNAME 
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @workload_group_name AS SYSNAME
    IF (SUSER_NAME() = 'sa')
		SET @workload_group_name = 'gMAX_CPU_PERCENT_10';
    RETURN @workload_group_name
END;
GO

-- Registra a fun��o de classifica��o no Resource Governor
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION= dbo.rgclassifier_MAX_CPU);
COMMIT TRAN;
GO

-- Inicia o Resource Governor
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO

-- Logado como sa execute um script pesado que roda por 2min e consome muitos recursos
USE AdventureWorks2017

-- Basicamente ele altera o nome de categorias de produtos dentro de uma transa��o e aplica o rollback logo em seguida
DECLARE @startTime datetime
SET @startTime = Getdate()

WHILE datediff(second, @startTime, getdate()) < 120
BEGIN
	BEGIN TRANSACTION

	UPDATE Production.Product
	SET ListPrice = ListPrice * 1.1

	UPDATE Production.ProductCategory
	SET [Name] = [Name] + ' - Testing' 

	ROLLBACK TRANSACTION

	BEGIN TRANSACTION
	EXECUTE HumanResources.uspUpdateEmployeeHireInfo 
	   1
	  ,'Product Manager'
	  ,@startTime
	  ,@startTime
	  ,10.00
	  ,1
	  ,1
	ROLLBACK TRANSACTION
END

-- Deleta a configura��o do Resource Governor
USE master;
DROP WORKLOAD GROUP gMAX_CPU_PERCENT_10;
DROP RESOURCE POOL pMAX_CPU_PERCENT_10;
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
ALTER RESOURCE GOVERNOR RECONFIGURE;
DROP FUNCTION rgclassifier_MAX_CPU;
GO