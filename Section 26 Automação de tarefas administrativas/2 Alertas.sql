-- Dispara um erro com severidade 19 para testar o alerta criado
RAISERROR (50005, -- Message id.
       19, -- Severity,
       1, -- State,
       N'Fatal error') WITH LOG;