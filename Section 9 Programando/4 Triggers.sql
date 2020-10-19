-- Trigger que impede o insert na tabela Sales.Currency de modas cujo nome tem menos de 5 caracteres
CREATE TRIGGER Sales.tgrCurrency ON Sales.Currency AFTER INSERT
AS
BEGIN
      DECLARE @NAME NVARCHAR(50);
      SELECT @NAME = Name FROM inserted
      IF LEN(@NAME) < 5
      BEGIN
            ROLLBACK TRANSACTION;
      END;
END;
GO

-- Tenta inserir uma moeda com o nome "Real". Note que vai dar erro, pois "Real" tem menos de 5 caracteres
INSERT INTO Sales.Currency VALUES ('BR1', 'Real', GETDATE());

-- Tenta inserir uma moeda com o nome "Real brasileiro". Note que não vai dar erro, pois "Real brasileiro" tem mais de 5 caracteres
INSERT INTO Sales.Currency VALUES ('BR1', 'Real Brasileiro', GETDATE());
GO

-- Deleta a trigger criada
DROP TRIGGER Sales.tgrCurrency;
GO
