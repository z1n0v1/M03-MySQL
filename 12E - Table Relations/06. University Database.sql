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