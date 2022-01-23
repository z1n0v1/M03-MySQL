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