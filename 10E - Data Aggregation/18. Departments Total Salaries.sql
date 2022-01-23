SELECT e.department_id,
	(SELECT sum(salary) FROM employees WHERE department_id = e.department_id) as 'total_salary'
    FROM employees as e
    GROUP BY e.department_id
    ORDER BY e.department_id;