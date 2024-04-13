CREATE FUNCTION ComputeCosts (@ID_SKU INT)
RETURNS decimal(18, 2)
BEGIN
	DECLARE @cost DEC (18,2)
    SELECT @cost = SUM(Value) / NULLIF(SUM(Quantity), 0)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;
    RETURN @cost;
END;