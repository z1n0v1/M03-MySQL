CREATE TABLE IF NOT EXISTS high_paid_employees AS SELECT * FROM employees WHERE salary > 30000;
DELETE FROM high_paid_employees WHERE manager_id = 42;
UPDATE high_paid_employees SET salary = salary + 5000 where department_id = 1;

SELECT department_id, avg(salary)
	FROM high_paid_employees
    GROUP BY department_id
    ORDER BY department_id;