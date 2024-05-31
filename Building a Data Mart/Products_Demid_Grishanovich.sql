-- Creating FactProductSales table with references to date and product dimensions
CREATE TABLE FactProductSales (
                                  FactSalesID SERIAL PRIMARY KEY,
                                  SaleDateID INT,
                                  ProductID INT,
                                  UnitsSold INT,
                                  Revenue DECIMAL(10, 2),
                                  FOREIGN KEY (SaleDateID) REFERENCES DimDate(DateID),
                                  FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID)
);

-- Inserting data into FactProductSales by selecting from staging tables
INSERT INTO FactProductSales (SaleDateID, ProductID, UnitsSold, Revenue)
SELECT
    (SELECT DateID FROM DimDate WHERE Date = s.OrderDate) AS SaleDateID,
    p.ProductID,
    sod.Quantity,
    (sod.Quantity * sod.UnitPrice) AS Revenue
FROM staging_order_details sod
    JOIN staging_orders s ON sod.OrderID = s.OrderID
    JOIN staging_products p ON sod.ProductID = p.ProductID;

-- Top five products by total sales revenue
SELECT
    dp.ProductName,
    SUM(fps.UnitsSold) AS TotalUnitsSold,
    SUM(fps.Revenue) AS TotalRevenue
FROM
    FactProductSales fps
        JOIN DimProduct dp ON fps.ProductID = dp.ProductID
GROUP BY dp.ProductName
ORDER BY TotalRevenue DESC
    LIMIT 5;

-- Products that are below reorder level
SELECT
    dp.ProductName,
    dp.UnitsInStock,
    dp.ReorderLevel
FROM
    DimProduct dp
WHERE
        dp.UnitsInStock < dp.ReorderLevel;

-- Sales trends analyzed by product category and month
SELECT
    dc.CategoryName,
    EXTRACT(YEAR FROM dd.Date) AS Year,
    EXTRACT(MONTH FROM dd.Date) AS Month,
    SUM(fps.UnitsSold) AS TotalUnitsSold,
    SUM(fps.Revenue) AS TotalRevenue
FROM
    FactProductSales fps
    JOIN DimProduct dp ON fps.ProductID = dp.ProductID
    JOIN DimCategory dc ON dp.CategoryID = dc.CategoryID
    JOIN DimDate dd ON fps.SaleDateID = dd.DateID
GROUP BY dc.CategoryName, Year, Month, dd.Date
ORDER BY Year, Month, TotalRevenue DESC;

-- Inventory valuation report
SELECT
    dp.ProductName,
    dp.UnitsInStock,
    dp.UnitPrice,
    (dp.UnitsInStock * dp.UnitPrice) AS InventoryValue
FROM
    DimProduct dp
ORDER BY InventoryValue DESC;

-- Evaluating supplier performance based on product sales
SELECT
    ds.CompanyName,
    COUNT(DISTINCT fps.FactSalesID) AS NumberOfSales,
    SUM(fps.UnitsSold) AS TotalUnitsSold,
    SUM(fps.Revenue) AS TotalRevenue
FROM
    FactProductSales fps
        JOIN DimProduct dp ON fps.ProductID = dp.ProductID
        JOIN DimSupplier ds ON dp.SupplierID = ds.SupplierID
GROUP BY ds.CompanyName
ORDER BY TotalRevenue DESC;