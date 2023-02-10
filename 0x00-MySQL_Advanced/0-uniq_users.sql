--create table users
--id integer, not nulln auto increment primary key
--email string of 255 chars, not null unique
--name string of 255 chars

create table users (
    id int not null auto_increment primary key,
    email varchar(255) not null unique,
    name varchar(255)
);