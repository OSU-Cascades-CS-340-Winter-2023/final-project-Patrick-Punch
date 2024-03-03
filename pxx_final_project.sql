create database pxx_final_project
-- access the database -> \c pxx_final_project -- 
-- copying data into a table: \copy table_name(attribute, columns, from, csv, file) from 'File Path' delimiter ',' csv


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

-- creating table services
create table services
    (
        services_id  varchar(50)
        services_name  varchar(100)
        services_brand   varchar(50)
        services_catagory  varchar(50)
        primary key(services_id)
    );

-- RELATIONAL MODEL TABLES --

create table company
    (
        company_id      varchar(50)     not null,
        company_name    varchar(50),
        contact         varchar(50),
        phone           varchar(50),
        company_email   varchar(100),
        company_url     varchar(100),
        primary key(company_id)
    );

create table item
    (
        item_id     varchar(50)     not null,
        item_type   varchar(50),
        item_name   varchar(50),
        item_description varchar(1000),
        item_price  float,
        item_picture    bytea,
        primary key(item_id)
    );

create table employee
    (
        emp_id         varchar(50)     not null,
        emp_email      varchar(50),
        emp_first_name varchar(50),
        emp_last_name  varchar(50),
        job_category   varchar(50),
        salary         int,
        street_address  varchar(100),
        emp_city       varchar(20),
        emp_state      varchar(15),
        emp_zip_code   varchar(10),
        primary key(emp_id)
    );

create table discount
    (
        discount_id     varchar(50)     not null,
        discount_type   varchar(50),
        discount_amount varchar(50),
        discount_description varchar(50),
        discount_start_date date,
        discount_end_date   date,
        primary key(discount_id)
    );

create table user_interests
    (
        usr_id      serial     not null,
        usr_interest varchar(50)     not null,
        primary key (usr_id, usr_interest),
        foreign key (usr_id) references "user"(usr_id)
    );

create table user_item_preference
    (
        usr_id      serial     not null,
        item_id      varchar(50)     not null,
        primary key (usr_id, item_id),
        foreign key (usr_id) references "user"(usr_id),
        foreign key (item_id) references item(item_id)
    );

create table user_company_preference
    (
        usr_id      serial     not null,
        preference_company_id   varchar(50)     not null,
        primary key (usr_id, preference_company_id),
        foreign key (usr_id) references "user"(usr_id),
        foreign key (preference_company_id) references company(company_id)
    );

create table user_location_preference
    (
        usr_id                      serial     not null,
        preference_location_city    varchar(20)     not null,
        preference_location_state   varchar(15)     not null,
        primary key(usr_id, preference_location_city, preference_location_state),
        foreign key (usr_id) references "user"(usr_id)
    );

create table company_location
    (
        company_id      varchar(50)     not null,
        location_id     varchar(50)     not null,
        company_address varchar(100),
        company_city    varchar(20),
        company_state   varchar(15),
        company_zip     varchar(10),
        company_pnum    varchar(15),
        primary key(location_id),
        foreign key(company_id) references company(company_id)
    );

create table company_item
    (
        company_id      varchar(50)     not null,
        item_id         varchar(50)     not null,
        discount_id     varchar(50)     not null,
        is_discounted   boolean,
        primary key(company_id, item_id),
        foreign key(company_id) references company(company_id),
        foreign key(item_id) references item(item_id),
        foreign key(discount_id) references discount(discount_id)
    );

create table user_company_review
    (
        company_id      varchar(50)     not null,
        usr_id          serial     not null,
        rating_score    int,
        comments        varchar(1000),
        foreign key(company_id) references company(company_id),
        foreign key (usr_id) references "user"(usr_id)
    );

create table user_checkin
    (
        checkin_id      varchar(50)     not null,
        checkin_date    date,
        usr_id          serial     not null,
        company_id      varchar(50)     not null,
        item_id         varchar(50)     not null,
        discount_id     varchar(50)     not null,
        primary key(checkin_id),
        foreign key(company_id) references company(company_id),
        foreign key(item_id) references item(item_id),
        foreign key(discount_id) references discount(discount_id)
    );

create table company_transaction
    (
        transaction_id      varchar(50)     not null,
        transaction_date    date,
        charge_type         varchar(50),
        transaction_amount  float,
        surcharge           float,
        total_charge        float GENERATED ALWAYS AS 
                            (CASE WHEN transaction_amount IS NULL THEN surcharge
                                WHEN surcharge IS NULL THEN transaction_amount
                                ELSE transaction_amount + surcharge END) STORED,
        tx_is_paid             boolean,
        paid_date           date,
        company_id      varchar(50)     not null,
        primary key(transaction_id),
        foreign key(company_id) references company(company_id)
    );

create table company_transaction_checkin
    (
        transaction_id      varchar(50)     not null,
        checkin_id          varchar(50)     not null,
        checkin_charge      float,
        primary key(transaction_id, checkin_id),
        foreign key(transaction_id) references company_transaction(transaction_id),
        foreign key(checkin_id) references user_checkin(checkin_id)
    );

--CLEAN DATA--
-- make temp tables, modify data in temp table --
-- copy from temp table to actual table, AFTER CLEANING DATA -- 

-- Loading Data  --
        create table test
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

-- load data iinto user_test table --
\copy user_test(first_name, last_name, username, email, street_address, city_address, state_address) from 'FilePath' delimiter ',' csv

\copy test(first_name, last_name, username, email, street_address, city_address, state_address) from 'FilePath' delimiter ',' csv

create table products_test
    (
        product_id      varchar(40),
        product_name    varchar(15000),
        product_brand   varchar(40),
        product_type    varchar(40),
        test_pkey      serial      not null,
        primary key (test_pkey)
    );

