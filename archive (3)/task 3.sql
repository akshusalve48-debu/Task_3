CREATE DATABASE Ecommerce;
USE Ecommerce;
SELECT * FROM Customers;
ALTER TABLE Customers RENAME COLUMN ï»¿CustomerID TO CustomerID;
ALTER TABLE Products RENAME COLUMN ï»¿ProductID TO ProductID;
ALTER TABLE Transactions RENAME COLUMN ï»¿TransactionID TO TransactionID;
ALTER TABLE Customers MODIFY CustomerID VARCHAR(50);
ALTER TABLE Customers MODIFY CustomerName VARCHAR(50);
ALTER TABLE Customers MODIFY Region VARCHAR(50);
ALTER TABLE Customers MODIFY SignupDate date;
DESCRIBE Customers;
ALTER TABLE products MODIFY ProductID VARCHAR(50);
ALTER TABLE products MODIFY ProductName VARCHAR(50);
ALTER TABLE products MODIFY Category VARCHAR(50);
DESCRIBE products;
ALTER TABLE transactions MODIFY TransactionID VARCHAR(50);
ALTER TABLE transactions MODIFY CustomerID VARCHAR(50);
ALTER TABLE transactions MODIFY ProductID VARCHAR(50);
ALTER TABLE transactions MODIFY TransactionDate date;
DESCRIBE transactions;
SELECT * FROM Customers WHERE Region = 'Asia';
SELECT * FROM Customers ORDER BY SignupDate DESC;
SELECT CustomerID, SUM(TotalValue) AS TotalValue FROM Transactions GROUP BY CustomerID ORDER BY TotalValue DESC;
SELECT c.CustomerName, t.TransactionID, t.TotalValue FROM Customers c INNER JOIN Transactions t 
ON c.CustomerID = t.CustomerID;
SELECT c.CustomerName, t.TransactionID FROM Customers c LEFT JOIN Transactions t ON c.CustomerID = t.CustomerID
 WHERE t.TransactionID IS NULL;
 SELECT c.CustomerName, t.TransactionID, t.Totalvalue FROM Customers c RIGHT JOIN Transactions t 
 ON c.CustomerID = t.CustomerID;
SELECT * FROM Transactions WHERE TotalValue > (SELECT AVG(TotalValue) FROM Transactions);
SELECT CustomerID, SUM(TotalValue) AS TotalSpent FROM Transactions GROUP BY CustomerID 
HAVING SUM(TotalValue) > (SELECT AVG(TotalSpent) FROM (SELECT SUM(TotalValue) AS TotalSpent 
FROM Transactions GROUP BY CustomerID) AS CustomerTotals);
SELECT SUM(TotalValue) AS Total_Revenue FROM Transactions;
SELECT AVG(TotalValue) AS Avg_Order_Value FROM Transactions;
SELECT p.ProductName, SUM(t.Totalvalue) AS Product_Revenue FROM Transactions t INNER JOIN Products p 
ON t.ProductID = p.ProductID GROUP BY p.ProductName ORDER BY Product_Revenue DESC;
CREATE VIEW Customer_Revenue AS SELECT CustomerID, SUM(TotalValue) AS Total_Revenue FROM Transactions 
GROUP BY CustomerID;
CREATE VIEW Monthly_Revenue AS SELECT MONTH(TransactionDate) AS Month, SUM(TotalValue) AS Revenue 
FROM Transactions GROUP BY MONTH(TransactionDate);
SELECT * FROM Monthly_Revenue;
CREATE INDEX idx_customer ON Transactions(CustomerID(50));
CREATE INDEX idx_product ON Transactions(ProductID(50));
CREATE INDEX idx_date ON Transactions(TransactionDate(50));
SELECT p.ProductName, SUM(t.TotalValue) AS Revenue FROM Transactions t INNER JOIN Products p 
ON t.ProductID = p.ProductID GROUP BY p.ProductName ORDER BY Revenue DESC LIMIT 5;