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
