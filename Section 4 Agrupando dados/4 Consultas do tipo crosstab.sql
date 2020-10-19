-- Dados originais
SELECT DaysToManufacture, AVG(StandardCost) AS AverageCost   
FROM Production.Product  
GROUP BY DaysToManufacture;  

-- Aplicando o pivot
SELECT 'AverageCost' AS Cost_Sorted_By_Production_Days,   
[0], [1], [2], [3], [4]  
FROM  
(SELECT DaysToManufacture, StandardCost   
    FROM Production.Product) AS SourceTable  
PIVOT  
(  
AVG(StandardCost)  
FOR DaysToManufacture IN ([0], [1], [2], [3], [4])  
) AS PivotTable;  