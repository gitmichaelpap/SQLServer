-- Consulta simples
SELECT FirstName, LastName, PersonType
FROM Person.Person

-- View para facilitar a chamada � consulta simples acima
CREATE VIEW Person.vPerson
AS
SELECT FirstName, LastName, PersonType
FROM Person.Person
GO

-- Chamada � nova view
SELECT * FROM Person.vPerson

-- Remova��o da view
DROP VIEW Person.vPerson
