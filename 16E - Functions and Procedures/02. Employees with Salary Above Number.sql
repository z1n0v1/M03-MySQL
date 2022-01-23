DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above( above_salary DECIMAL(16,4))
BEGIN
	SELECT first_name, last_name FROM employees WHERE salary >= above_salary ORDER BY first_name, last_name, employee_id;
END
$$
DELIMITER ;

CALL usp_get_employees_salary_above(45000);
DROP PROCEDURE usp_get_employees_salary_above;