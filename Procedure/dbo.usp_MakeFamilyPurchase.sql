CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    -- Проверка существования семьи
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        raiserror('Такой семьи не существует.', 16, 1);
        RETURN;
    END;

    -- Обновление данных в таблице dbo.Family
    UPDATE f
    SET BudgetValue = BudgetValue - b.TotalPurchaseValue
    FROM dbo.Family f
    INNER JOIN (
        SELECT ID_Family, SUM(Value) AS TotalPurchaseValue
        FROM dbo.Basket
        WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName)
        GROUP BY ID_Family
    ) b ON f.ID = b.ID_Family;
END;