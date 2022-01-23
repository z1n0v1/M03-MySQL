DROP DATABASE IF EXISTS soft_uni;

USE soft_uni;

# 01. Employees with Salary Above 35000

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name FROM employees WHERE salary > 35000 ORDER BY first_name, last_name, employee_id;
END
$$
DELIMITER ;

CALL usp_get_employees_salary_above_35000();

# 02. Employees with Salary Above Number

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above( above_salary DECIMAL(16,4))
BEGIN
	SELECT first_name, last_name FROM employees WHERE salary >= above_salary ORDER BY first_name, last_name, employee_id;
END
$$
DELIMITER ;

CALL usp_get_employees_salary_above(45000);
DROP PROCEDURE usp_get_employees_salary_above;

# 03. Town Names Starting With

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(start_with VARCHAR(20))
BEGIN
	SELECT name AS 'town_name' FROM towns WHERE left(LOWER(name), char_length(start_with)) = lower(start_with)
		ORDER BY town_name;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS usp_get_towns_starting_with;

CALL usp_get_towns_starting_with('b');

# 04. Employees from Town

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(employees_in_town VARCHAR(50))
BEGIN
	SELECT e.first_name, e.last_name
		FROM employees AS e
        JOIN addresses as a USING (address_id)
        JOIN towns  as t USING (town_id)
        WHERE t.name = employees_in_town
        ORDER BY e.first_name, e.last_name, e.employee_id;
END
$$
DELIMITER ;

DROP PROCEDURE usp_get_employees_from_town;
CALL usp_get_employees_from_town('Sofia');

# 05. Salary Level Function

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE level_of_salary VARCHAR(10);
    SET level_of_salary := (
		SELECT
			CASE 
				WHEN employee_salary < 30000 THEN 'Low'
                WHEN employee_salary BETWEEN 30000 AND 50000 THEN 'Average'
                ELSE 'High'
			END
	);
	RETURN level_of_salary;	
END
$$
DELIMITER ;

SELECT ufn_get_salary_level(60000);

# 06. Employees by Salary Level

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
	CASE lower(salary_level)
		WHEN 'low' THEN
			SELECT first_name, last_name FROM employees 
				WHERE salary < 35000 
                ORDER BY first_name DESC, last_name DESC;
		WHEN 'average' THEN
			SELECT first_name, last_name FROM employees 
				WHERE salary BETWEEN 35000 AND 50000
                ORDER BY first_name DESC, last_name DESC;
		#WHEN 'high' THEN
        ELSE
			SELECT first_name, last_name FROM employees 
				WHERE salary > 50000
                ORDER BY first_name DESC, last_name DESC;
	END CASE;
END
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
	SELECT e.first_name, e.last_name FROM `employees` as e
		WHERE
			(e.salary < 35000 AND salary_level = 'low') OR
			(e.salary >= 35000 AND e.salary <= 50000 AND salary_level = 'average') OR
			(e.salary > 50000 AND salary_level = 'high')
		ORDER BY e.first_name DESC, e.last_name DESC;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS usp_get_employees_by_salary_level;
CALL usp_get_employees_by_salary_level('high');

## Why oh why the above solutions don't work, but the one below 
# (from https://github.com/Martin-BG/SoftUni-DatabaseBasics-MySQL/)
# works...

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
    SELECT e.first_name, e.last_name
    FROM `employees` AS e
    WHERE e.salary < 30000 AND salary_level = 'low'
        OR e.salary >= 30000 AND e.salary <= 50000 AND salary_level = 'average'
        OR e.salary > 50000 AND salary_level = 'high'
    ORDER BY e.first_name DESC, e.last_name DESC;
END $$
DELIMITER ;

# 07. Define Function

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS bit
DETERMINISTIC
BEGIN
	RETURN word REGEXP (concat('^[',set_of_letters,']*$'));
END
$$
DELIMITER ;

SELECT ufn_is_word_comprised('asdf', 'safd');
SELECT ufn_is_word_comprised('asdf', 'csafd');

## PART II – Queries for Bank Database
DROP DATABASE soft_uni;
use soft_uni;

# 08. Find Full Name

DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT concat_ws(' ', first_name, last_name) as 'full_name' FROM account_holders ORDER BY `full_name`, id;
END
$$
DELIMITER ;

# 09. People with Balance Higher Than

DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than (money DECIMAL(19,4))
BEGIN
SELECT first_name, last_name FROM account_holders as ah
	RIGHT JOIN accounts as ac ON ac.account_holder_id = ah.id
    GROUP BY ah.id
    HAVING sum(balance) > money
    ORDER BY ah.id;
END
$$
DELIMITER ;

CALL usp_get_holders_with_balance_higher_than (7000);

# 10. Future Value Function

DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value (sum DECIMAL(19,4), interest DECIMAL(19,4), num_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN sum * (pow((1 + interest), num_years));
END
$$
DELIMITER ;
SELECT ufn_calculate_future_value(1000, 0.5, 5);

# 11. Calculating Interest

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest DECIMAL(19,4))
BEGIN
	SELECT ac.id AS 'account_id', ah.first_name, ah.last_name, ac.balance AS 'current_balance', 
			ufn_calculate_future_value(ac.balance, interest, 5)
		FROM accounts AS ac
		JOIN account_holders AS ah ON ah.id = ac.account_holder_id
		WHERE ac.id = acc_id;
END
$$
DELIMITER ;
DROP PROCEDURE IF EXISTS usp_calculate_future_value_for_account;
CALL usp_calculate_future_value_for_account(1, 0.1);

# 12. Deposit Money

DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF ((SELECT count(a.id) FROM accounts as a WHERE a.id = account_id) != 1 OR money_amount < 0)
		THEN ROLLBACK;
		ELSE
			UPDATE accounts set balance = balance + money_amount WHERE id = account_id;
			COMMIT;
	END IF;
END
$$
DELIMITER ;

# 13. Withdraw Money

DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF((SELECT count(a.id) FROM accounts as a WHERE a.id = account_id) != 1 OR
		money_amount < 0 OR
        (SELECT balance FROM accounts WHERE id = account_id) < money_amount)
        THEN ROLLBACK;
        ELSE
			UPDATE accounts SET balance = balance - money_amount WHERE id = account_id;
            COMMIT;
		END IF;
END
$$
DELIMITER ;

# 14. Money Transfer

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF (
		(SELECT count(a.id) FROM accounts as a WHERE a.id = from_account_id) != 1 OR
        (SELECT count(a.id) FROM accounts as a WHERE a.id = to_account_id) != 1 OR
        amount < 0 OR from_account_id = to_account_id OR
        (SELECT balance FROM accounts WHERE id = from_account_id) < amount
	)	THEN ROLLBACK;
		ELSE
			UPDATE accounts SET balance = balance - amount WHERE id = from_account_id;
			UPDATE accounts SET balance = balance + amount WHERE id = to_account_id;
            COMMIT;
	END IF;
END
$$
DELIMITER ;

# 15. Log Accounts Trigger

CREATE TABLE logs (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    old_sum DECIMAL(19,4) NOT NULL,
    new_sum DECIMAL(19,4) NOT NULL
);

DELIMITER $$
CREATE TRIGGER tr_transaction_log
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs SET account_id = old.id, old_sum = old.balance, 
		new_sum = (SELECT balance FROM accounts WHERE id = old.id);
END
$$
 DELIMITER ;
 
DROP TRIGGER tr_transaction_log;
call usp_transfer_money(1,2,10);
SELECT * FROM logs;
 
# 16. Emails Trigger

SELECT date_format(current_timestamp(), '%b %e %Y at %l:%i:%s %p');

CREATE TABLE notification_emails (
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT NOT NULL,
    subject VARCHAR(100),
    body TEXT
);

DELIMITER $$
CREATE TRIGGER tr_notification_emails
BEFORE INSERT
ON logs
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails SET
			recipient = new.account_id,
            subject = concat('Balance change for account: ', new.account_id),
            body = concat('On ', date_format(current_timestamp(), '%b %e %Y at %l:%i:%s %p'),
					'AM your balance was changed from ', new.old_sum,
                    ' to ', new.new_sum, '.');
			
END
$$
DELIMITER ;

SELECT * FROM notification_emails;

