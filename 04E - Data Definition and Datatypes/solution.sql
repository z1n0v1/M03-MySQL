CREATE DATABASE `minions`;
USE `minions`;


-- 1 CREATE TABLES
DROP TABLE IF EXISTS `minions`;
CREATE TABLE `minions` (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`name` VARCHAR(45),
    age VARCHAR(45)
    );

DROP TABLE IF EXISTS `towns`;
CREATE TABLE `towns` (
	town_id INT PRIMARY KEY,
    `name` VARCHAR(45)
);

-- 2 ALTER minion TABLE
ALTER TABLE `towns` RENAME COLUMN `town_id` TO `id`;
------------
ALTER TABLE `minions` ADD COLUMN `town_id` INT;
ALTER TABLE `minions` ADD FOREIGN KEY(`town_id`) REFERENCES `towns`(id);
------------
INSERT INTO `towns` VALUES (1, 'Sofia');
INSERT INTO `towns` VALUES (2, 'Plovdiv');
INSERT INTO `towns` VALUES (3, 'Varna');

INSERT INTO `minions` VALUES(1, 'Kevin', 22, 1);
INSERT INTO `minions` VALUES(2, 'Bob', 15, 3);
INSERT INTO `minions` VALUES(3, 'Steward', NULL, 2);
----------
TRUNCATE TABLE `minions`;
----------
DROP TABLE IF EXISTS `minions`, `towns`;
----------
DROP TABLE IF EXISTS `people`;
CREATE TABLE people (
		id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(200) CHARACTER SET utf8mb4 NOT NULL,
        picture MEDIUMBLOB,
        height DECIMAL(10,2),
        weight DECIMAL(10,2),
        gender SET('m', 'f') NOT NULL,
        birthdate DATE NOT NULL,
        biography TEXT CHARACTER SET utf8mb4
);

INSERT INTO people (name, gender, birthdate) VALUES ( 'n1', 'm', '1980-1-1');
INSERT INTO people (name, gender, birthdate) VALUES ( 'n2', 'm', '1980-1-1');
INSERT INTO people (name, gender, birthdate) VALUES ( 'n3', 'm', '1980-1-1');
INSERT INTO people (name, gender, birthdate) VALUES ( 'n4', 'm', '1980-1-1');
INSERT INTO people (name, gender, birthdate) VALUES ( 'n5', 'm', '1980-1-1');

----------

DROP TABLE IF EXISTS users;
CREATE TABLE users (
		id BIGINT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(30) CHARACTER SET latin1 NOT NULL,
        password VARCHAR(26) CHARACTER SET latin1 NOT NULL,
        profile_picture MEDIUMBLOB,
        last_login_time TIMESTAMP,
        is_deleted BOOLEAN
);

INSERT INTO users (username, password) VALUES ('u1', 'p1' );
INSERT INTO users (username, password) VALUES ('u2', 'p1' );
INSERT INTO users (username, password) VALUES ('u3', 'p1' );
INSERT INTO users (username, password) VALUES ('u4', 'p1' );
INSERT INTO users (username, password) VALUES ('u5', 'p1' );

--------------

ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY(id, username);

-------------

ALTER TABLE users CHANGE last_login_time last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

------------

-- ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY(id);
-- ALTER TABLE users CHANGE username username VARCHAR(30) CHARACTER SET latin1 NOT NULL UNIQUE;

ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY(id), 
	CHANGE username username VARCHAR(30) CHARACTER SET latin1 NOT NULL UNIQUE;
    
----------

#---- 11. Movies Database

DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
USE movies;

CREATE TABLE directors (
		id INT PRIMARY KEY AUTO_INCREMENT,
		director_name VARCHAR(50) NOT NULL,
        notes TEXT
);
INSERT INTO directors (director_name) VALUES ('d1'),('d2'),('d3'),('d4'),('d5');

