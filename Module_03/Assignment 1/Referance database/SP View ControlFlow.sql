CREATE DATABASE sales;
USE sales;


CREATE TABLE IF NOT EXISTS products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL UNIQUE,
  product_unitprice DECIMAL(10,2) NOT NULL CHECK (product_unitprice > 0),
  stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0)) AUTO_INCREMENT = 101;
  
  
INSERT INTO products (product_name, product_unitprice, stock_quantity) 
VALUES
('Laptop', 60000.00, 60),
('mobile', 25000.00, 25),
('pencil', 1500.00, 50),
('Chair', 3000.00, 10),
("Pen", 100.00, 2);


CREATE TABLE IF NOT EXISTS orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  order_date DATE DEFAULT (CURRENT_DATE),
  customer_firstname VARCHAR(100) NOT NULL,
  customer_lastname VARCHAR(100),
  city VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL,
  product_id INT,
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
  quantity INT NOT NULL CHECK (quantity > 0),
  total_price DECIMAL(10,2) NOT NULL,
  profit_level ENUM("High", "Average", "Low") NOT NULL ,
  FOREIGN KEY (product_id) REFERENCES products(product_id));



INSERT INTO orders 
(order_date, customer_firstname, customer_lastname, city, country, product_id, unit_price, quantity, total_price, profit_level) 
VALUES
('2024-07-01', 'Arun', 'Kumar', 'Chennai', 'India', 101, 60000.00, 1, 60000.00, 'High'),
('2024-07-02', 'Meena', 'R', 'Mumbai', 'India', 102, 25000.00, 2, 50000.00, 'High'),
('2024-07-03', 'Suresh', NULL, 'Bangalore', 'India', 103, 1500.00, 2, 3000.00, 'Average'),
('2024-07-04', 'Divya', NULL, 'Hyderabad', 'India', 104, 3000.00, 1, 3000.00, 'Low'),
('2024-07-05', 'Ravi', 'Shankar', 'Chennai', 'India', 101, 60000.00, 1, 60000.00, 'High'),
('2024-07-06', 'Priya', 'Anand', 'Delhi', 'India', 102, 25000.00, 1, 25000.00, 'Average'),
('2024-07-07', 'Karthik', NULL, 'Kolkata', 'India', 103, 1500.00, 3, 4500.00, 'Low'),
('2024-07-08', 'Anitha', 'Raj', 'Pune', 'India', 105, 100.00, 5, 500.00, 'Low'),
('2024-07-09', 'Sneha', 'Iyer', 'Chennai', 'India', 102, 25000.00, 1, 25000.00, 'Average'),
('2024-07-10', 'Ajay', 'Krish', 'Bangalore', 'India', 104, 3000.00, 2, 6000.00, 'Average'),
('2024-07-11', 'Deepa', 'Menon', 'Mumbai', 'India', 101, 60000.00, 1, 60000.00, 'High'),
('2024-07-12', 'Nisha', 'Varma', 'Delhi', 'India', 105, 100.00, 10, 1000.00, 'Low'),
('2024-07-13', 'Bala', 'Murugan', 'Hyderabad', 'India', 103, 1500.00, 1, 1500.00, 'Low'),
('2024-07-14', 'Vijay', 'R', 'Chennai', 'India', 102, 25000.00, 2, 50000.00, 'High'),
('2024-07-15', 'Kavya', 'Suresh', 'Bangalore', 'India', 104, 3000.00, 3, 9000.00, 'Average'),
('2024-07-16', 'Gowtham', NULL, 'Pune', 'India', 101, 60000.00, 1, 60000.00, 'High'),
('2024-07-17', 'Nirmal', 'Kumar', 'Mumbai', 'India', 103, 1500.00, 4, 6000.00, 'Average'),
('2024-07-18', 'Harish', NULL, 'Delhi', 'India', 105, 100.00, 8, 800.00, 'Low'),
('2024-07-19', 'Sandhya', NULL, 'Hyderabad', 'India', 102, 25000.00, 1, 25000.00, 'Average'),
('2024-07-20', 'Ramya', NULL, 'Chennai', 'India', 104, 3000.00, 2, 6000.00, 'Low');


SELECT * FROM orders;
SELECT * FROM products;
DROP TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE orders;
DROP TABLE products;
DROP DATABASE sales;



 


DELIMITER $$
CREATE PROCEDURE order_details()
BEGIN 
	SELECT order_id, city, product_id, total_price FROM orders;
END $$
DELIMITER ;

CALL order_details;



DELIMITER $$
CREATE PROCEDURE order_details_by_city(location VARCHAR(25))
BEGIN 
	SELECT order_id, city, product_id, total_price 
    FROM orders
    WHERE city = location;
END $$
DELIMITER ;

CALL order_details_by_city("Chennai");







DELIMITER $$
CREATE PROCEDURE total_sales_by_city(IN location VARCHAR(25), OUT total_sales FLOAT)
BEGIN 
	SELECT SUM(total_price) 
    INTO total_sales
    FROM orders
    WHERE city = location; 
END $$
DELIMITER ;

CALL total_sales_by_city("Pune", @total_price);

SELECT @total_price Total_price;










CREATE VIEW profit_status AS
SELECT order_id, CONCAT(customer_firstname, ' ', IFNULL(customer_lastname, '')) AS Name, profit_level
FROM orders;


SELECT * FROM profit_status WHERE profit_level = "High";


SELECT order_id, 
CASE 
WHEN quantity >=6 THEN "10% Discount"
WHEN quantity >=3 THEN "5% Discount"
ELSE "No Discount"
END AS Discount_check
FROM orders; 

