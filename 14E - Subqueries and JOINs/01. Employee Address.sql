SELECT e.employee_id, e.job_title, e.address_id, a.address_text
	FROM employees AS e
    JOIN addresses AS a ON a.address_id = e.address_id
    ORDER BY address_id ASC LIMIT 5;