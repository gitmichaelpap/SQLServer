-- Cria uma tabela chamada TabelaTeste com três colunas
CREATE TABLE [dbo].[TabelaTeste](
	[Codigo] [int] NOT NULL,
	[Descricao] [nvarchar](60) NOT NULL,
	[Observacoes] [nvarchar](max) NULL
)
GO

-- Atualize o Object Explorer
-- Gere o script da tabela criada
-- Crie uma tabela pelo SSMS

-- Deleta a tabela Teste
DROP TABLE [dbo].[TabelaTeste];
GO

