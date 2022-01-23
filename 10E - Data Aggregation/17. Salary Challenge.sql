SELECT e.first_name, e.last_name, e.department_id
	FROM employees as e
    WHERE salary >
		(SELECT avg(salary) FROM employees WHERE department_id = e.department_id)
	ORDER BY department_id, employee_id
    LIMIT 10;