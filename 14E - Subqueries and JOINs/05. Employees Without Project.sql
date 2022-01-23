SELECT e.employee_id, e.first_name FROM employees AS e
		WHERE (SELECT count(ep.project_id) FROM employees_projects as ep WHERE ep.employee_id = e.employee_id) = 0
        ORDER BY e.employee_id DESC
        LIMIT 3;

# Alternative solution

	SELECT e.employee_id, e.first_name FROM employees AS e
		LEFT JOIN employees_projects as ep ON e.employee_id = ep.employee_id
        WHERE ep.project_id IS NULL
		ORDER BY e.employee_id DESC
        LIMIT 3;