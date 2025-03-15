CREATE TABLE chai_store(
id        SERIAL PRIMARY KEY,
chai_name VARCHAR(50),
price     DECIMAL(5, 2),
chai_type VARCHAR(50),
available BOOLEAN
);






-- DML (Data manipulation language)
INSERT INTO chai_store(chai_name, price, chai_type, available
) VALUES
('Masal chai', 99.00, 'Ginger', TRUE),
('Apple chai', 23.00, 'Onion', FALSE),
('Papaya', 34.00, 'Lemon', TRUE);


SELECT * FROM chai_store



-- Replace column name
SELECT chai_name AS "Chai name", price AS "In INR" FROM chai_store;


-- If chai_name contains "Apple"
SELECT * FROM chai_store
WHERE chai_name LIKE '%Apple%';


-- If price contain less than 50
SELECT * FROM chai_store
WHERE price < 50;


-- To arrange the order of price column
SELECT * FROM chai_store
ORDER BY price DESC;


-- To update a query
UPDATE chai_store
SET price = 34.00, available = TRUE
WHERE chai_name = 'Apple chai';


-- To delete query
DELETE FROM chai_store
WHERE chai_name = 'Apple chai';






-- DDL (Data definition language)
-- ALTER (modifies/add/remove) data from column
ALTER TABLE chai_store
ADD stock INT DEFAULT 0;

ALTER TABLE chai_Store
ALTER COLUMN price TYPE DECIMAL(12, 2);

ALTER TABLE chai_store
DROP COLUMN stock;

ALTER TABLE chai_store RENAME TO chai_ki_dukaan;
ALTER TABLE chai_store RENAME COLUMN chai_type TO chaiType; 



-- To drop entire table/column
DROP TABLE chai_store;
DROP COLUMN chai_type;



-- To remove a row while retaining the order
TRUNCATE TABLE chai_store;




-- DCL 
-- To give access and remove access from someone
GRANT SELECT ON chai_store TO swayam
GRANT UPDATE, DELETE ON chai_store TO sales_team

REVOKE SELECT ON chai_store FROM swayam
REVOKE UPDATE, DELETE ON chai_store FROM sales_team





-- TCL (Transaction control language)
BEGIN;
INSERT INTO chai_store (chai_name, price, chai_type, available)
VALUE ('Apple chai', 400.00, 'Mango', FALSE);

UPDATE chai_store SET price = price - 5
WHERE chai_name = 'Masala chai';
COMMIT;


BEGIN;
-- To save the checkpoint 
SAVEPOINT savepoint1;
INSERT INTO chai_store (chai_name, price, chai_type, available)
VALUE ('Apple chai', 400.00, 'Mango', FALSE);
-- If error happens then it rolls back to savepoint1
ROLLBACK TO savepoint1




-- DTO (Data in JSON)
-- DCO (SELECT )


-- 1NF 2NF 3NF









--  Joins
CREATE TABLE customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50)
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
product_name VARCHAR(100),
quantity INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES 
(1, 'John Doe'),
(2, 'Alice Smith'),
(3, 'Michael Johnson'),
(4, 'Emma Brown');


INSERT INTO orders (order_id, customer_id, product_name, quantity) VALUES 
(101, 1, 'Laptop', 2),
(102, 2, 'Smartphone', 1),
(103, NULL, 'Headphones', 3),
(104, 4, 'Tablet', 1);

SELECT * FROM customers;
SELECT * FROM orders;




-- It gives the insection of 2 tables on the basis of "customer_id"
SELECT c.customer_name, o.product_name, o.quantity
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;



-- It give product_name = null
SELECT c.customer_name, o.product_name, o.quantity
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;



-- It give customer_name = null
SELECT c.customer_name, o.product_name, o.quantity
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;




-- It give one-many combination
SELECT c.customer_name, o.product_name, o.quantity
FROM customers c
CROSS JOIN orders o;








-- Aggregators
SELECT customer_name
FROM customers
WHERE customer_id IN {
SELECT COUNT(customer_id)
FROM orders
WHERE product_name = 'Headphones'
}







