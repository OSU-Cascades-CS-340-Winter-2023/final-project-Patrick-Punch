--Determining data values for columns of the tables:
-- USER_TEST TABLE: 
-- Test Tables & Data Insertion
create table user_test
    (
        usr_id      serial      not null,
        username   varchar(30),
        first_name   varchar(15), 
        last_name   varchar(15), 
        email   varchar(50),
        street_address   varchar(50), 
        city_address   varchar(15), 
        state_address   varchar(15),
        primary key (usr_id)
    );

create table services_test
    (
        services_id varchar(50),
        services_name  varchar(100),
        services_brand varchar(50),
        services_category varchar(50),
        test_pkey       serial      not null,
        primary key(test_pkey)
    );

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
\COPY products_test(product_id, product_name, product_brand, product_type) FROM 'Filepath' delimiter '|' csv

\COPY services_test(services_id, services_name, services_brand, services_category) FROM 'Filepath' with (delimiter ',', format csv, header true)

\COPY user_test(first_name, last_name, username, email, street_address, city_address, state_address) FROM '/Users/ppunch/desktop/OSU/cs 340/final_project/final-project-Patrick-Punch/files/users.csv' WITH (FORMAT csv, DELIMITER ',', header true)

-- Patrick Filepath: /Users/ppunch/desktop/OSU/cs 340/final_project/final-project-Patrick-Punch/files/users.csv
