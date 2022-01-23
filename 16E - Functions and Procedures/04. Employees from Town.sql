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
