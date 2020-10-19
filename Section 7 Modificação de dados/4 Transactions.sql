-- TRAN � IGUAL A TRANSACTION
BEGIN TRAN T1

-- $6700
SELECT MAX(BONUS) FROM Sales.SalesPerson

UPDATE Sales.SalesPerson SET Bonus = 6000;

-- $6000
SELECT MAX(BONUS) FROM Sales.SalesPerson

ROLLBACK TRAN T1

-- $6700
SELECT MAX(BONUS) FROM Sales.SalesPerson

----------------------------------------------------------------------------------------

-- Hands-on de n�veis de isolamento
-- JANELA 1:
BEGIN TRAN T2
UPDATE Sales.SalesPerson SET Bonus = 6000;

-- JANELA 2
SELECT MAX(BONUS) FROM Sales.SalesPerson --note que essa consulta n�o termina nunca

-- JANELA 1
ROLLBACK TRAN T2

-- JANELA 2: note que agora, depois do rollback, a consulta foi executada

----------------------------------------------------------------------------------------

-- Refa�a o teste acima e antes de executar o select da janela 2, mude o n�vel de isolamento
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO
SELECT MAX(BONUS) FROM Sales.SalesPerson --note que essa consulta ser� executada mesmo com a transa��o aberta!

----------------------------------------------------------------------------------------

-- Hands-on de transa��es aninhadas
CREATE TABLE dbo.TestTrans (Cola INT PRIMARY KEY, Colb CHAR(3) NOT NULL);
GO

CREATE PROCEDURE dbo.TransProc @PriKey INT, @CharCol CHAR(3) AS
BEGIN TRAN InProc;
INSERT INTO dbo.TestTrans VALUES (@PriKey, @CharCol);
INSERT INTO dbo.TestTrans VALUES (@PriKey+1, @CharCol);
COMMIT TRAN InProc;
GO

BEGIN TRAN;
EXEC dbo.TransProc 1, 'aaa';
ROLLBACK TRAN;

EXEC dbo.TransProc 3, 'bbb';
GO

SELECT * FROM dbo.TestTrans; -- deve ignorar o aaa e salvar apenas o bbb
