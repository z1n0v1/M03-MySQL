ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY(id),
	CHANGE username username VARCHAR(30) CHARACTER SET latin1 NOT NULL UNIQUE;