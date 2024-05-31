-- Creating FactCustomerPurchases table with appropriate references
CREATE TABLE FactCustomerPurchases (
    PurchaseID SERIAL PRIMARY KEY,
    PurchaseDateID INT,
    ClientID VARCHAR(5),
    Amount DECIMAL(10, 2),
    Quantity INT,
    Transactions INT,
    FOREIGN KEY (PurchaseDateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (ClientID) REFERENCES DimCustomer(CustomerID)
);

-- Inserting data into FactCustomerPurchases by aggregating from staging tables
INSERT INTO FactCustomerPurchases (PurchaseDateID, ClientID, Amount, Quantity, Transactions)
SELECT
    dd.DateID,
    dc.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS Amount,
    SUM(od.Quantity) AS Quantity,
    COUNT(DISTINCT o.OrderID) AS Transactions
FROM
    staging_orders o
        JOIN
    staging_order_details od ON o.OrderID = od.OrderID
        JOIN
    DimDate dd ON dd.Date = o.OrderDate
        JOIN
    DimCustomer dc ON dc.CustomerID = o.CustomerID
GROUP BY
    dd.DateID,
    dc.CustomerID;



-- Overview of customer purchases
SELECT
    dc.CustomerID,
    dc.CompanyName,
    SUM(fcp.Amount) AS TotalSpent,
    SUM(fcp.Quantity) AS TotalItemsPurchased,
    SUM(fcp.Transactions) AS TransactionCount
FROM
    FactCustomerPurchases fcp
        JOIN DimCustomer dc ON fcp.ClientID = dc.CustomerID
GROUP BY dc.CustomerID, dc.CompanyName
ORDER BY TotalSpent DESC;

-- Top five customers based on total sales
SELECT
    dc.CompanyName,
    SUM(fcp.Amount) AS TotalSpent
FROM
    FactCustomerPurchases fcp
        JOIN DimCustomer dc ON fcp.ClientID = dc.CustomerID
GROUP BY dc.CompanyName
ORDER BY TotalSpent DESC
    LIMIT 5;

-- Customer distribution by region
SELECT
    dc.Region,
    COUNT(*) AS NumberOfClients,
    SUM(fcp.Amount) AS TotalSpentInRegion
FROM
    FactCustomerPurchases fcp
        JOIN DimCustomer dc ON fcp.ClientID = dc.CustomerID
WHERE dc.Region IS NOT NULL
GROUP BY dc.Region
ORDER BY NumberOfClients DESC;

-- Segmenting customers based on spending
SELECT
    dc.CustomerID,
    dc.CompanyName,
    CASE
        WHEN SUM(fcp.Amount) > 10000 THEN 'VIP'
        WHEN SUM(fcp.Amount) BETWEEN 5000 AND 10000 THEN 'Premium'
        ELSE 'Standard'
        END AS CustomerSegment
FROM
    FactCustomerPurchases fcp
        JOIN DimCustomer dc ON fcp.ClientID = dc.CustomerID
GROUP BY dc.CustomerID, dc.CompanyName
ORDER BY SUM(fcp.Amount) DESC;