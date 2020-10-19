-- Cria uma trigger que impede o delete na tabela Person.Person
CREATE TRIGGER dPerson ON [Person].[Person] 
INSTEAD OF DELETE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN
        RAISERROR
            (N'Não é permitido deletar uma pessoa.', -- Message
            10, -- Severity.
            1); -- State.
       
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    END;
END;
GO

-- Tenta deletar uma pessoa
DELETE FROM Person.Person WHERE BusinessEntityID = 1;
GO

-- Deleta a trigger criada
DROP TRIGGER [Person].[dPerson]
GO