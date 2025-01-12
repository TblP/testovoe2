CREATE TABLE SKU (
    ID INT IDENTITY PRIMARY KEY,
    Code AS ('s' + CAST(ID AS VARCHAR(10))) UNIQUE,
    Name VARCHAR(255)
);

CREATE TABLE Family (
    ID INT IDENTITY PRIMARY KEY,
    SurName VARCHAR(255),
    BudgetValue FLOAT
);

CREATE TABLE Basket (
    ID INT IDENTITY PRIMARY KEY,
    ID_SKU INT,
    ID_Family INT,
    Quantity INT CONSTRAINT CHK_Quantity CHECK (Quantity >= 0),
    Value FLOAT CONSTRAINT CHK_Value CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue FLOAT,
    CONSTRAINT FK_ID_SKU FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU(ID),
    CONSTRAINT FK_ID_Family FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID)
);