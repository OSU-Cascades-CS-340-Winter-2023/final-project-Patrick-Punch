CREATE DATABASE pxx_final_project;
-- Remember to connect to the database using the appropriate command in your SQL client, e.g., \c pxx_final_project

-- Test Tables & Data Insertion
create table user_test
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
--loads user data into the user test table
\COPY user_test(first_name, last_name, username, email, street_address, city_address, state_address) FROM '/Users/ppunch/desktop/OSU/cs 340/final_project/final-project-Patrick-Punch/files/users.csv' WITH (FORMAT csv, DELIMITER ',', header true)

create table services_test
    (
        services_id varchar(50),
        services_name  varchar(100),
        services_brand varchar(50),
        services_category varchar(50),
        test_pkey       serial      not null,
        primary key(test_pkey)
    );
--load data into service_test table
\COPY services_test(services_id, services_name, services_brand, services_category) FROM '/Users/ppunch/desktop/OSU/cs 340/final_project/final-project-Patrick-Punch/files/services.csv' with (delimiter ',', format csv, header true)

create table products_test
    (
        product_id      varchar(40),
        product_name    varchar(300),
        product_brand   varchar(40),
        product_type    varchar(40),
        test_pkey      serial      not null,
        primary key (test_pkey)
    );
--load data into products_test table --
\COPY products_test(product_id, product_name, product_brand, product_type) FROM '/Users/ppunch/desktop/OSU/cs 340/final_project/final-project-Patrick-Punch/files/products.csv' delimiter '|' csv

--Determining data values for columns of the tables:



-- USER_TEST TABLE: 

-- Determine max length of first_name attribute
SELECT MAX(LENGTH(first_name)) AS max_first_name_length FROM user_test;
-- Shows the names of the users with the longest first name
SELECT t.first_name, x.max_first_name_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(first_name)) AS max_first_name_length FROM user_test) AS x
ON LENGTH(t.first_name) = x.max_first_name_length;

-- Determine max length of last_name attribute
SELECT MAX(LENGTH(last_name)) AS max_last_name_length FROM user_test;
-- Shows the names of the users with the longest last name
SELECT t.first_name, t.last_name, x.max_last_name_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(last_name)) AS max_last_name_length FROM user_test) AS x
ON LENGTH(t.last_name) = x.max_last_name_length;

-- Determine max length of username attribute
SELECT MAX(LENGTH(username)) AS max_username_length FROM user_test;
-- Shows the usernames of the users with the longest username
SELECT t.first_name, t.last_name, t.username, x.max_username_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(username)) AS max_username_length FROM user_test) AS x
ON LENGTH(t.username) = x.max_username_length;

-- Determine max length of email attribute
SELECT MAX(LENGTH(email)) AS max_email_length FROM user_test;
-- Shows the usernames of the users with the longest email
SELECT t.first_name, t.last_name, t.email, x.max_email_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(email)) AS max_email_length FROM user_test) AS x
ON LENGTH(t.email) = x.max_email_length;

-- Determine max length of street_address attribute
SELECT MAX(LENGTH(street_address)) AS max_street_address_length FROM user_test;
-- Shows the usernames of the users with the longest street_address
SELECT t.first_name, t.last_name, t.street_address, x.max_street_address_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(street_address)) AS max_street_address_length FROM user_test) AS x
ON LENGTH(t.street_address) = x.max_street_address_length;

-- Determine max length of city_address attribute
SELECT MAX(LENGTH(city_address)) AS max_city_address_length FROM user_test;
-- Shows the usernames of the users with the longest city_address
SELECT t.first_name, t.last_name, t.city_address, x.max_city_address_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(city_address)) AS max_city_address_length FROM user_test) AS x
ON LENGTH(t.city_address) = x.max_city_address_length;

-- Determine max length of state_address attribute
SELECT MAX(LENGTH(state_address)) AS max_state_address_length FROM user_test;
-- Shows the usernames of the users with the longest state_address
SELECT t.first_name, t.last_name, t.state_address, x.max_state_address_length
FROM user_test AS t
JOIN(
SELECT MAX(LENGTH(state_address)) AS max_state_address_length FROM user_test) AS x
ON LENGTH(t.state_address) = x.max_state_address_length;

