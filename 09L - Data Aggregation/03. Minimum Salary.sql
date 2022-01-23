SELECT e.department_id, round(min(e.salary), 2) AS 'Min Salary'
	FROM employees AS e GROUP BY e.department_id HAVING `Min Salary` > 800 ORDER BY e.department_id;