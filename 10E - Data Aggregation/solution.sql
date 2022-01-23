## cleanup
DROP DATABASE IF EXISTS gringotts;
DROP DATABASE IF EXISTS soft_uni;

use gringotts;

# 01. Records’ Count

SELECT count(id) AS 'count' FROM wizzard_deposits;

# 02. Longest Magic Wand

SELECT max(magic_wand_size) AS 'longest_magic_wand' FROM wizzard_deposits;

# 03. Longest Magic Wand per Deposit Groups

SELECT deposit_group, max(magic_wand_size) AS 'longest_magic_wand' FROM wizzard_deposits
	GROUP BY deposit_group ORDER BY `longest_magic_wand`, deposit_group;
    
# 04. Smallest Deposit Group per Magic Wand Size

SELECT deposit_group FROM wizzard_deposits GROUP BY deposit_group ORDER BY avg(magic_wand_size) LIMIT 1;

# 05. Deposits Sum

SELECT deposit_group, round(sum(deposit_amount), 2) AS 'total_sum' FROM wizzard_deposits
	GROUP BY deposit_group ORDER BY `total_sum`;

# 06. Deposits Sum for Ollivander Family

SELECT deposit_group, round(sum(deposit_amount), 2) AS 'total_sum' FROM wizzard_deposits
	WHERE magic_wand_creator = 'Ollivander family' GROUP BY deposit_group ORDER BY deposit_group;

# 07. Deposits Filter

SELECT deposit_group, round(sum(deposit_amount), 2) AS 'total_sum' FROM wizzard_deposits
	WHERE magic_wand_creator = 'Ollivander family' GROUP BY deposit_group 
    HAVING `total_sum` < 150000 ORDER BY `total_sum` DESC;
    
# 08. Deposit Charge

SELECT deposit_group, magic_wand_creator, round(min(deposit_charge), 2) as 'min_deposit_charge' FROM  wizzard_deposits
	GROUP BY deposit_group, magic_wand_creator ORDER BY magic_wand_creator, deposit_group;

# 09. Age Groups

SELECT
	CASE
		WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
		ELSE '[61+]' 
	END AS 'age_group',
		count(id) AS 'wizard_count'
	FROM wizzard_deposits
    GROUP BY `age_group`
    ORDER BY `age_group`;

# 10. First Letter

SELECT DISTINCT
		left(first_name, 1) AS 'first_letter'
	FROM wizzard_deposits
    WHERE deposit_group = 'Troll Chest'
    ORDER BY `first_letter`;

# Alternative solution :

SELECT 
		left(first_name, 1) AS 'first_letter'
	FROM wizzard_deposits
    WHERE deposit_group = 'Troll Chest'
    GROUP BY `first_letter`
    ORDER BY `first_letter`;
    
# 11. Average Interest

SELECT
		deposit_group,
        is_deposit_expired,
        avg(deposit_interest)
	FROM wizzard_deposits
	WHERE deposit_start_date > '1985-01-01'
    GROUP BY deposit_group, is_deposit_expired
    ORDER BY deposit_group DESC, is_deposit_expired;

# !?!?! 12.	Rich Wizard, Poor Wizard* - not on judge(ment)

SELECT 
		hw.first_name AS 'host_wizard',
        hw.deposit_amount AS 'host_wizard_deposit', 
        gw.first_name AS 'guest_wizard',
        gw.deposit_amount AS 'guest_wizard',
        (hw.deposit_amount - gw.deposit_amount) AS 'difference'
	FROM wizzard_deposits AS hw, wizzard_deposits as gw
    WHERE hw.id + 1 = gw.id
    ORDER BY hw.id;

SELECT sum((hw.deposit_amount - gw.deposit_amount)) AS sum_difference
	FROM wizzard_deposits AS hw, wizzard_deposits as gw
    WHERE hw.id + 1 = gw.id;

## next on soft_uni db
USE soft_uni;

# 12. Employees Minimum Salaries

SELECT department_id, min(salary) FROM employees
	WHERE department_id IN (2,5,7) AND hire_date > '2000-01-01'
    GROUP BY department_id
    ORDER BY department_id;

# 13. Employees Average Salaries

CREATE TABLE IF NOT EXISTS high_paid_employees AS SELECT * FROM employees WHERE salary > 30000;
DELETE FROM high_paid_employees WHERE manager_id = 42;
UPDATE high_paid_employees SET salary = salary + 5000 where department_id = 1;

SELECT department_id, avg(salary) 
	FROM high_paid_employees
    GROUP BY department_id
    ORDER BY department_id;

# 14. Employees Maximum Salaries

SELECT department_id, max(salary) AS 'max_salary'
	FROM employees
	GROUP BY department_id
    HAVING `max_salary` NOT BETWEEN 30000 AND 70000
    ORDER BY department_id;

# 15. Employees Count Salaries

SELECT count(employee_id) FROM employees WHERE manager_id IS NULL;


# 16. 3rd Highest Salary

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

# 17. Salary Challenge

SELECT e.first_name, e.last_name, e.department_id
	FROM employees as e
    WHERE salary > 
		(SELECT avg(salary) FROM employees WHERE department_id = e.department_id)
	ORDER BY department_id, employee_id
    LIMIT 10;

# 18. Departments Total Salaries

SELECT e.department_id,
	(SELECT sum(salary) FROM employees WHERE department_id = e.department_id) as 'total_salary'
    FROM employees as e
    GROUP BY e.department_id
    ORDER BY e.department_id;

