-- Insere uma nova moeda para testes de Log Shipping
INSERT INTO SALES.CURRENCY (CurrencyCode, Name, ModifiedDate) VALUES ('DEF', 'TESTE LOGSHIPPING', GETDATE());

-- Verifica��o
SELECT * FROM Sales.Currency WHERE CurrencyCode = 'DEF'

-- Limpeza
DELETE FROM Sales.Currency WHERE CurrencyCode = 'DEF'