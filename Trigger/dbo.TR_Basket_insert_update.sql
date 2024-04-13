CREATE TRIGGER trg_CalculateDiscount
ON Basket
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ID_SKU INT;

    -- Получаем ID_SKU из добавленных записей
    SELECT @ID_SKU = ID_SKU
    FROM inserted;

    -- Проверяем количество добавленных записей для данного ID_SKU
    DECLARE @ItemCount INT;
    SELECT @ItemCount = COUNT(*)
    FROM Basket
    WHERE ID_SKU = @ID_SKU;

    -- Рассчитываем скидку и обновляем DiscountValue
    UPDATE Basket
    SET DiscountValue = CASE 
                            WHEN @ItemCount >= 2 THEN Value * 0.05
                            ELSE 0
                        END
    WHERE ID_SKU = @ID_SKU;
END;