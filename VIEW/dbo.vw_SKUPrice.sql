CREATE VIEW vw_SKUPrice
AS
SELECT 
    SKU.*,
    ComputeCosts(SKU.ID) AS ProductCost
FROM 
    SKU;