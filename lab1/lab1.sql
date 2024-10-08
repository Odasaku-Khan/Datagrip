CREATE DATABASE LAB1;
CREATE TABLE users
(
    id     integer,
    firstname   varchar(50),
    secondname varchar(50),
    PRIMARY KEY (id)
);
SELECT * FROM users;

alter table users
ADD isadmin integer;

alter table users
alter column isadmin type  boolean
using isadmin :: boolean;

insert into users(id,firstname,secondname,isadmin)
values
    (0 ,'Oda','Sakunoske',false),
    (1,'Dazai','Osamu',true);

alter table users
alter column isadmin set default false;

create table tasks(
    id integer,
    name varchar(50),
    user_id integer,
    primary key (id)
);

drop table tasks;
drop table users;

drop database LAB1;