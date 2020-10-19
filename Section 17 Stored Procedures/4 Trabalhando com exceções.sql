-- Exemplo 1: bloco TRY...CATCH disparando o catch
BEGIN TRY
	-- Gera uma divis�o por zero
	DECLARE @DIVISAO INT = (1/0);
	PRINT 'Note que n�o entrou no TRY, pois esse print n�o foi exibido.';
END TRY
BEGIN CATCH
	-- Executa uma rotina de recupera��o do erro
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
	-- Gera uma divis�o normal
	DECLARE @DIVISAO INT = (1/1);
	PRINT 'Note que agora entrou no TRY, pois esse print foi exibido.';
END TRY
BEGIN CATCH	
	PRINT 'Note que agora n�o entrou no CATH, pois esse print n�o foi exibido.';
END CATCH;
GO