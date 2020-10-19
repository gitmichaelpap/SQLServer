-- Insere uma nova moeda para testes de replicação
INSERT INTO SALES.CURRENCY (CurrencyCode, Name, ModifiedDate) VALUES ('ABC', 'TESTE REPLICAÇÃO', GETDATE());

-- Verificação
SELECT * FROM Sales.Currency WHERE CurrencyCode = 'ABC'

-- Limpeza
DELETE FROM Sales.Currency WHERE CurrencyCode = 'ABC'