--Question 1
-- Split the Products column into individual rows
SELECT OrderID, CustomerName, TRIM(value) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');


--Question 2
-- Create Orders table to remove CustomerName partial dependency
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Create OrderProducts table with composite primary key
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
