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
