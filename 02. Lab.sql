USE `hotel`;
SELECT * FROM employees;

SELECT `id`, `first_name`, `last_name`, `job_title` FROM employees ORDER BY `id`;

SELECT 
	`id` AS "#", 
    `first_name` AS "First Name",
    `last_name` AS "Last Name",
    `job_title` AS "Title"
FROM employees;

SELECT
	e.id,
    e.first_name,
    e.last_name
FROM hotel.employees AS e;

SELECT
	`id`,
	CONCAT(`first_name`, ' ', `last_name`) AS 'Full Name'
FROM employees;

SELECT
	CONCAT_WS(' ', `first_name`, `last_name`) AS 'Full Name'
FROM employees;

SELECT
	`id`,
	CONCAT_WS(' ', `first_name`, `last_name`) AS 'full_name',
    `job_title`,
    `salary`
FROM employees WHERE salary > 1000.00 ORDER BY `id`;

SELECT DISTINCT `id`, `first_name` FROM employees;

SELECT * FROM employees WHERE department_id = 4 AND salary >= 1000 ORDER BY `id`;

SELECT * FROM employees WHERE department_id = 3 OR department_id = 4;

SELECT * FROM employees WHERE salary BETWEEN 1100 AND 2000;

SELECT * FROM employees WHERE department_id IN (3, 4, 5, 6);

SELECT * FROM employees WHERE NOT first_name = 'john';

SELECT * FROM employees WHERE first_name <> 'john';

CREATE VIEW `v_top_paid_employee` AS
SELECT * FROM employees ORDER BY salary DESC LIMIT 1;

SELECT * FROM v_top_paid_employee;

INSERT INTO employees(`first_name`, `last_name`, `salary`) VALUES
('New', 'Entry', 2000);

INSERT INTO departments VALUES (5, 'New department');

INSERT INTO clients(`first_name`, `last_name`, `room_id`)
	SELECT `first_name`, `last_name`, 1
    FROM employees
    WHERE department_id = 4;

CREATE TABLE `selected_filtered_employees` AS
SELECT `id`, `first_name`, `last_name` FROM employees;

SET SQL_SAFE_UPDATES = 0;

UPDATE employees SET salary = salary * 1.10 WHERE department_id = 3;

UPDATE employees SET salary = salary + 100 WHERE job_title = 'Manager';

SELECT salary FROM employees;

DELETE FROM departments WHERE id IN (5, 6, 7, 8, 9, 10);

DELETE FROM employees WHERE department_id IN (1, 2);

SELECT * FROM employees ORDER BY id;
