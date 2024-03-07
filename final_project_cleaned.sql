CREATE DATABASE pxx_final_project;
-- Remember to connect to the databASe using the appropriate command in your SQL client, e.g., \c pxx_final_project

--Creates User table
CREATE TABLE "user" (
    usr_id SERIAL NOT NULL,
    usr_email VARCHAR(255) NOT NULL,
    usr_pASsword VARCHAR(255),
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
        item_id     VARCHAR(50)     NOT NULL,
        item_type   VARCHAR(50),
        item_name   VARCHAR(50),
        item_description VARCHAR(1000),
        item_price  FLOAT,
        item_picture    BYTEA,
        --key varable
        PRIMARY KEY(item_id)
    );

CREATE TABLE employee
    (
        emp_id         VARCHAR(50)     NOT NULL,
        emp_email      VARCHAR(50),
        emp_first_name VARCHAR(50),
        emp_last_name  VARCHAR(50),
        job_category   VARCHAR(50),
        salary         INT,
        street_address  VARCHAR(100),
        emp_city       VARCHAR(20),
        emp_state      VARCHAR(15),
        emp_zip_code   VARCHAR(10),
        PRIMARY KEY(emp_id)
    );

CREATE TABLE discount
    (
        discount_id     VARCHAR(50)     NOT NULL,
        discount_type   VARCHAR(50),
        discount_amount VARCHAR(50),
        discount_description VARCHAR(50),
        discount_start_date DATE,
        discount_end_date   DATE,
        PRIMARY KEY(discount_id)
    );

CREATE TABLE user_INTerests
    (
        usr_id      SERIAL     NOT NULL,
        usr_INTerest VARCHAR(50)     NOT NULL,
        PRIMARY KEY (usr_id, usr_INTerest),
        FOREIGN KEY (usr_id) REFERENCES "user"(usr_id)
    );

CREATE TABLE user_item_preference
    (
        usr_id      SERIAL     NOT NULL,
        item_id      VARCHAR(50)     NOT NULL,
        PRIMARY KEY (usr_id, item_id),
        FOREIGN KEY (usr_id) REFERENCES "user"(usr_id),
        FOREIGN KEY (item_id) REFERENCES item(item_id)
    );

CREATE TABLE user_company_preference
    (
        usr_id      SERIAL     NOT NULL,
        preference_company_id   VARCHAR(50)     NOT NULL,
        PRIMARY KEY (usr_id, preference_company_id),
        FOREIGN KEY (usr_id) REFERENCES "user"(usr_id),
        FOREIGN KEY (preference_company_id) REFERENCES company(company_id)
    );

CREATE TABLE user_location_preference
    (
        usr_id                      SERIAL     NOT NULL,
        preference_location_city    VARCHAR(20)     NOT NULL,
        preference_location_state   VARCHAR(15)     NOT NULL,
        PRIMARY KEY(usr_id, preference_location_city, preference_location_state),
        FOREIGN KEY (usr_id) REFERENCES "user"(usr_id)
    );

CREATE TABLE company_location
    (
        company_id      VARCHAR(50)     NOT NULL,
        location_id     VARCHAR(50)     NOT NULL,
        company_address VARCHAR(100),
        company_city    VARCHAR(20),
        company_state   VARCHAR(15),
        company_zip     VARCHAR(10),
        company_pnum    VARCHAR(15),
        PRIMARY KEY(location_id),
        FOREIGN KEY(company_id) REFERENCES company(company_id)
    );

CREATE TABLE company_item
    (
        company_id      VARCHAR(50)     NOT NULL,
        item_id         VARCHAR(50)     NOT NULL,
        discount_id     VARCHAR(50)     NOT NULL,
        is_discounted   BOOLEAN,
        PRIMARY KEY(company_id, item_id),
        FOREIGN KEY(company_id) REFERENCES company(company_id),
        FOREIGN KEY(item_id) REFERENCES item(item_id),
        FOREIGN KEY(discount_id) REFERENCES discount(discount_id)
    );

