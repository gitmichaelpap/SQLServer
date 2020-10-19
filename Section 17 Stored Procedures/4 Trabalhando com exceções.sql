-- Exemplo 1: bloco TRY...CATCH disparando o catch
BEGIN TRY
	-- Gera uma divisão por zero
	DECLARE @DIVISAO INT = (1/0);
	PRINT 'Note que não entrou no TRY, pois esse print não foi exibido.';
END TRY
BEGIN CATCH
	-- Executa uma rotina de recuperação do erro
	SELECT  
        ERROR_NUMBER() AS ErrorNumber,  
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure,  
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage; 
END CATCH;
GO

-- Exemplo 2: bloco TRY...CATCH sem disparar o catch
BEGIN TRY
	-- Gera uma divisão normal
	DECLARE @DIVISAO INT = (1/1);
	PRINT 'Note que agora entrou no TRY, pois esse print foi exibido.';
END TRY
BEGIN CATCH	
	PRINT 'Note que agora não entrou no CATH, pois esse print não foi exibido.';
END CATCH;
GO