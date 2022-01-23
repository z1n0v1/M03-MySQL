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