DROP DATABASE IF EXISTS soft_uni;

USE soft_uni;

# 01. Count Employees by Town

DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := 
    (SELECT count(e.employee_id)
		FROM employees AS e
        JOIN addresses AS a USING(address_id)
		JOIN towns AS t USING(town_id)
		WHERE t.name = town_name);
        RETURN e_count;
END
$$

DELIMITER ;
DROP FUNCTION IF EXISTS ufn_count_employees_by_town;
USE soft_uni;
SELECT ufn_count_employees_by_town('Sofia');

# 02. Employees Promotion

DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE employees AS e
		JOIN departments AS d USING(department_id)
		SET e.salary = e.salary * 1.05
        #FROM employees AS e
        WHERE d.name = department_name;
END

DELIMITER ;
USE soft_uni;

DROP PROCEDURE IF EXISTS usp_raise_salaries;

SELECT e.first_name, e.salary
	FROM employees AS e
    JOIN departments AS d USING(department_id)
    WHERE d.name = 'Finance'
    ORDER BY e.first_name, e.salary;
CALL usp_raise_salaries('Finance');

# 03. Employees Promotion By ID

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	UPDATE employees as e
		SET e.salary = e.salary * 1.05
        WHERE e.employee_id = id;
END

DELIMITER ;
DROP PROCEDURE IF EXISTS usp_raise_salary_by_id;
CALL usp_raise_salary_by_id(99999);

# 04. Triggered

CREATE TABLE deleted_employees (
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    middle_name VARCHAR(20),
    job_title VARCHAR(50),
    department_id INT,
    salary DOUBLE
);

#DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
		VALUES(OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS tr_deleted_employees;
DROP TABLE IF EXISTS deleted_employees;



