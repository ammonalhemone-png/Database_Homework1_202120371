-- ========================================
-- Database Programming Homework #1
-- Student ID: <202120371>
-- Name: <Amneh Khaled Alhemone>
-- ========================================


-- Q1

-- 1) Total number of orders per customer
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


-- 2) Customers who have more orders than average
WITH customer_orders AS (
    SELECT customer_id, COUNT(order_id) AS total_orders
    FROM Orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.name, co.total_orders
FROM customer_orders co
JOIN Customers c 
ON c.customer_id = co.customer_id
WHERE co.total_orders > (
    SELECT AVG(total_orders) FROM customer_orders
);


-- 3) Create index on customer_id
CREATE INDEX idx_customer_id
ON Orders(customer_id);


-- 4) Transaction (Insert Order + Items)
START TRANSACTION;

INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES (101, 1, '2026-04-04', 250.00);

INSERT INTO Order_Items (item_id, order_id, product_name, quantity, price)
VALUES 
(1001, 101, 'Product A', 2, 50.00),
(1002, 101, 'Product B', 3, 50.00);

COMMIT;



-- 5) ACID Properties
-- Atomicity: Either all operations succeed or none.
-- Consistency: Database remains valid.
-- Isolation: Transactions don’t affect each other.
-- Durability: Data is saved permanently after commit.



-- ========================================
-- Q2
-- ========================================

-- Create table
CREATE TABLE demand (
    day INT,
    qty INT
);

-- Insert data
INSERT INTO demand (day, qty) VALUES
(1, 10),
(2, 6),
(3, 21),
(4, 9),
(5, 12),
(6, 18),
(7, 3),
(8, 6),
(9, 23),
(10, 0);

-- Cumulative Sum
SELECT 
    day,
    qty,
    SUM(qty) OVER (ORDER BY day) AS cumQty
FROM demand
ORDER BY day;