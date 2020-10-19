CREATE TABLE #StoreInfoLocal 
(
EmployeeID int, 
ManagerID int, 
Num int
)

INSERT INTO #StoreInfoLocal (EmployeeID, ManagerID, Num) VALUES (1, 2, 3);

SELECT * FROM #StoreInfoLocal

DROP TABLE #StoreInfoLocal