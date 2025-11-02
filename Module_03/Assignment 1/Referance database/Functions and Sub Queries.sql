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
  customer_name VARCHAR(100) NOT NULL,
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



-- Q1: Function to return total number of products
DELIMITER //
CREATE FUNCTION total_products()
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM products;
  RETURN total;
END //
DELIMITER ;

-- Usage
SELECT total_products();


-- Q1: Function to return total number of orders
DELIMITER //
CREATE FUNCTION total_orders()
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM orders;
  RETURN total;
END //
DELIMITER ;

-- Usage
SELECT total_orders();



-- Q1: Function to get product price by product_id
DELIMITER //
CREATE FUNCTION get_price(pid INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE price DECIMAL(10,2);
  SELECT product_unitprice INTO price
  FROM products
  WHERE product_id = pid;
  RETURN price;
END //
DELIMITER ;

-- Usage
SELECT get_price(101);



-- Q2: Function to return stock quantity of a product
DELIMITER //
CREATE FUNCTION get_avg_by_city (location VARCHAR(25))
RETURNS FLOAT
DETERMINISTIC
BEGIN
  DECLARE average INT;
  SELECT AVG(total_price) INTO average
  FROM orders
  WHERE City = location;
  RETURN average;
END //
DELIMITER ;

-- Usage
SELECT get_avg_by_city("Chennai");


-- Q1: Function to calculate total bill (unit_price × qty)
DELIMITER //
CREATE FUNCTION calc_total(unit_price DECIMAL(10,2), qty INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN unit_price * qty;
END //
DELIMITER ;

-- Usage
SELECT calc_total(25000, 3);



DROP FUNCTION total_products;
DROP FUNCTION total_orders;
DROP FUNCTION calc_total;
DROP FUNCTION get_avg_by_city;


-- Q1: Customers who bought the costliest product
SELECT customer_name
FROM orders
WHERE product_id = (
  SELECT product_id
  FROM products
  ORDER BY product_unitprice DESC
  LIMIT 1
);

-- Q2: Find product(s) with stock less than average stock
SELECT product_name
FROM products
WHERE stock_quantity < (
  SELECT AVG(stock_quantity) FROM products
);


-- Q3: List product names ordered in Mumbai
SELECT product_name
FROM products
WHERE product_id IN (
  SELECT product_id FROM orders WHERE city='Mumbai'
);

-- Q4: Find orders whose quantity is greater than average quantity
SELECT order_id, customer_name, quantity
FROM orders
WHERE quantity > (
  SELECT AVG(quantity) FROM orders
);

