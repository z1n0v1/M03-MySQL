CREATE DATABASE movies;
USE movies;

#DROP TABLE IF EXISTS movies;
#DROP TABLE IF EXISTS directors;
CREATE TABLE directors (
	id INT NOT NULL AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT,
    PRIMARY KEY (id)
    );
    
INSERT INTO directors (director_name) VALUES ("d1");
INSERT INTO directors (director_name) VALUES ("d2");
INSERT INTO directors (director_name) VALUES ("d3");
INSERT INTO directors (director_name) VALUES ("d4");
INSERT INTO directors (director_name) VALUES ("d5");

#DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
	id INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    notes TEXT,
    PRIMARY KEY (id)
);

INSERT INTO genres (genre_name) VALUES("g1");
INSERT INTO genres (genre_name) VALUES("g2");
INSERT INTO genres (genre_name) VALUES("g3");
INSERT INTO genres (genre_name) VALUES("g4");
INSERT INTO genres (genre_name) VALUES("g5");

#DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id INT AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT,
    PRIMARY KEY (id)
);

INSERT INTO categories (category_name) VALUES("c1");
INSERT INTO categories (category_name) VALUES("c2");
INSERT INTO categories (category_name) VALUES("c3");
INSERT INTO categories (category_name) VALUES("c4");
INSERT INTO categories (category_name) VALUES("c5");

#DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT NOT NULL,
    copyright_year INT NOT NULL,
    length TIME NOT NULL,
    genre_id INT NOT NULL,
    category_id INT NOT NULL,
    rating INT,
    notes TEXT,
    PRIMARY KEY (id)
#    FOREIGN KEY (director_id) REFERENCES directors(id), ## Оттук гърмеше 4ти тест
 #   FOREIGN KEY (genre_id) REFERENCES genres(id),
  #  FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id)
	VALUES("m1", 1, 2000, '1:30:00', 1, 1);
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id)
	VALUES("m2", 1, 2000, '1:30:00', 2, 3);
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id)
	VALUES("m3", 1, 2000, '1:30:00', 2, 4);
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id)
	VALUES("m4", 1, 2000, '1:30:00', 3, 5);
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id)
	VALUES("m5", 1, 2000, '1:30:00', 4, 5);
