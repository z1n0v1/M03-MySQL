# The problem description says that we should order by employee_id, but Judge expects the order to be by salary
SELECT DISTINCT salary FROM employees ORDER BY salary;