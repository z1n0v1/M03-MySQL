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