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
