SELECT first_name FROM employees WHERE department_id IN (3, 10)
	AND year(hire_date) >= 1995 AND year(hire_date) <= 2005 ORDER BY employee_id;