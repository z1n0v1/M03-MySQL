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