CREATE TABLE genres (
		id INT PRIMARY KEY AUTO_INCREMENT,
        genre_name VARCHAR(50) NOT NULL,
        notes TEXT
);
INSERT INTO genres (genre_name) VALUES ('g1'), ('g2'), ('g3'), ('g4'), ('g5');

CREATE TABLE categories (
		id INT PRIMARY KEY AUTO_INCREMENT,
        category_name VARCHAR(50) NOT NULL,
        notes TEXT
);

INSERT INTO categories (category_name) VALUES ('c1'), ('c2'), ('c3'), ('c4'), ('c5');

CREATE TABLE movies (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT,
    copyright_year YEAR,
    length INT,
    genre_id INT,
    category_id INT,
    rating DOUBLE,
    notes TEXT
);

INSERT INTO movies (title) VALUES ('t1'), ('t2'), ('t3'), ('t4'), ('t5');

#---- 12. Car Rental Database

DROP DATABASE IF EXISTS car_rental;
CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
    daily_rate DECIMAL,
    weekly_rate DECIMAL,
    montly_rate DECIMAL,
    weekend_rate DECIMAL
);

INSERT INTO categories (category) VALUES ('c1'), ('c1'), ('c1');

CREATE TABLE cars (
	id INT PRIMARY KEY AUTO_INCREMENT,
    plate_number VARCHAR(50) NOT NULL,
    make VARCHAR(50),
    model VARCHAR(50),
    car_year YEAR,
    category_id INT,
    doors INT,
    picture BLOB,
    car_condition VARCHAR(50),
    available BOOL
);

INSERT INTO cars(plate_number) VALUES ('12341'),('12341'),('12341');

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);

INSERT INTO employees (first_name, last_name) VALUES ('a', 'b'),('a', 'b'),('a', 'b');

CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    driver_licence_number VARCHAR(50) NOT NULL,
    full_name VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    zip_code INT,
    notes TEXT
);

INSERT INTO customers (driver_licence_number) VALUES ('dq2324'),('dq2324'),('dq2324');

CREATE TABLE rental_orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(50),
    tank_level DOUBLE,
    kilometrage_start INT,
    kilometrage_end INT,
    total_kilometrage INT,
    start_date DATE,
    end_date DATE,
    total_days INT,
    rate_applied DECIMAL,
    tax_rate DECIMAL,
    order_status VARCHAR(50),
    notes TEXT
);
    
INSERT INTO rental_orders (employee_id, customer_id, car_id) VALUES (1,1,1),(1,1,1),(1,1,1);

#---- 13. Basic Insert

DROP DATABASE IF EXISTS soft_uni;
CREATE DATABASE soft_uni;
USE soft_uni;

CREATE TABLE towns (
	id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(50)
);

CREATE TABLE addresses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    address_text TEXT,
    town_id INT,
    CONSTRAINT fk_address_town FOREIGN KEY(town_id) REFERENCES towns(id)
);

CREATE TABLE departments(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10,2),
    address_id INT,
    CONSTRAINT fk_employees_department FOREIGN KEY(department_id) REFERENCES departments(id),
    CONSTRAINT fk_employees_address FOREIGN KEY(address_id) REFERENCES addresses(id)
);

SELECT * FROM departments;

INSERT INTO towns (name) VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');
INSERT INTO departments (name) VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');
INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary) VALUES
					('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500),
					('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000),
					('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
					('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000),
					('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);
		
#---- 14. Basic Select All Fields

SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

#---- 15. Basic Select All Fields and Order Them

SELECT * FROM towns ORDER BY name;
SELECT * FROM departments ORDER BY name;
SELECT * FROM employees ORDER BY salary DESC;

#---- 16. Basic Select Some Fields

SELECT name FROM towns ORDER BY name;
SELECT name FROM departments ORDER BY name;
SELECT first_name, last_name, job_title, salary FROM employees ORDER BY salary DESC;

#---- 17. Increase Employees Salary

UPDATE employees SET salary = salary * 1.1;
SELECT salary FROM employees;

#---- 18. Delete All Records

TRUNCATE TABLE occupancies;