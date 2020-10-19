USE AdventureWorks2017;
GO

-- Cria um tipo de dados chamado ENDERECO
CREATE TYPE ENDERECO FROM VARCHAR(200) NOT NULL;
GO

-- Utiliza o novo tipo de dados ENDERECO em uma vari�vel
DECLARE @RUA ENDERECO;
SET @RUA = 'Avenida Brasil';
PRINT @RUA

-- Declara uma vari�vel com o tipo de dados de sistema INT
DECLARE @NUMERO INT;
SET @NUMERO = 1500;
GO 

-- Deleta o novo tipo de dados ENDERECO
DROP TYPE ENDERECO;
GO