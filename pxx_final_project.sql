create database pxx_final_project
-- access the database -> \c pxx_final_project

-- build tables off of the relational model
create table "user"
    (
        usr_id      serial     not null,
        usr_email       varchar(25)     not null,
        usr_password        varchar(25),
        usr_fname       varchar(15),
        usr_lname       varchar(15),
        usr_address_num       varchar(15),
        usr_city        varchar(15),
        usr_state       varchar(15),
        usr_zip         varchar(12),
        primary key (usr_id)
    );

--CLEAN DATA--
-- make temp tables, modify data in temp table --
-- copy from temp table to actual table -- 

-- Loading Data  --
        create table "test"
        (
            first_name   varchar(15), 
            last_name   varchar(15), 
            username   varchar(30),
            email   varchar(50), 
            street_address   varchar(50), 
            city_address   varchar(15), 
            state_address   varchar(15),
            usr_id      serial      not null,
            primary key (usr_id)
        );

-- This is how I access the file to copy into the test table --
\copy test(first_name, last_name, username, email, street_address, city_address, state_address) from '/Users/ppunch/Desktop/OSU/cs 340/final_project/final-project-Patrick-Punch/files/users.csv' delimiter ',' csv

delete from test
where first_name = 'first_name';

-- Determine max length of first_name attribute
select max(length(first_name)) as max_first_name_length from test;
-- Shows the names of the users with the longest first name
select t.first_name, x.max_first_name_length
from test as t
join(
SELECT max(length(first_name)) AS max_first_name_length FROM test) as x
on length(t.first_name) = x.max_first_name_length;

-- Determine max length of last_name attribute
select max(length(last_name)) as max_last_name_length from test;
-- Shows the names of the users with the longest last name
select t.first_name, t.last_name, x.max_last_name_length
from test as t
join(
SELECT max(length(last_name)) AS max_last_name_length FROM test) as x
on length(t.last_name) = x.max_last_name_length;

-- Determine max length of username attribute
select max(length(username)) as max_username_length from test;
-- Shows the usernames of the users with the longest username
select t.first_name, t.last_name, t.username, x.max_username_length
from test as t
join(
SELECT max(length(username)) AS max_username_length FROM test) as x
on length(t.username) = x.max_username_length;

-- Determine max length of email attribute
select max(length(email)) as max_email_length from test;
-- Shows the usernames of the users with the longest email
select t.first_name, t.last_name, t.email, x.max_email_length
from test as t
join(
SELECT max(length(email)) AS max_email_length FROM test) as x
on length(t.email) = x.max_email_length;

-- Determine max length of street_address attribute
select max(length(street_address)) as max_street_address_length from test;
-- Shows the usernames of the users with the longest street_address
select t.first_name, t.last_name, t.street_address, x.max_street_address_length
from test as t
join(
SELECT max(length(street_address)) AS max_street_address_length FROM test) as x
on length(t.street_address) = x.max_street_address_length;

-- Determine max length of city_address attribute
select max(length(city_address)) as max_city_address_length from test;
-- Shows the usernames of the users with the longest city_address
select t.first_name, t.last_name, t.city_address, x.max_city_address_length
from test as t
join(
SELECT max(length(city_address)) AS max_city_address_length FROM test) as x
on length(t.city_address) = x.max_city_address_length;

-- Determine max length of state_address attribute
select max(length(state_address)) as max_state_address_length from test;
-- Shows the usernames of the users with the longest state_address
select t.first_name, t.last_name, t.state_address, x.max_state_address_length
from test as t
join(
SELECT max(length(state_address)) AS max_state_address_length FROM test) as x
on length(t.state_address) = x.max_state_address_length;

select max(usr_id) from test;


-- SELECT * FROM test ORDER BY username DESC LIMIT 5;
-- select * from test where username = (select max(length(username)) from test);
-- SELECT * FROM test ORDER BY first_name DESC LIMIT 5;


-- Email filters 
--Selects from the emails we have and checks to see 
--if the start has proper values then checks after the @ symbol
SELECT email
FROM test
WHERE email !~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
--ads a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE test ADD CONSTRAINT unique_usr_email UNIQUE (email);
--finds the non unique emaisl that already exist and emails that valilate the code above
SELECT email, COUNT(*)
FROM test
GROUP BY email
HAVING COUNT(*) > 1;


--Name fixer
--checks to see if the name is already capitalized then uses the INITCAP function 
-- to change the first letter to a capitalized letter.
-- changes data from first_name to ProperFirstName and last_name to ProperLastName
SELECT INITCAP(first_name) as ProperFirstName, 
       INITCAP(last_name) as ProperLastName
FROM test;