--load data into products_test table --
\copy products_test(product_id, product_name, product_brand, product_type) from 'FilePath' delimiter '|' csv


-- load in data from services.csv --
create table services_test
    (
        services_id varchar(50),
        services_name  varchar(100),
        services_brand varchar(50),
        services_catagory varchar(50),
        test_pkey       serial      not null,
        primary key(test_pkey)
    );

\copy services_test(services_id, services_name, services_brand, services_catagory) from 'FilePath' delimiter ',' csv

delete from test
where first_name = 'first_name';

-- Determine max length of first_name attribute
select max(length(first_name)) as max_first_name_length from user_test;
-- Shows the names of the users with the longest first name
select t.first_name, x.max_first_name_length
from user_test as t
join(
SELECT max(length(first_name)) AS max_first_name_length FROM user_test) as x
on length(t.first_name) = x.max_first_name_length;

-- Determine max length of last_name attribute
select max(length(last_name)) as max_last_name_length from user_test;
-- Shows the names of the users with the longest last name
select t.first_name, t.last_name, x.max_last_name_length
from user_test as t
join(
SELECT max(length(last_name)) AS max_last_name_length FROM user_test) as x
on length(t.last_name) = x.max_last_name_length;

-- Determine max length of username attribute
select max(length(username)) as max_username_length from user_test;
-- Shows the usernames of the users with the longest username
select t.first_name, t.last_name, t.username, x.max_username_length
from user_test as t
join(
SELECT max(length(username)) AS max_username_length FROM user_test) as x
on length(t.username) = x.max_username_length;

-- Determine max length of email attribute
select max(length(email)) as max_email_length from user_test;
-- Shows the usernames of the users with the longest email
select t.first_name, t.last_name, t.email, x.max_email_length
from user_test as t
join(
SELECT max(length(email)) AS max_email_length FROM user_test) as x
on length(t.email) = x.max_email_length;

-- Determine max length of street_address attribute
select max(length(street_address)) as max_street_address_length from user_test;
-- Shows the usernames of the users with the longest street_address
select t.first_name, t.last_name, t.street_address, x.max_street_address_length
from user_test as t
join(
SELECT max(length(street_address)) AS max_street_address_length FROM user_test) as x
on length(t.street_address) = x.max_street_address_length;

-- Determine max length of city_address attribute
select max(length(city_address)) as max_city_address_length from user_test;
-- Shows the usernames of the users with the longest city_address
select t.first_name, t.last_name, t.city_address, x.max_city_address_length
from user_test as t
join(
SELECT max(length(city_address)) AS max_city_address_length FROM user_test) as x
on length(t.city_address) = x.max_city_address_length;

-- Determine max length of state_address attribute
select max(length(state_address)) as max_state_address_length from user_test;
-- Shows the usernames of the users with the longest state_address
select t.first_name, t.last_name, t.state_address, x.max_state_address_length
from user_test as t
join(
SELECT max(length(state_address)) AS max_state_address_length FROM user_test) as x
on length(t.state_address) = x.max_state_address_length;

select max(usr_id) from user_test;


-- Email filters 
--Selects from the emails we have and checks to see 
--if the start has proper values then checks after the @ symbol
SELECT email
FROM test
WHERE email !~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
--ads a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE test ADD CONSTRAINT unique_usr_email UNIQUE (email);
--finds the non unique emails that already exist and emails that violate the code above
SELECT email, COUNT(*)
FROM test
GROUP BY email
HAVING COUNT(*) > 1;


---State/city name fixer
SELECT INITCAP(state_address) AS ProperState_address
FROM test;
UPDATE test
SET state_address = INITCAP(state_address);
ALTER TABLE test ADD CONSTRAINT unique_state UNIQUE (state_address);
SELECT state_address, COUNT(*)
FROM test
GROUP BY state_address
HAVING COUNT(*) > 1;

SELECT INITCAP(city_address) AS ProperCity_address
FROM test;
UPDATE test
SET city_address = INITCAP(city_address);
ALTER TABLE test ADD CONSTRAINT unique_city UNIQUE (city_address);
SELECT city_address, COUNT(*)
FROM test
GROUP BY city_address
HAVING COUNT(*) > 1;






--Name fixer
--checks to see if the name is already capitalized then uses the INITCAP function 
-- to change the first letter to a capitalized letter.
-- changes data from first_name to ProperFirstName and last_name to ProperLastName
SELECT  INITCAP(first_name) as ProperFirstName, 
        INITCAP(last_name) as ProperLastName
FROM test;


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


-- creating the products tables
create table "products"
(
    product_id = varchar(40) not null,
    product_name = varchar(150) not null,
    product_brand = varchar(40) not null,
    product_type = varchar(40) not null,
    primary key (product_id)
);

--test tables
create table "products_test"
(
    product_id = varchar(40) not null,
    product_name = varchar(150) not null,
    product_brand = varchar(40) not null,
    product_type = varchar(40) not null,
    primary key (product_id)
);
\copy products_test(product_id, product_name, product_brand, product_type) from 'File Path' delimiter '|' csv

-- creating table services
create table "services"
(
    service_id = varchar(50)
    service_name= varchar(100)
    service_brand = varchar(50)
    service_catagory = varchar(50)
    primary key(service_id)
);

--test table
create table "services_test"
(
    service_id = varchar(50)
    service_name= varchar(100)
    service_brand = varchar(50)
    service_catagory = varchar(50)
    primary key(service_id)
);

\copy services_test(service_id, service_name, service_brand, service_catagory) from 'File Path' delimiter ',' csv