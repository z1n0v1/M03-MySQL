CREATE DATABASE IF NOT EXISTS gamebar;
USE gamebar;

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    category_id INT NOT NULL
);

INSERT INTO employees (first_name, last_name) VALUES ('aa', 'ab'), ('cc', 'dd'), ('ee', 'ff');

ALTER TABLE employees ADD COLUMN middle_name VARCHAR(50);