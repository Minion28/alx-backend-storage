-- create table users
-- id int not null auto increment primary key
-- email string of 255 chars not null unique
-- name string of 255 chars
-- country enum of countries US, CO, and TN not null default =US

CREATE TABLE IF NOT EXISTS users(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255),
	country ENUM('US', 'CO', 'TN') NOT NULL
);