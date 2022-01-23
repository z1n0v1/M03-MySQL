DROP DATABASE IF EXISTS camp;

USE camp;

# 01. Mountains and Peaks

CREATE TABLE mountains (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (id)
);

# 02. Trip Organization

SELECT driver_id, vehicle_type, concat_ws(' ', first_name, last_name) AS 'driver_name'
	FROM vehicles AS v JOIN campers AS c ON c.id = v.driver_id; 

# 03. SoftUni Hiking

SELECT starting_point as 'route_starting_point', end_point as 'route_ending_point',
	leader_id, 	concat_ws(' ', first_name, last_name) as leader_name
    FROM routes AS r JOIN campers AS c ON r.leader_id = c.id; 

# 04. Delete Mountains

DROP TABLE IF EXISTS peaks, mountains;

CREATE TABLE mountains (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks (
    id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT pk_peaks PRIMARY KEY (id),
    CONSTRAINT fk_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (id)
        ON DELETE CASCADE
);
    