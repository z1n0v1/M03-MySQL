SELECT e.employee_id, e.first_name,
		CASE
			WHEN year(p.start_date) < 2005 THEN p.name
            ELSE NULL
		END AS 'project_name'
		FROM employees as e
        JOIN employees_projects as ep USING(employee_id)
        JOIN projects as p USING(project_id)
        WHERE e.employee_id = 24
        ORDER BY p.name;