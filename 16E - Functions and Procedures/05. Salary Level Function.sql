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