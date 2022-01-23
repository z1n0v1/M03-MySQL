DROP DATABASE IF EXISTS geography;

USE geography;

# 01. One-To-One Relationship

CREATE TABLE passports (
	passport_id INT UNIQUE NOT NULL PRIMARY KEY,
    passport_number VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO passports (passport_id, passport_number) VALUES
		(101, 'N34FG21B'),
		(102, 'K65LO4R7'),
		(103, 'ZE657QP2');

CREATE TABLE people (
	person_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    salary DECIMAL(10,2) ,
    passport_id INT UNIQUE NOT NULL,
    CONSTRAINT fk_passports FOREIGN KEY (passport_id) REFERENCES passports(passport_id)
);

INSERT INTO people (first_name, salary, passport_id)
	VALUES
		( 'Roberto', 43300.00, 102),
        ( 'Tom', 56100.00, 103),
        ( 'Yana', 60200.00, 101);

# 02. One-To-Many Relationship

CREATE TABLE manufacturers (
	manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    established_on DATE
);

INSERT INTO manufacturers (name, established_on) VALUES
		('BMW', '1916-03-01'),
		('Tesla', '2003-01-01'),
		('Lada', '1966-05-01');

CREATE TABLE models (
	model_id INT UNIQUE NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    manufacturer_id INT NOT NULL,
    CONSTRAINT fk_manufacturers FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO models (model_id, name, manufacturer_id) VALUES
		(101, 'X1', 1),
		(102, 'i6', 1),
		(103, 'Model S', 2),
		(104, 'Model X', 2),
		(105, 'Model 3', 2),
		(106, 'Nova', 3);
    
# 03. Many-To-Many Relationship

CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO students (name) VALUES
		('Mila'),
		('Toni'),
		('Ron');

CREATE TABLE exams (
	exam_id INT NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO exams (exam_id, name) VALUES
		(101, 'Spring MVC'),
		(102, 'Neo4j'),
		(103, 'Oracle 11g');
        
CREATE TABLE students_exams (
	student_id INT NOT NULL,
    exam_id INT NOT NULL,
    CONSTRAINT pk_students_exams 
	PRIMARY KEY (student_id, exam_id),
    CONSTRAINT fk_students FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fl_exams FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students_exams (student_id, exam_id) VALUES
		(1, 101),
		(1, 102),
		(2, 101),
		(3, 103),
		(2, 102),
		(2, 103);

# 04. Self-Referencing

CREATE TABLE teachers (
	teacher_id INT NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manager_id INT,
    CONSTRAINT fk_manager FOREIGN KEY(manager_id) REFERENCES teachers(teacher_id)
);

INSERT INTO teachers VALUES
	(101, 'John', NULL),
    (105, 'Mark', 101),
	(106, 'Greta', 101),
	(102, 'Maya', 106),
	(103, 'Silvia', 106),
	(104, 'Ted', 105);
	
# 05. Online Store Database
  
	DROP DATABASE IF EXISTS online_store;
    CREATE DATABASE IF NOT EXISTS online_store;
    USE online_store;
    
    CREATE TABLE item_types (
		item_type_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50)
	);
    
    CREATE TABLE items (
		item_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        item_type_id INT(11),
        CONSTRAINT fk_item_type FOREIGN KEY(item_type_id) REFERENCES item_types(item_type_id)
	);
    
    CREATE TABLE cities (
		city_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50)
	);
    
    CREATE TABLE customers (
		customer_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50),
        birthday DATE,
        city_id INT(11),
        CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES cities(city_id)
	);
    
    CREATE TABLE orders (
		order_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        customer_id INT(11) NOT NULL,
        CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
	);
    
    CREATE TABLE order_items (
		order_id INT(11) NOT NULL,
        item_id INT(11) NOT NULL,
        CONSTRAINT pk_order_items PRIMARY KEY(order_id, item_id),
        CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
        CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES items(item_id)
	);
    
# 06. University Database

DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;

CREATE TABLE majors (
	major_id INT(11) UNIQUE NOT NULL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE students (
	student_id  INT(11) UNIQUE NOT NULL PRIMARY KEY,
    student_number VARCHAR(12),
    student_name VARCHAR(50),
    major_id INT(11),
    CONSTRAINT fk_major FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

CREATE TABLE payments (
	payment_id INT UNIQUE NOT NULL PRIMARY KEY,
    payment_date DATE,
    payment_amount DECIMAL(8,2),
    student_id INT(11),
    CONSTRAINT fk_payments_student FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE subjects (
	subject_id INT UNIQUE NOT NULL PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE agenda (
	student_id  INT NOT NULL,
    subject_id INT NOT NULL,
    CONSTRAINT pk_agenda PRIMARY KEY (student_id, subject_id),
    CONSTRAINT fk_agenda_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);


## From geography
USE geography;
# 09. Peaks in Rila

SELECT m.mountain_range, p.peak_name, p.elevation AS 'peak_elevation'
	FROM peaks AS p
	JOIN mountains AS m ON m.id = p.mountain_id
    WHERE m.mountain_range = 'Rila'
    ORDER BY p.elevation DESC;