SELECT MAX(usr_id) FROM user_test;



-- SERVICES_TEST TABLE

-- Determine the length of the services_id column
select max(length(services_id)) from services_test;

-- Determine the length of the services_name column
select max(length(services_name)) as max_svc_name
from services_test;
-- Shows the service with the max name length
select * from services_test as s
join 
(select max(length(services_name)) as max_svc_name
from services_test) as x
on length(s.services_name) = x.max_svc_name;

-- Determine the length of the services_brand column
select max(length(services_brand)) as max_brand
from services_test;
-- Shows the service with the max brand name length
select * from services_test as s
join 
(select max(length(services_brand)) as max_brand
from services_test) as x
on length(s.services_brand) = x.max_brand;

-- Determine the length of the services_category column
select max(length(services_category)) as max_cat
from services_test;
-- Shows the service with the max category name length
select * from services_test as s
join 
(select max(length(services_category)) as max_cat
from services_test) as x
on length(s.services_category) = x.max_cat;

-- PRODUCTS_TEST TABLE

-- Determine the length of the product_id column
SELECT MAX(LENGTH(product_id)) AS max_id_length FROM products_test;

-- Determine the max length of the product_name column
SELECT MAX(LENGTH(product_name)) AS max_name_length FROM products_test;
-- Shows the product with the max name length
select * from products_test as p
join
(SELECT MAX(LENGTH(product_name)) AS max_name_length FROM products_test) as x
on length(p.product_name) = x.max_name_length;

-- Determine the max length of the product_brand column
select max(length(product_brand)) as max_brand_length from products_test;
-- Shows the product with the max brand length
select * from products_test as p
join
(select max(length(product_brand)) as max_brand_length from products_test) as x
on length(p.product_brand) = x.max_brand_length;

-- Determine the max length of the product_type column
select max(length(product_type)) as max_type_length from products_test;
-- Shows the product with the max brand length
select * from products_test as p
join
(select max(length(product_type)) as max_type_length from products_test) as x
on length(p.product_type) = x.max_type_length;

--Cleaning data/ data scraping
-- Email filters 

--finds the non unique emails that already exist and emails that violate the code above
SELECT email, COUNT(*)
FROM user_test
GROUP BY email
HAVING COUNT(*) > 1;


DELETE from user_test
--Selects FROM the emails we have and checks to see 
--if the start has proper values then checks after the @ symbol
--!~* operator is used for case-insensitive negation of a regular expression match
WHERE email !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';

-- Temporarily remove the unique constraint if necessary
-- ALTER TABLE test DROP CONSTRAINT IF EXISTS unique_usr_email;
WITH RankedEmails AS (
  SELECT usr_id, email,
         ROW_NUMBER() OVER(PARTITION BY email ORDER BY usr_id) AS rn
  FROM user_test
)
DELETE FROM user_test
WHERE usr_id IN (SELECT usr_id FROM RankedEmails WHERE rn > 1);


--ads a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE user_test ADD CONSTRAINT unique_usr_email UNIQUE (email);


---State/city name fixers

--State fixer
SELECT INITCAP(state_address) AS ProperState_address
FROM user_test;
UPDATE user_test
SET state_address = INITCAP(state_address);
ALTER TABLE user_test ADD CONSTRAINT unique_state UNIQUE (state_address);
SELECT state_address, COUNT(*)
FROM user_test
GROUP BY state_address
HAVING COUNT(*) > 1;
--City fixer
SELECT INITCAP(city_address) AS ProperCity_address
FROM user_test;
UPDATE user_test
SET city_address = INITCAP(city_address);
ALTER TABLE user_test ADD CONSTRAINT unique_city UNIQUE (city_address);
SELECT city_address, COUNT(*)
FROM user_test
GROUP BY city_address
HAVING COUNT(*) > 1;

