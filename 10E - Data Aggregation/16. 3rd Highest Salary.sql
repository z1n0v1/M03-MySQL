SELECT e.department_id,
	(SELECT salary FROM employees
			WHERE department_id = e.department_id
            GROUP BY salary
            ORDER BY salary
            DESC LIMIT 2,1) AS 'third_highest_salary'
	FROM employees AS e
    GROUP BY e.department_id
    HAVING `third_highest_salary` IS NOT NULL
    ORDER BY e.department_id;