-- Creating FactSupplierPurchases table
CREATE TABLE FactSupplierPurchases (
                                       PurchaseID SERIAL PRIMARY KEY,
                                       SupplierID INT,
                                       TotalPurchase DECIMAL,
                                       PurchaseDate DATE,
                                       ProductCount INT,
                                       FOREIGN KEY (SupplierID) REFERENCES DimSupplier(SupplierID)
);

-- Aggregating data from staging tables and inserting into FactSupplierPurchases
INSERT INTO FactSupplierPurchases (SupplierID, TotalPurchase, PurchaseDate, ProductCount)
SELECT
    p.SupplierID,
    SUM(od.UnitPrice * od.Quantity) AS TotalPurchase,
    CURRENT_DATE AS PurchaseDate,
    COUNT(DISTINCT od.ProductID) AS ProductCount
FROM staging_order_details od
         JOIN staging_products p ON od.ProductID = p.ProductID
GROUP BY p.SupplierID;


-- Supplier performance report
SELECT
    ds.CompanyName,
    AVG(fsp.DeliveryTime) AS AverageLeadTime,
    SUM(fsp.OrderAccuracy) / COUNT(fsp.PurchaseID) AS AverageOrderAccuracy,
    COUNT(fsp.PurchaseID) AS TotalOrders
FROM FactSupplierPurchases fsp
         JOIN DimSupplier ds ON fsp.SupplierID = ds.SupplierID
GROUP BY ds.CompanyName
ORDER BY AverageLeadTime, AverageOrderAccuracy DESC;

-- Supplier spending analysis report
SELECT
    ds.CompanyName,
    SUM(fsp.TotalPurchase) AS TotalSpend,
    EXTRACT(YEAR FROM fsp.PurchaseDate) AS Year,
    EXTRACT(MONTH FROM fsp.PurchaseDate) AS Month
FROM FactSupplierPurchases fsp
    JOIN DimSupplier ds ON fsp.SupplierID = ds.SupplierID
GROUP BY ds.CompanyName, Year, Month
ORDER BY TotalSpend DESC;

-- Product cost breakdown by supplier
SELECT
    ds.CompanyName,
    dp.ProductName,
    AVG(od.UnitPrice) AS AverageUnitPrice,
    SUM(od.Quantity) AS TotalQuantityPurchased,
    SUM(od.UnitPrice * od.Quantity) AS TotalSpend
FROM staging_order_details od
         JOIN staging_products dp ON od.ProductID = dp.ProductID
         JOIN DimSupplier ds ON dp.SupplierID = ds.SupplierID
GROUP BY ds.CompanyName, dp.ProductName
ORDER BY ds.CompanyName, TotalSpend DESC;

-- Supplier reliability score report
SELECT
    ds.CompanyName,
    (COUNT(fsp.PurchaseID) FILTER (WHERE fsp.OnTimeDelivery = TRUE) / COUNT(fsp.PurchaseID)::FLOAT) * 100 AS ReliabilityScore
FROM FactSupplierPurchases fsp
         JOIN DimSupplier ds ON fsp.SupplierID = ds.SupplierID
GROUP BY ds.CompanyName
ORDER BY ReliabilityScore DESC;

-- Top five products by total purchases per supplier
SELECT
    ds.CompanyName,
    dp.ProductName,
    SUM(od.UnitPrice * od.Quantity) AS TotalSpend
FROM staging_order_details od
         JOIN staging_products dp ON od.ProductID = dp.ProductID
         JOIN DimSupplier ds ON dp.SupplierID = ds.SupplierID
GROUP BY ds.CompanyName, dp.ProductName
ORDER BY ds.CompanyName, TotalSpend DESC
    LIMIT 5;