CREATE DATABASE IF NOT EXISTS soft_uni;
USE soft_uni;

DROP TABLES IF EXISTS towns, addresses, departments, employees;

# towns (id, name)

CREATE TABLE towns (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO towns (name) VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

# addresses (id, address_text, town_id)

CREATE TABLE addresses (
	id INT AUTO_INCREMENT PRIMARY KEY,
    address_text TEXT,
    town_id INT NOT NULL
);

# departments (id, name)

CREATE TABLE departments (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO departments (name) VALUES ('Engineering'), ('Sales'), ('Marketing'),
	('Software Development'), ('Quality Assurance');

# employees (id, first_name, middle_name, last_name, job_title, 
# department_id, hire_date, salary, address_id)

CREATE TABLE employees (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    address_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
	VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 
    (SELECT id FROM departments WHERE name = 'Software Development'), '2013/02/01', 3500.00),
    ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 
    (SELECT id FROM departments WHERE name = 'Engineering'), '2004/03/02', 4000.00),
    ('Maria', 'Petrova', 'Ivanova', 'Intern', 
    (SELECT id FROM departments WHERE name = 'Quality Assurance'), '2016/08/28', 525.25),
    ('Georgi', 'Terziev', 'Ivanov', 'CEO', 
    (SELECT id FROM departments WHERE name = 'Sales'), '2007/12/09', 3000.00),
    ('Peter', 'Pan', 'Pan', 'Intern', 
    (SELECT id FROM departments WHERE name = 'Marketing'), '2016/08/28', 599.88);
    
    --------------------
    
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT * FROM towns ORDER BY name ASC;
SELECT * FROM departments ORDER BY name ASC;
SELECT * FROM employees ORDER BY salary DESC;

SELECT name FROM towns ORDER BY name ASC;
SELECT name FROM departments ORDER BY name ASC;
SELECT first_name, last_name, job_title, salary FROM employees ORDER BY salary DESC;


UPDATE employees SET salary = salary * 1.1;
SELECT salary FROM employees;