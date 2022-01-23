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