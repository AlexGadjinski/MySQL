-- CREATE TABLE test(
-- 	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
--     department_id INT,
--     salary INT
-- );

-- INSERT INTO test(department_id, salary) VALUES
-- (1, 1500),
-- (1, 3000),
-- (2, 700);

-- SELECT department_id, SUM(salary) FROM test GROUP BY department_id;

-- SELECT id, first_name, SUM(salary) FROM employees GROUP BY first_name;

SELECT department_id FROM employees 
GROUP BY department_id;

-- SELECT * FROM employees GROUP BY department_id;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, COUNT(id) AS 'Number of employees'
FROM employees
GROUP BY department_id
ORDER BY department_id, `Number of employees`;

SELECT department_id, ROUND(AVG(salary), 3), ROUND(SUM(salary) / COUNT(salary), 3)
FROM employees
GROUP BY department_id;

SELECT department_id, MIN(salary)
FROM employees
WHERE salary > 800 -- filters the rows before grouping has started
GROUP BY department_id;

SELECT department_id, ROUND(AVG(salary), 2) AS 'Average Salary'
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, ROUND(MIN(salary), 2) AS 'Min Salary'
FROM employees
GROUP BY department_id
HAVING `Min Salary` > 800;

SELECT COUNT(*)
FROM products
WHERE category_id = 2 AND price > 8;

SELECT 
	category_id, 
	ROUND(AVG(price), 2) AS 'Average Price',
    MIN(price) AS 'Cheapest Product',
    MAX(price) AS 'Most Expensive Product'
FROM products
GROUP BY category_id;
