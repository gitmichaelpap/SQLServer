-- Declara uma variável XML
DECLARE @COMMAND XML;
SET @COMMAND = '<Address><Country></Country><Country Name="Brasil"></Country><Country Name="USA"></Country><Country Name="Argentina"></Country></Address>';

-- Consulta todos os nós de /Address/Country
SELECT @COMMAND.query('/Address/Country');

-- Consulta todos os nós de /Address/Country que possuam um atributo @Name
SELECT @COMMAND.query('/Address/Country[@Name]');

-- Consulta todos os nós de /Address/Country que possuam um atributo @Name igual a Brasil
SELECT @COMMAND.query('/Address/Country[@Name = "Brasil"]');