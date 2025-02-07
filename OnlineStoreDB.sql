-- Create the database
CREATE DATABASE OnlineStore;
USE OnlineStore;

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL
);

-- Insert Data into Categories
INSERT INTO Categories (CategoryName) VALUES 
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances');

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Insert Data into Products
INSERT INTO Products (ProductName, Price, QuantityInStock, CategoryID) VALUES 
('Smartphone', 699.99, 50, 1),
('Laptop', 1299.99, 30, 1),
('T-Shirt', 19.99, 100, 2),
('Jeans', 49.99, 80, 2),
('Fiction Book', 14.99, 200, 3),
('Cookbook', 29.99, 150, 3),
('Microwave Oven', 199.99, 20, 4),
('Blender', 89.99, 25, 4);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15)
);

-- Insert Data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone) VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321'),
('Alice', 'Johnson', 'alice.johnson@example.com', '5551234567'),
('Bob', 'Brown', 'bob.brown@example.com', '7778889999');

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Data into Orders
INSERT INTO Orders (OrderDate, CustomerID) VALUES 
('2024-01-15', 1),
('2024-01-20', 2),
('2024-02-05', 1),
('2024-02-10', 3),
('2024-02-15', 4);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Data into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES 
(1, 1, 2),   -- John ordered 2 Smartphones
(1, 3, 3),   -- John ordered 3 T-Shirts
(2, 2, 1),   -- Jane ordered 1 Laptop
(3, 5, 4),   -- John ordered 4 Fiction Books
(4, 4, 2),   -- Alice ordered 2 Jeans
(4, 8, 1),   -- Alice ordered 1 Blender
(5, 7, 1);   -- Bob ordered 1 Microwave Oven

INSERT INTO Orders (OrderDate, CustomerID) VALUES 
('2024-02-20', 1),  -- Adding an extra order for John Doe (CustomerID 1)
('2024-02-25', 1);  -- Another order for John Doe

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES 
(6, 2, 1),  -- John orders a Laptop
(7, 3, 2);  -- John orders 2 T-Shirts

-- Join Query: Fetching Order Information with Customer Details
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, p.ProductName, od.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- Create View: Total Sales per Product
CREATE VIEW ProductSales AS
SELECT p.ProductName, SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

-- View Usage
SELECT * FROM ProductSales;

-- Subquery: Find Customers Who Placed More Than 2 Orders
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 2
);

-- Stored Procedure: Get Total Orders by a Customer
DELIMITER //

CREATE PROCEDURE GetTotalOrders(IN CustID INT)
BEGIN
    SELECT COUNT(*) AS TotalOrders
    FROM Orders
    WHERE CustomerID = CustID;
END //

DELIMITER ;

-- Call Stored Procedure
CALL GetTotalOrders(1);  -- To see total orders by John Doe

-- Trigger: Auto-update Inventory After Order Placement
DELIMITER //

CREATE TRIGGER UpdateInventory
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET QuantityInStock = QuantityInStock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END //

DELIMITER ;

-- Aggregate Function: Total Revenue
SELECT SUM(p.Price * od.Quantity) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID;

-- Show All Tables
SHOW TABLES;

-- Describe Table Structures
DESCRIBE Products;
DESCRIBE Orders;
