CREATE DATABASE Ecommerce;
USE Ecommerce;
SELECT * FROM Customers;
SELECT * FROM Customers WHERE Region = 'Asia';
SELECT * FROM Customers ORDER BY SignupDate DESC;
SELECT CustomerID, SUM(TotalValue) AS TotalValue FROM Transactions GROUP BY CustomerID ORDER BY TotalValue DESC;
SELECT * FROM Transactions WHERE TotalValue > (SELECT AVG(TotalValue) FROM Transactions);
SELECT CustomerID, SUM(TotalValue) AS TotalSpent FROM Transactions GROUP BY CustomerID 
HAVING SUM(TotalValue) > (SELECT AVG(TotalSpent) FROM (SELECT SUM(TotalValue) AS TotalSpent 
FROM Transactions GROUP BY CustomerID) AS CustomerTotals);
SELECT SUM(TotalValue) AS Total_Revenue FROM Transactions;
SELECT AVG(TotalValue) AS Avg_Order_Value FROM Transactions;
CREATE VIEW Customer_Revenue AS
SELECT 
    CustomerID,
    SUM(TotalValue) AS Total_Revenue
FROM Transactions
GROUP BY CustomerID;
CREATE VIEW Monthly_Revenue AS
SELECT 
    MONTH(TransactionDate) AS Month,
    SUM(TotalValue) AS Revenue
FROM Transactions
GROUP BY MONTH(TransactionDate);
SELECT * FROM Monthly_Revenue;
CREATE INDEX idx_customer ON Transactions(CustomerID(50));
CREATE INDEX idx_product ON Transactions(ProductID(50));
CREATE INDEX idx_date ON Transactions(TransactionDate(50));
SELECT 
    p.ProductName,
    SUM(t.TotalValue) AS Revenue
FROM Transactions t
INNER JOIN Products p
ON t.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC
LIMIT 5;