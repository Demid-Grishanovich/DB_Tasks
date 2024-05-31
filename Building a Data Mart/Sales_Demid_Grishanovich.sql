-- Monthly and category-wise aggregate sales
SELECT dd.Month, dd.Year, dc.CategoryName, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
         JOIN DimDate dd ON fs.DateID = dd.DateID
         JOIN DimCategory dc ON fs.CategoryID = dc.CategoryID
GROUP BY dd.Month, dd.Year, dc.CategoryName
ORDER BY dd.Year, dd.Month, TotalSales DESC;

-- Top five selling products per quarter
SELECT dd.Quarter, dd.Year, dp.ProductName, SUM(fs.QuantitySold) AS TotalQuantitySold
FROM FactSales fs
         JOIN DimDate dd ON fs.DateID = dd.DateID
         JOIN DimProduct dp ON fs.ProductID = dp.ProductID
GROUP BY dd.Quarter, dd.Year, dp.ProductName
ORDER BY dd.Year, dd.Quarter, TotalQuantitySold DESC
    LIMIT 5;

-- Employee sales performance report
SELECT de.FirstName, de.LastName, COUNT(fs.SalesID) AS NumberOfSales, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
         JOIN DimEmployee de ON fs.EmployeeID = de.EmployeeID
GROUP BY de.FirstName, de.LastName
ORDER BY TotalSales DESC;

-- Overview of customer purchases
SELECT dcu.CompanyName, SUM(fs.TotalAmount) AS TotalSpent, COUNT(DISTINCT fs.SalesID) AS TransactionsCount
FROM FactSales fs
         JOIN DimCustomer dcu ON fs.CustomerID = dcu.CustomerID
GROUP BY dcu.CompanyName
ORDER BY TotalSpent DESC;

-- Monthly sales growth rate analysis
WITH MonthlySales AS (
    SELECT
        dd.Year,
        dd.Month,
        SUM(fs.TotalAmount) AS TotalSales
    FROM FactSales fs
             JOIN DimDate dd ON fs.DateID = dd.DateID
    GROUP BY dd.Year, dd.Month
),
     MonthlyGrowth AS (
         SELECT
    Year,
    Month,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY Year, Month) AS PreviousMonthSales,
    (TotalSales - LAG(TotalSales) OVER (ORDER BY Year, Month)) / LAG(TotalSales) OVER (ORDER BY Year, Month) AS GrowthRate
FROM MonthlySales
    )
SELECT * FROM MonthlyGrowth;