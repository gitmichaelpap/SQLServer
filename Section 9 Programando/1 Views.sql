-- Consulta simples
SELECT FirstName, LastName, PersonType
FROM Person.Person

-- View para facilitar a chamada à consulta simples acima
CREATE VIEW Person.vPerson
AS
SELECT FirstName, LastName, PersonType
FROM Person.Person
GO

-- Chamada à nova view
SELECT * FROM Person.vPerson

-- Removação da view
DROP VIEW Person.vPerson
