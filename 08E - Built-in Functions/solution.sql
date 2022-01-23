# Cleean up
DROP DATABASE IF EXISTS diablo;
DROP DATABASE IF EXISTS geography;
DROP DATABASE IF EXISTS orders;
DROP DATABASE IF EXISTS soft_uni;

## Part I – Queries for SoftUni Database
USE soft_uni;

# 01. Find Names of All Employees by First Name

SELECT first_name, last_name FROM employees WHERE  first_name LIKE 'Sa%' ORDER BY employee_id;

# 02. Find Names of All Employees by Last Name

SELECT first_name, last_name FROM employees WHERE lower(last_name) LIKE "%ei%" ORDER BY employee_id;

# 03. Find First Names of All Employees

SELECT first_name FROM employees WHERE department_id IN (3, 10) 
	AND year(hire_date) >= 1995 AND year(hire_date) <= 2005 ORDER BY employee_id;
    
# 04. Find All Employees Except Engineers

SELECT first_name, last_name FROM employees WHERE lower(job_title) NOT LIKE "%engineer%" ORDER BY employee_id;

# 05. Find Towns with Name Length

SELECT name FROM towns WHERE char_length(name) IN (5, 6) ORDER BY name ASC;

# 06. Find Towns Starting With

SELECT town_id, name FROM towns WHERE lower(left(name, 1)) IN ('m', 'k', 'b', 'e') ORDER BY name;

# 07. Find Towns Not Starting With

SELECT town_id, name FROM towns WHERE lower(left(name, 1)) NOT IN ('r', 'b', 'd') ORDER BY name;

# 08. Create View Employees Hired After

CREATE VIEW v_employees_hired_after_2000 AS
	SELECT first_name, last_name FROM employees WHERE year(hire_date) > 2000;
SELECT * FROM v_employees_hired_after_2000;

# 09. Length of Last Name

SELECT first_name, last_name FROM employees WHERE char_length(last_name) = 5;

## Part II – Queries for Geography Database
USE geography;

# 10. Countries Holding 'A'

SELECT country_name, iso_code FROM countries WHERE lower(country_name) LIKE "%a%a%a%" ORDER BY iso_code;

SELECT country_name, iso_code FROM countries WHERE 
	char_length(country_name) - char_length(replace(lower(country_name), 'a', '')) >= 3 ORDER BY iso_code;
    
# 11. Mix of Peak and River Names

SELECT 
    p.peak_name,
    r.river_name,
    LOWER(CONCAT(p.peak_name, SUBSTRING(r.river_name, 2))) AS mix
FROM
    peaks AS p,
    rivers AS r
WHERE
    LOWER(LEFT(r.river_name, 1)) = LOWER(RIGHT(p.peak_name, 1))
ORDER BY mix;

## Part III – Queries for Diablo Database
USE diablo;

# 12. Games From 2011 and 2012 Year

SELECT name, date_format(start, '%Y-%m-%d') as start
    FROM games WHERE year(start) in (2011, 2012)
    ORDER BY start, name LIMIT 50;

# 13. User Email Providers

SELECT user_name,
	substr(email,locate('@', email) + 1) AS 'Email Provider' FROM users ORDER BY `Email Provider`, user_name;
    
# 14. Get Users with IP Address Like Pattern

SELECT user_name, ip_address FROM users WHERE ip_address LIKE "___.1%.%.___" ORDER BY user_name;

# 15. Show All Games with Duration

SELECT 
    name AS game,
    IF(HOUR(start) < 12,
        'Morning',
        IF(HOUR(start) < 18,
            'Afternoon',
            'Evening')) AS 'Part of the Day',
    IF(duration <= 3,
        'Extra Short',
        IF(duration <= 6,
            'Short',
            IF(duration <= 10, 'Long', 'Extra Long'))) AS 'Duration'
FROM
    games;

 ### Alternative :
 
 SELECT 
    `name` AS 'game',
    CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    `games`
ORDER BY `name`;

#### Part IV – Date Functions Queries
use orders;

# 16. Orders Table

SELECT product_name, order_date, 
date_add(order_date, INTERVAL 3 DAY) AS pay_due,
date_add(order_date, INTERVAL 1 MONTH) AS deliver_due
FROM orders;
