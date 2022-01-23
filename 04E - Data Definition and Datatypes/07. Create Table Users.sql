DROP TABLE IF EXISTS users;
CREATE TABLE users (
		id BIGINT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(30) CHARACTER SET latin1 NOT NULL,
        password VARCHAR(26) CHARACTER SET latin1 NOT NULL,
        profile_picture MEDIUMBLOB,
        last_login_time TIMESTAMP,
        is_deleted BOOLEAN
);

INSERT INTO users (username, password) VALUES ('u1', 'p1' );
INSERT INTO users (username, password) VALUES ('u2', 'p1' );
INSERT INTO users (username, password) VALUES ('u3', 'p1' );
INSERT INTO users (username, password) VALUES ('u4', 'p1' );
INSERT INTO users (username, password) VALUES ('u5', 'p1' );