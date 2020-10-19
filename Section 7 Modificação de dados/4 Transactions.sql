-- TRAN É IGUAL A TRANSACTION
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

-- Hands-on de níveis de isolamento
-- JANELA 1:
BEGIN TRAN T2
UPDATE Sales.SalesPerson SET Bonus = 6000;

-- JANELA 2
SELECT MAX(BONUS) FROM Sales.SalesPerson --note que essa consulta não termina nunca

-- JANELA 1
ROLLBACK TRAN T2

-- JANELA 2: note que agora, depois do rollback, a consulta foi executada

----------------------------------------------------------------------------------------

-- Refaça o teste acima e antes de executar o select da janela 2, mude o nível de isolamento
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO
SELECT MAX(BONUS) FROM Sales.SalesPerson --note que essa consulta será executada mesmo com a transação aberta!

----------------------------------------------------------------------------------------

-- Hands-on de transações aninhadas
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
