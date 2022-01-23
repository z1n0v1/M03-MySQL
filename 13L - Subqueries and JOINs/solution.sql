
DROP DATABASE IF EXISTS soft_uni;

USE soft_uni;

# 01. Managers

SELECT e.employee_id, concat_ws(" ", e.first_name, e.last_name) AS "full_name",
		d.department_id, d.name AS "department_name"
	FROM employees AS e
    INNER JOIN departments as d ON d.manager_id = e.employee_id
    ORDER BY e.employee_id LIMIT 5;

# 02. Towns and Addresses

SELECT a.town_id, t.name AS 'town_name', a.address_text
	FROM addresses AS a
    JOIN towns AS t ON a.town_id = t.town_id
    WHERE t.name IN ('San Francisco', 'Sofia', 'Carnation')
    ORDER BY a.town_id, a.address_id;

# 03. Employees Without Managers

SELECT employee_id, first_name, last_name, department_id, salary
	FROM employees
    WHERE manager_id IS NULL;
    
# 04. High Salary

SELECT count(employee_id) FROM employees WHERE salary > (SELECT avg(salary) FROM employees);