--Name fixer
--checks to see if the name is already capitalized then uses the INITCAP function 
-- to change the first letter to a capitalized letter.
-- changes data FROM first_name to ProperFirstName and last_name to ProperLastName
SELECT  INITCAP(first_name) as ProperFirstName, 
        INITCAP(last_name) as ProperLastName
FROM user_test;


-- Relational Model Tables

--Creates User table
CREATE TABLE "user" (
    usr_id SERIAL NOT NULL,
    usr_email VARCHAR(255) NOT NULL,
    usr_password VARCHAR(255),
    usr_fname VARCHAR(50),
    usr_lname VARCHAR(50),
    usr_address_num VARCHAR(50),
    usr_city VARCHAR(50),
    usr_state VARCHAR(50),
    usr_zip VARCHAR(20),
    --key variable
    PRIMARY KEY (usr_id)
);


--creates product table
CREATE TABLE products (
    product_id VARCHAR(40) NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    product_brand VARCHAR(40),
    product_type VARCHAR(40),
    --key variable
    PRIMARY KEY (product_id)
);

--creates service table
CREATE TABLE services (
    services_id VARCHAR(50) NOT NULL,
    services_name VARCHAR(100),
    services_brand VARCHAR(50),
    services_category VARCHAR(50),
    --key varable
    PRIMARY KEY (services_id)
);

--creates company table
CREATE TABLE company (
    company_id VARCHAR(50) NOT NULL,
    company_name VARCHAR(50),
    contact VARCHAR(50),
    phone VARCHAR(50),
    company_email VARCHAR(100),
    company_url VARCHAR(100),
    --key varable
    PRIMARY KEY (company_id)
);

--creates item table
CREATE TABLE item
    (
        item_id     varchar(50)     not null,
        item_type   varchar(50),
        item_name   varchar(50),
        item_description varchar(1000),
        item_price  float,
        item_picture    bytea,
        --key varable
        primary key(item_id)
    );

CREATE TABLE employee
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

CREATE TABLE discount
    (
        discount_id     varchar(50)     not null,
        discount_type   varchar(50),
        discount_amount varchar(50),
        discount_description varchar(50),
        discount_start_date date,
        discount_end_date   date,
        primary key(discount_id)
    );

CREATE TABLE user_interests
    (
        usr_id      serial     not null,
        usr_interest varchar(50)     not null,
        primary key (usr_id, usr_interest),
        foreign key (usr_id) references "user"(usr_id)
    );

CREATE TABLE user_item_preference
    (
        usr_id      serial     not null,
        item_id      varchar(50)     not null,
        primary key (usr_id, item_id),
        foreign key (usr_id) references "user"(usr_id),
        foreign key (item_id) references item(item_id)
    );

CREATE TABLE user_company_preference
    (
        usr_id      serial     not null,
        preference_company_id   varchar(50)     not null,
        primary key (usr_id, preference_company_id),
        foreign key (usr_id) references "user"(usr_id),
        foreign key (preference_company_id) references company(company_id)
    );

CREATE TABLE user_location_preference
    (
        usr_id                      serial     not null,
        preference_location_city    varchar(20)     not null,
        preference_location_state   varchar(15)     not null,
        primary key(usr_id, preference_location_city, preference_location_state),
        foreign key (usr_id) references "user"(usr_id)
    );

CREATE TABLE company_location
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

CREATE TABLE company_item
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

CREATE TABLE user_company_review
    (
        company_id      varchar(50)     not null,
        usr_id          serial     not null,
        rating_score    int,
        comments        varchar(1000),
        foreign key(company_id) references company(company_id),
        foreign key (usr_id) references "user"(usr_id)
    );

CREATE TABLE user_checkin
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

CREATE TABLE company_transaction
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

CREATE TABLE company_transaction_checkin
    (
        transaction_id      varchar(50)     not null,
        checkin_id          varchar(50)     not null,
        checkin_charge      float,
        primary key(transaction_id, checkin_id),
        foreign key(transaction_id) references company_transaction(transaction_id),
        foreign key(checkin_id) references user_checkin(checkin_id)
    );



