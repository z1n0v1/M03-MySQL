DROP DATABASE IF EXISTS gringotts;
DROP DATABASE IF EXISTS restaurant;
DROP DATABASE IF EXISTS soft_uni;

##
use restaurant;

# 01. Departments Info

SELECT e.department_id, count(e.id) as 'Number of employees' 
	FROM employees AS e GROUP BY e.department_id ORDER BY e.department_id;

# 02. Average Salary

SELECT e.department_id, round(avg(e.salary), 2) AS 'Average Salary'
	FROM employees AS e GROUP BY e.department_id ORDER BY e.department_id;

# 03. Minimum Salary

SELECT e.department_id, round(min(e.salary), 2) AS 'Min Salary'
	FROM employees AS e GROUP BY e.department_id HAVING `Min Salary` > 800 ORDER BY e.department_id;

# 04. Appetizers Count

SELECT count(p.id) FROM products AS p WHERE category_id = 2 AND price > 8;

# 05. Menu Prices

SELECT category_id, 
	round(avg(price), 2) AS 'Average Price', 
    round(min(price), 2) AS 'Cheapest Product',
    round(max(price), 2) AS 'Most Expensive Product'
    FROM products
    GROUP BY category_id ORDER BY category_id;

