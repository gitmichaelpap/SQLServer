-- Insere uma nova moeda para testes de replica��o
INSERT INTO SALES.CURRENCY (CurrencyCode, Name, ModifiedDate) VALUES ('ABC', 'TESTE REPLICA��O', GETDATE());

-- Verifica��o
SELECT * FROM Sales.Currency WHERE CurrencyCode = 'ABC'

-- Limpeza
DELETE FROM Sales.Currency WHERE CurrencyCode = 'ABC'