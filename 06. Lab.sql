SELECT first_name, last_name, address_text
FROM employees
INNER JOIN addresses ON employees.address_id = addresses.address_id;

SELECT
	e.employee_id,
    e.first_name,
    e.last_name,
    e.manager_id,
    m.employee_id,
    m.first_name,
    m.last_name
FROM employees e
INNER JOIN employees m
	ON e.manager_id = m.employee_id;
    
SELECT first_name FROM employees
UNION
SELECT name FROM departments;

-- SELECT DISTINCT
-- 	m.employee_id, 
-- 	CONCAT(m.first_name, ' ', m.last_name) AS full_name,
--     m.department_id
-- FROM employees AS e
-- JOIN employees AS m
-- 	ON e.manager_id = m.employee_id;

SELECT 
	e.employee_id,
	CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.department_id,
    d.name AS 'department_name'
FROM employees AS e
JOIN departments AS d
	ON d.manager_id = e.employee_id
ORDER BY employee_id LIMIT 5;

SELECT * FROM employees
WHERE manager_id IN(
	SELECT employee_id FROM employees
    WHERE first_name LIKE 'z%'
);

SELECT * FROM employees
WHERE manager_id = (
	SELECT employee_id FROM employees
    WHERE first_name LIKE 'za%'
    LIMIT 1
);

SELECT COUNT(*) AS count FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT a.town_id, t.name AS town_name, address_text
FROM towns AS t
JOIN addresses AS a ON
a.town_id = t.town_id
WHERE t.name IN('San Francisco', 'Sofia', 'Carnation')
ORDER BY a.town_id, town_name, address_text;

SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE manager_id IS NULL;

SELECT e.first_name, e.address_id, t.name
FROM employees AS e
JOIN addresses AS a
	ON e.address_id = a.address_id
JOIN towns t
	ON a.town_id = t.town_id
ORDER BY employee_id;
