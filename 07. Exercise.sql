DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE salary > 35000
    ORDER BY first_name, last_name, employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_salary_above_35000();

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(target_salary DECIMAL(12, 4))
BEGIN
	SELECT first_name, last_name FROM employees
	WHERE salary >= target_salary
    ORDER BY first_name, last_name, employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_salary_above(45000);

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_get_towns_starting_with;
CREATE PROCEDURE usp_get_towns_starting_with(chars VARCHAR(20))
BEGIN
	SELECT name AS town_name FROM towns
    WHERE name LIKE CONCAT(chars, '%')
    ORDER BY town_name;
END $$
DELIMITER ;

CALL usp_get_towns_starting_with('b');

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(30))
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
    JOIN addresses AS a
		ON e.address_id = a.address_id
	JOIN towns AS t
		ON t.town_id = a.town_id
	WHERE t.name = town_name
    ORDER BY first_name, last_name, employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_from_town('Sofia');

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(12, 2))
RETURNS VARCHAR(7)
NO SQL
BEGIN
	DECLARE salary_level VARCHAR(7);
	
    IF(salary < 30000) THEN
		SET salary_level := 'Low';
	ELSEIF(salary <= 50000) THEN
		SET salary_level := 'Average';
    ELSE 
		SET salary_level := 'High';
    END IF;
    RETURN salary_level;
END $$
DELIMITER ;

SELECT ufn_get_salary_level(13500);

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE ufn_get_salary_level(salary) = salary_level
    ORDER BY first_name DESC, last_name DESC;
END $$
DELIMITER ;

CALL usp_get_employees_by_salary_level('High');

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS TINYINT
NO SQL
BEGIN
	RETURN (SELECT word REGEXP CONCAT('^[', set_of_letters, ']+$'));
END $$
DELIMITER ;

SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');

DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM account_holders
    ORDER BY full_name, id;
END $$
DELIMITER ;

CALL usp_get_holders_full_name();

DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(min_balance DECIMAL(19, 4))
BEGIN
	SELECT first_name, last_name FROM account_holders AS ah
    JOIN accounts AS a ON a.account_holder_id = ah.id
    GROUP BY ah.id
    HAVING SUM(a.balance) > min_balance
    ORDER BY ah.id;
END $$
DELIMITER ;

CALL usp_get_holders_with_balance_higher_than(7000);

DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(12, 4), interest_rate DOUBLE, years INT)
RETURNS DECIMAL(12, 4)
NO SQL
BEGIN
	RETURN(SELECT initial_sum * POW(1 + interest_rate, years));
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.5, 5);

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest_rate DECIMAL(12, 4))
BEGIN
	SELECT 
		a.id AS account_id, 
		ah.first_name, 
		ah.last_name, 
		a.balance AS current_balance,
		ufn_calculate_future_value(a.balance, interest_rate, 5) AS balance_in_5_years
	FROM accounts AS a
    JOIN account_holders AS ah ON ah.id = a.account_holder_id
    WHERE a.id = acc_id;
END $$
DELIMITER ;

CALL usp_calculate_future_value_for_account(1, 0.1);

DELIMITER $$
CREATE PROCEDURE usp_deposit_money(acc_id INT, money_amount DECIMAL(12, 4))
BEGIN
	START TRANSACTION;
    
    UPDATE accounts SET balance = balance + money_amount WHERE id = acc_id;
    IF(money_amount <= 0 OR (SELECT COUNT(*) FROM accounts WHERE id = acc_id) = 0) THEN
		ROLLBACK;
	ELSE
		COMMIT;
    END IF;
END $$
DELIMITER ;

CALL usp_deposit_money(1, 10);
SELECT * FROM accounts WHERE id = 1;

DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(acc_id INT, money_amount DECIMAL(12, 4))
BEGIN
	START TRANSACTION;
    
    UPDATE accounts SET balance = balance - money_amount WHERE id = acc_id;
    IF (money_amount <= 0 OR (SELECT COUNT(*) FROM accounts WHERE id = acc_id) = 0 OR
    (SELECT balance FROM accounts WHERE id = acc_id) < money_amount) THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
END $$
DELIMITER ;

CALL usp_withdraw_money(1, 10);
SELECT * FROM accounts WHERE id = 1;

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(12, 4))
BEGIN
	START TRANSACTION;
    UPDATE accounts SET balance = balance + amount WHERE id = to_account_id;
    UPDATE accounts SET balance = balance - amount WHERE id = from_account_id;
    
    IF(amount <= 0 OR
		(SELECT COUNT(*) FROM accounts WHERE id = from_account_id) = 0 OR
		(SELECT COUNT(*) FROM accounts WHERE id = to_account_id) = 0 OR
		(SELECT balance FROM accounts WHERE id = from_account_id) < amount) THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
END $$
DELIMITER ;

CALL usp_transfer_money(1, 2, 10);
SELECT * FROM accounts WHERE id = 1 OR id = 2;

CREATE TABLE logs(
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    old_sum DECIMAL(19, 4),
    new_sum DECIMAL(19, 4)
);

DELIMITER $$
CREATE TRIGGER tr_accounts_update
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs(account_id, old_sum, new_sum) VALUES
    (NEW.id, OLD.balance, NEW.balance);
END $$

DELIMITER ;

CALL usp_deposit_money(1, 10);

CREATE TABLE notification_emails(
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject VARCHAR(255),
    body TEXT
);

DELIMITER $$
CREATE TRIGGER tr_logs_insert
AFTER INSERT
ON logs
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails(recipient, subject, body) VALUES
    (NEW.account_id,
    CONCAT('Balance change for account: ', NEW.account_id),
    CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y'), ' at ', DATE_FORMAT(NOW(), '%r'),
    ' your balance was changed from ',
    ROUND(NEW.old_sum, 0),
    ' to ',
    ROUND(NEW.new_sum, 0),
    '.'));
END $$
DELIMITER ;

CALL usp_deposit_money(1, 10);
