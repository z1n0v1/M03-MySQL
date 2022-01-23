SELECT e.department_id, count(e.id) as 'Number of employees'
	FROM employees AS e GROUP BY e.department_id ORDER BY e.department_id;