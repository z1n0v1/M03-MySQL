CREATE DATABASE car_rental;
USE car_rental;

------------------
-----------------
------------

DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS rental_orders;

----

#  categories (id, category, daily_rate, weekly_rate, monthly_rate, weekend_rate)

CREATE TABLE categories (
	id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    daily_rate DECIMAL,
    weekly_rate DECIMAL,
    monthly_rate DECIMAL,
    weekend_rate DECIMAL
);

INSERT INTO categories (category) VALUES ("c1"), ("c2"), ("c3");

# cars (id, plate_number, make, model, car_year, category_id, doors, picture, 
# car_condition, available)
    
CREATE TABLE cars (
	id INT AUTO_INCREMENT PRIMARY KEY,
    plate_number VARCHAR(50) NOT NULL,
    make VARCHAR(50),
    model VARCHAR(50),
    car_year YEAR,
    category_id INT,
    doors INT,
    picture BLOB,
    car_condition VARCHAR(50),
    available BOOLEAN
);

INSERT INTO cars (plate_number) VALUES ("213"), ("234"), ("345");

# employees (id, first_name, last_name, title, notes)

CREATE TABLE employees (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);

INSERT INTO employees (first_name, last_name)
	VALUES ("abc", "def"), ("qwe", "asd"), ("wer", "sdf");

# customers (id, driver_licence_number, full_name, address, city, zip_code, notes)

CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    driver_licence_number VARCHAR(50) NOT NULL,
    full_name VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    zip_code INT,
    notes TEXT
);

INSERT INTO customers (driver_licence_number) VALUES ('213321'), ('243324'), ('4354435');

# rental_orders (id, employee_id, customer_id, car_id, car_condition, tank_level, 
# kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, 
# rate_applied, tax_rate, order_status, notes)

CREATE TABLE rental_orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(50),
    tank_level INT,
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
    
INSERT INTO rental_orders (employee_id, customer_id, car_id) VALUES (1,1,1), (2,2,2), (3,3,3);
