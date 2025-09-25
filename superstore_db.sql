-- Create database
IF DB_ID('Superstore_DB') IS NULL
BEGIN
    CREATE DATABASE Superstore_DB;
END
GO
USE Superstore_DB;
GO

CREATE TABLE Superstore_Orders (
    [Row ID] INT,
    [Order ID] INT,
    [Order Date] DATE,
    [Order Priority] VARCHAR(50),
    [Order Quantity] INT,
    [Sales] DECIMAL(18,4),
    [Discount] DECIMAL(10,4),
    [Ship Mode] VARCHAR(50),
    [Profit] DECIMAL(18,4),
    [Unit Price] DECIMAL(18,4),
    [Shipping Cost] DECIMAL(18,4),
    [Customer Name] VARCHAR(100),
    [Province] VARCHAR(100),
    [Region] VARCHAR(100),
    [Customer Segment] VARCHAR(100),
    [Product Category] VARCHAR(100),
    [Product Sub-Category] VARCHAR(100),
    [Product Name] VARCHAR(255),
    [Product Container] VARCHAR(100),
    [Product Base Margin] DECIMAL(10,4),
    [Ship Date] DATE
);
GO

BULK INSERT Superstore_Orders
FROM 'C:\Users\BUYPC COMPUTERS\OneDrive\Documents\Superstore Database.csv' --  actual file path on computer
WITH (
    FIRSTROW = 2, -- skip header
    FIELDTERMINATOR = ',', -- comma-separated
    ROWTERMINATOR = '\n',  -- new line ends row
    TABLOCK,
    CODEPAGE = 'ACP' -- handles special characters like ©, ®, etc.
);

SELECT TOP 10 * FROM Superstore_Orders;
