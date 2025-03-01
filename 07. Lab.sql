SELECT COUNT(*) AS count
FROM employees e
JOIN addresses a
	ON e.address_id = a.address_id
JOIN towns t
	ON a.town_id = t.town_id
WHERE t.name = 'Sofia';

DELIMITER $$
DROP FUNCTION IF EXISTS ufn_count_employees_by_town;
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
    SET e_count := (SELECT COUNT(*) AS count
			FROM employees e
			JOIN addresses a ON e.address_id = a.address_id
			JOIN towns t ON a.town_id = t.town_id
			WHERE t.name = town_name);
	RETURN e_count;
END $$
DELIMITER ;

SELECT ufn_count_employees_by_town('Sofia');

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_select_employees;
CREATE PROCEDURE usp_select_employees()
BEGIN
	SELECT first_name, last_name FROM employees;
END $$
DELIMITER ;

CALL usp_select_employees();

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_raise_salaries;
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE employees SET salary = salary * 1.05
    WHERE department_id = (SELECT department_id FROM departments WHERE name = department_name);
    
    SELECT e.first_name, e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.name = department_name
    ORDER BY e.first_name, salary;
END $$
DELIMITER ;

CALL usp_raise_salaries('Finance');

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	DECLARE e_cnt INT;
    SET e_cnt := (SELECT COUNT(*) FROM employees WHERE employee_id = id);
    -- e_cnt = 1 => update; e_cnt = 0 => abort
    
    START TRANSACTION;
    
    UPDATE employees SET salary = salary * 1.05 WHERE employee_id = id;
    IF (e_cnt = 0) THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
END $$
DELIMITER ;

CALL usp_raise_salary_by_id(43);

DELIMITER $$
CREATE TRIGGER tr_add_town_address
AFTER INSERT
ON towns
FOR EACH ROW
BEGIN
	INSERT INTO addresses(address_text, town_id) VALUES
    (CONCAT(NEW.name, ' Center'), NEW.town_id);
END $$
DELIMITER ;

INSERT INTO towns(name) VALUES ('New'), ('Old');

SELECT * FROM towns ORDER BY town_id DESC;
SELECT * FROM addresses ORDER BY address_id DESC;

CREATE TABLE deleted_employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT,
    salary DOUBLE
);

DELIMITER $$
CREATE TRIGGER tr_deleted_employee
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees(first_name, last_name, middle_name, job_title, department_id, salary) VALUES
    (OLD.first_name, OLD.last_name, OLD.middle_name, 
    OLD.job_title, OLD.department_id, OLD.salary);
END $$
DELIMITER ;
