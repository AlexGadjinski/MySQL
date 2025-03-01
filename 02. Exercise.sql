SELECT * FROM departments ORDER BY department_id;

SELECT `name` FROM departments ORDER BY department_id;

SELECT `first_name`, `last_name`, `salary` FROM employees ORDER BY employee_id;

SELECT `first_name`, `middle_name`, `last_name` FROM employees ORDER BY employee_id;

SELECT CONCAT(`first_name`, '.', `last_name`, '@softuni.bg') AS 'full_email_address' FROM employees;

SELECT DISTINCT `salary` FROM employees;

SELECT 
	employee_id AS 'id', 
	first_name AS 'First Name', 
	last_name AS 'Last Name',
	middle_name AS 'Middle Name',
	job_title AS 'Job Title',
	department_id AS 'Dept ID',
	manager_id AS 'Mngr ID',
	hire_date AS 'Hire Date',
	salary,
	address_id
FROM employees WHERE job_title = 'Sales Representative' ORDER BY id;

SELECT first_name, last_name, job_title FROM employees 
WHERE salary BETWEEN 20000 AND 30000 ORDER BY employee_id;

SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS 'Full Name'
FROM employees
WHERE salary IN (12500, 14000, 23600, 25000);

SELECT first_name, last_name FROM employees WHERE manager_id IS NULL;

SELECT first_name, last_name, salary FROM employees 
WHERE salary > 50000 ORDER BY salary DESC;

SELECT first_name, last_name FROM employees ORDER BY salary DESC LIMIT 5;

SELECT first_name, last_name FROM employees WHERE department_id <> 4;

SELECT employee_id AS 'id', first_name AS 'First Name', last_name AS 'Last Name',
middle_name AS 'Middle Name', job_title, department_id AS 'Dept ID', manager_id AS 'Mngr ID',
hire_date AS 'Hire Date', salary, address_id FROM employees
ORDER BY salary DESC, first_name, last_name DESC, middle_name;

CREATE VIEW `v_employees_salaries` AS
SELECT first_name, last_name, salary
FROM employees;

SELECT * FROM v_employees_salaries;

CREATE OR REPLACE VIEW `v_employees_job_titles` AS
SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name, job_title
FROM employees;

SELECT * FROM v_employees_job_titles;

SELECT DISTINCT job_title FROM employees ORDER BY job_title;

SELECT project_id AS id, name, description, start_date, end_date FROM projects 
ORDER BY start_date, name, project_id LIMIT 10;

SELECT first_name, last_name, hire_date FROM employees ORDER BY hire_date DESC LIMIT 7;

UPDATE employees SET salary = salary * 1.12 WHERE department_id IN (1, 2, 4, 11);

SELECT salary FROM employees;

SELECT peak_name FROM peaks ORDER BY peak_name;

SELECT country_name, population FROM countries 
WHERE continent_code = 'EU' ORDER BY population DESC, country_name LIMIT 30;

SELECT country_name, country_code, IF (currency_code = 'EUR', 'Euro', 'Not Euro') AS currency 
FROM countries ORDER BY country_name;

SELECT `name` FROM characters ORDER BY `name`;
