SELECT e.employee_id, concat_ws(' ', first_name, last_name) AS 'employee_name',
		(SELECT concat_ws(' ', first_name, last_name)
		    FROM employees WHERE employee_id = e.manager_id) AS manager_name,
		d.name AS 'department_name'
	FROM employees as e
    JOIN departments as d USING(department_id)
    WHERE e.manager_id IS NOT NULL
    ORDER BY e.employee_id
    LIMIT 5;