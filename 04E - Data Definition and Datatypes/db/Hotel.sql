CREATE DATABASE IF NOT EXISTS Hotel;
USE Hotel;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS room_status;
DROP TABLE IF EXISTS room_types;
DROP TABLE IF EXISTS bed_types;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS occupancies;

# employees (id, first_name, last_name, title, notes)

CREATE TABLE employees (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);

INSERT INTO employees (first_name, last_name) VALUES ('qwe', 'asd'), ('wer', 'sdf'), ('ert', 'dfg');

# customers (account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)

CREATE TABLE customers (
	account_number INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50),
    emergency_name VARCHAR(50),
    emergency_number VARCHAR(50),
    notes TEXT
);

INSERT INTO customers (first_name, last_name) VALUES ('qwe', 'asd'), ('wer', 'sdf'), ('ert', 'dfg');

# room_status (room_status, notes)

CREATE TABLE room_status (
	room_status INT NOT NULL PRIMARY KEY,
	notes TEXT
);

INSERT INTO room_status (room_status) VALUES (1), (2), (3);

# room_types (room_type, notes)

CREATE TABLE room_types (
	room_type INT NOT NULL PRIMARY KEY,
    notes TEXT
);

INSERT INTO room_types (room_type) VALUES (1), (2), (3);

# bed_types (bed_type, notes)

CREATE TABLE bed_types (
	bed_type INT NOT NULL PRIMARY KEY,
    notes TEXT
);

INSERT INTO bed_types (bed_type) VALUES (1), (2), (3);

# rooms (room_number, room_type, bed_type, rate, room_status, notes)

CREATE TABLE rooms (
	room_number INT NOT NULL PRIMARY KEY,
    room_type INT NOT NULL,
    bed_type VARCHAR(50),
    rate DECIMAL,
    room_status BOOLEAN,
    notes TEXT
);

INSERT INTO rooms (room_number, room_type) VALUES (1,1), (2,2), (3,3);

# payments (id, employee_id, payment_date, account_number, first_date_occupied, 
# last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)

CREATE TABLE payments (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    payment_date DATE,
    account_number INT NOT NULL,
    first_date_occupied DATE,
    last_date_occupied DATE,
    total_days INT,
    amount_charged DECIMAL,
    tax_rate DECIMAL,
    tax_amount DECIMAL,
    payment_total DECIMAL,
    notes TEXT
);

INSERT INTO payments (employee_id, account_number) VALUES (1,1), (1,2), (1,3);

# occupancies (id, employee_id, date_occupied, account_number, room_number, 
# rate_applied, phone_charge, notes)

CREATE TABLE occupancies (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    date_occupied DATE,
    account_number INT NOT NULL,
    room_number INT NOT NULL,
    rate_applied DECIMAL,
    phone_charge DECIMAL,
    notes TEXT
);

INSERT INTO occupancies (employee_id, account_number, room_number) VALUES (1,1,1), (2,2,2), (3,3,3);

----
DELETE FROM occupancies;
TRUNCATE TABLE occupancies;