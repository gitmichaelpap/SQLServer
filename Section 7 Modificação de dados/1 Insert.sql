-- Insert simples
INSERT INTO Production.UnitMeasure (UnitMeasureCode, Name, ModifiedDate) VALUES (N'F2', N'Square Feet', GETDATE());

-- Insert de múltiplas linhas
INSERT INTO Production.UnitMeasure 
VALUES (N'F3', N'Square Feet 3', GETDATE()), 
       (N'Y2', N'Square Yards', GETDATE());

--select * from Production.UnitMeasure order by ModifiedDate desc

-- Insert com output
DECLARE @MyTable table (ScrapResonID smallint, Name varchar(50), ModifiedDate datetime);

INSERT INTO Production.ScrapReason 
OUTPUT INSERTED.ScrapReasonID, INSERTED.Name, INSERTED.ModifiedDate INTO @MyTable
VALUES (N'Operator Error', GETDATE());

-- Insert com Identity
CREATE TABLE dbo.T1 (
column_1 int IDENTITY, 
column_2 VARCHAR(30)
)
GO

INSERT dbo.T1 VALUES ('Row #1');
INSERT dbo.T1 (column_2) VALUES ('Row #2');
GO

SET IDENTITY_INSERT dbo.T1 OFF;
GO

INSERT INTO dbo.T1 (column_1, column_2) VALUES (-99, 'Explicity Identity');

SELECT column_1, column_2 FROM dbo.T1;
