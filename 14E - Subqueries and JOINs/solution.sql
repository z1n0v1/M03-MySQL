DROP DATABASE IF EXISTS soft_uni;
DROP DATABASE IF EXISTS geography;

USE soft_uni;

# 01. Employee Address

SELECT e.employee_id, e.job_title, e.address_id, a.address_text
	FROM employees AS e
    JOIN addresses AS a ON a.address_id = e.address_id
    ORDER BY address_id ASC LIMIT 5;
    
    # 02. Addresses with Towns
    
    SELECT e.first_name, e.last_name, t.name AS 'town', a.address_text
		FROM employees AS e
        JOIN addresses as a ON e.address_id = a.address_id
        JOIN towns as t ON a.town_id = t.town_id
        ORDER BY e.first_name ASC, e.last_name
        LIMIT 5;
    
    # 03. Sales Employee
    
    SELECT e.employee_id, e.first_name, e.last_name, d.name AS 'department_name'
		FROM employees AS e
		JOIN departments AS d ON e.department_id = d.department_id
		WHERE d.name = 'Sales'
		ORDER BY e.employee_id DESC;
    
    # 04. Employee Departments
    
    SELECT e.employee_id, e.first_name, e.salary, d.name AS 'department_name'
		FROM employees AS e
        JOIN departments AS d ON e.department_id = d.department_id
        WHERE e.salary > 15000
        ORDER BY d.department_id DESC
        LIMIT 5;
    
    # 05. Employees Without Project
    
    SELECT e.employee_id, e.first_name FROM employees AS e
		WHERE (SELECT count(ep.project_id) FROM employees_projects as ep WHERE ep.employee_id = e.employee_id) = 0
        ORDER BY e.employee_id DESC
        LIMIT 3;
        
	SELECT e.employee_id, e.first_name FROM employees AS e
		LEFT JOIN employees_projects as ep ON e.employee_id = ep.employee_id
        WHERE ep.project_id IS NULL
		ORDER BY e.employee_id DESC
        LIMIT 3;
    
    # 06. Employees Hired After
    
    SELECT e.first_name, e.last_name, e.hire_date, d.name AS 'dept_name'
    FROM employees AS e
    JOIN departments AS d USING (department_id)
    WHERE e.hire_date >'1999-01-01' AND d.name IN ("Sales", "Finance")
    ORDER BY e.hire_date;
    
    # 07. Employees with Project
    
    SELECT e.employee_id, e.first_name, p.name AS 'project_name'
		FROM employees AS e
        JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN projects AS p ON ep.project_id = p.project_id
        WHERE DATE(p.start_date) > '2002-08-13' AND p.end_date IS NULL
        ORDER BY e.first_name ASC, p.name ASC
        LIMIT 5;
    
    # 08. Employee 24
    
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
        
        # 09. Employee Manager
        
SELECT e.employee_id, e.first_name, e.manager_id,
		(SELECT first_name FROM employees WHERE employee_id = e.manager_id) AS manager_name
	FROM employees AS e
    WHERE e.manager_id IN (3, 7)
    ORDER BY e.first_name;
    
# 10. Employee Summary

SELECT e.employee_id, concat_ws(' ', first_name, last_name) AS 'employee_name',
		(SELECT concat_ws(' ', first_name, last_name) FROM employees WHERE employee_id = e.manager_id) AS manager_name,
		d.name AS 'department_name'
	FROM employees as e
    JOIN departments as d USING(department_id)
    WHERE e.manager_id IS NOT NULL
    ORDER BY e.employee_id
    LIMIT 5;

# 11. Min Average Salary

SELECT avg(salary) AS 'min_average_salary' 
	FROM employees 
    GROUP BY department_id 
    ORDER BY `min_average_salary` 
    LIMIT 1;

###
USE geography;

# 12. Highest Peaks in Bulgaria

SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
	FROM peaks AS p
    JOIN mountains AS m ON  m.id = p.mountain_id
    JOIN mountains_countries AS mc ON mc.mountain_id = m.id
    WHERE p.elevation > 2835 AND mc.country_code = 'BG'
    ORDER BY  p.elevation DESC;

# 13. Count Mountain Ranges

SELECT mc.country_code, COUNT(mc.mountain_id) AS 'mountain_range'
	FROM mountains_countries AS mc
	JOIN countries AS c USING(country_code)
	WHERE c.country_name IN ('United States', 'Russia', 'Bulgaria')
	GROUP BY country_code 
	ORDER BY `mountain_range` DESC;

# 14. Countries with Rivers

SELECT c.country_name, r.river_name
	FROM continents AS cn
	JOIN countries AS c USING(continent_code)
    LEFT JOIN countries_rivers AS cr USING(country_code)
    LEFT JOIN rivers AS r ON r.id = cr.river_id
    WHERE cn.continent_name = 'Africa'
    ORDER BY c.country_name
    LIMIT 5;

# 15. *Continents and Currencies

## This solution comes from https://github.com/Martin-BG/SoftUni-DatabaseBasics-MySQL/tree/master/07.%20Subqueries%20And%20Joins
## Should try to grok it maybe write my own....

SELECT 
    c.continent_code,
    c.currency_code,
    COUNT(*) AS 'currency_usage'
FROM
    `countries` AS c
GROUP BY c.continent_code , c.currency_code
HAVING `currency_usage` > 1
    AND `currency_usage` = (SELECT 
        COUNT(*) AS cn
    FROM
        `countries` AS c2
    WHERE
        c2.continent_code = c.continent_code
    GROUP BY c2.currency_code
    ORDER BY cn DESC
    LIMIT 1)
ORDER BY c.continent_code , c.continent_code;

# 16. Countries without any Mountains

SELECT count(c.country_code)
	FROM countries AS c
    LEFT JOIN mountains_countries as mc USING(country_code)
    WHERE mc.mountain_id IS NULL;

# 17. Highest Peak and Longest River by Country

SELECT c.country_name, max(p.elevation) AS 'highest_peak_elevation', max(r.length) AS 'longest_river_length'
	FROM countries AS c
    LEFT JOIN mountains_countries AS mc USING(country_code)
    LEFT JOIN peaks AS p USING(mountain_id)
    LEFT JOIN countries_rivers AS cr USING(country_code)
    LEFT JOIN rivers AS r ON cr.river_id = r.id
    GROUP BY c.country_name
    ORDER BY `highest_peak_elevation` DESC, `longest_river_length` DESC, c.country_name
    LIMIT 5;