CREATE TABLE user_company_review
    (
        company_id      VARCHAR(50)     NOT NULL,
        usr_id          SERIAL     NOT NULL,
        rating_score    INT,
        comments        VARCHAR(1000),
        FOREIGN KEY(company_id) REFERENCES company(company_id),
        FOREIGN KEY (usr_id) REFERENCES "user"(usr_id)
    );

CREATE TABLE user_checkin
    (
        checkin_id      VARCHAR(50)     NOT NULL,
        checkin_date    DATE,
        usr_id          SERIAL     NOT NULL,
        company_id      VARCHAR(50)     NOT NULL,
        item_id         VARCHAR(50)     NOT NULL,
        discount_id     VARCHAR(50)     NOT NULL,
        PRIMARY KEY(checkin_id),
        FOREIGN KEY(company_id) REFERENCES company(company_id),
        FOREIGN KEY(item_id) REFERENCES item(item_id),
        FOREIGN KEY(discount_id) REFERENCES discount(discount_id)
    );

CREATE TABLE company_transaction
    (
        transaction_id      VARCHAR(50)     NOT NULL,
        transaction_date    DATE,
        charge_type         VARCHAR(50),
        transaction_amount  FLOAT,
        surcharge           FLOAT,
        total_charge        FLOAT GENERATED ALWAYS AS 
                            (CASE WHEN transaction_amount IS NULL THEN surcharge
                                WHEN surcharge IS NULL THEN transaction_amount
                                ELSE transaction_amount + surcharge END) STORED,
        tx_is_paid             BOOLEAN,
        paid_date           DATE,
        company_id      VARCHAR(50)     NOT NULL,
        PRIMARY KEY(transaction_id),
        FOREIGN KEY(company_id) REFERENCES company(company_id)
    );

CREATE TABLE company_transaction_checkin
    (
        transaction_id      VARCHAR(50)     NOT NULL,
        checkin_id          VARCHAR(50)     NOT NULL,
        checkin_charge      FLOAT,
        PRIMARY KEY(transaction_id, checkin_id),
        FOREIGN KEY(transaction_id) REFERENCES company_transaction(transaction_id),
        FOREIGN KEY(checkin_id) REFERENCES user_checkin(checkin_id)
    );

--file additions

--loads user data INTo the test table
\COPY test(first_name, last_name, username, email, street_address, city_address, state_address) FROM 'FilePath' WITH (FORMAT csv, DELIMITER ',');
--load data INTo service_test table
\COPY services_test(services_id, services_name, services_brand, services_catagory) FROM 'FilePath' delimiter ',' csv
--load data INTo products_test table --
\COPY products_test(product_id, product_name, product_brand, product_type) FROM 'FilePath' delimiter '|' csv


--Determining data values for the tables
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

--cleans up names labled 'first_name'
DELETE FROM test
WHERE first_name = 'first_name';

--Cleaning data/ data scraping
-- Email filters 
--SELECTs FROM the emails we have and checks to see 
--if the start hAS proper values then checks after the @ symbol
SELECT email
FROM test
WHERE email !~*?# '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
--ads a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE test ADD CONSTRAINT unique_usr_email UNIQUE (email);
--finds the non unique emails that already exist and emails that violate the code above
SELECT email, COUNT(*)
FROM test
GROUP BY email
HAVING COUNT(*) > 1;


---State/city name fixers

--State fixer
SELECT INITCAP(state_address) AS ProperState_address
FROM test;
UPDATE test
SET state_address = INITCAP(state_address);
ALTER TABLE test ADD CONSTRAINT unique_state UNIQUE (state_address);
SELECT state_address, COUNT(*)
FROM test
GROUP BY state_address
HAVING COUNT(*) > 1;
--City fixer
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
-- changes data FROM first_name to ProperFirstName and last_name to ProperlastName
SELECT  INITCAP(first_name) AS ProperFirstName, 
        INITCAP(last_name) AS ProperlastName
FROM test;



