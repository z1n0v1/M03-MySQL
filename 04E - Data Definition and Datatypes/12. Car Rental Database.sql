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
