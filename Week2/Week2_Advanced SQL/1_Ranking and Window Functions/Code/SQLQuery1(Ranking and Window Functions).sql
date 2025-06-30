USE tempdb;
GO

-- Drop the table if it already exists
IF OBJECT_ID('Products', 'U') IS NOT NULL
    DROP TABLE Products;
GO

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10, 2)
);
GO

-- Insert sample data
INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'iPhone', 'Mobiles', 1000.00),
(2, 'Samsung Galaxy', 'Mobiles', 900.00),
(3, 'OnePlus', 'Mobiles', 900.00),
(4, 'Motorola', 'Mobiles', 600.00),
(5, 'Redmi', 'Mobiles', 400.00),
(6, 'Dell Laptop', 'Laptops', 1200.00),
(7, 'HP Laptop', 'Laptops', 1100.00),
(8, 'Asus Laptop', 'Laptops', 1100.00),
(9, 'Lenovo Laptop', 'Laptops', 950.00),
(10, 'Acer Laptop', 'Laptops', 850.00);
GO

SELECT 
    ProductID,
    ProductName,
    Category,
    Price,
    ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
FROM Products;

WITH Ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
    FROM Products
)
SELECT *
FROM Ranked
WHERE RowNum <= 3;

SELECT 
    ProductID,
    ProductName,
    Category,
    Price,
    RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS RankNum
FROM Products;

SELECT 
    ProductID,
    ProductName,
    Category,
    Price,
    DENSE_RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS DenseRankNum
FROM Products;
