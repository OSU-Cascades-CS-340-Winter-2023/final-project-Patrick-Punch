--Determining data values for columns of the tables:

-- USER_TEST table
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