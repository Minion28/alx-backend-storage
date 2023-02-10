-- create table users
-- id int not null auto increment primary key
-- email string of 255 chars not null unique
-- name string of 255 chars
-- country enum of countries US, CO, and TN not null default =US

create table if not exists users (
    id int not null auto_increment primary key,
    email varchar(255) not null unique,
    name varchar(255),
    country char(2) not null default 'US' check (country in ('US', 'CO', 'TN'))
);