-- Adiciona uma constraint UNIQUE no EmailAddress da tabela Person.EmailAddress
ALTER TABLE Person.EmailAddress ADD CONSTRAINT UQ_Person_EmailAddress_PostalCode UNIQUE NONCLUSTERED
([EmailAddress] ASC);
GO

-- Adiciona uma constraint CHECK no EmailAddress da tabela Person.EmailAddress para verificar se o tamanho do E-mail é maior que 10 caracteres
ALTER TABLE Person.EmailAddress WITH CHECK ADD CONSTRAINT CK_Person_EmailAddress_PostalCode_Len CHECK
(LEN(Rating) > 10);
GO

-- Deleta as constraints criadas acima
ALTER TABLE Person.EmailAddress DROP CONSTRAINT UQ_Person_EmailAddress_PostalCode;
GO

ALTER TABLE Person.EmailAddress DROP CONSTRAINT CK_Person_EmailAddress_PostalCode_Len;
GO