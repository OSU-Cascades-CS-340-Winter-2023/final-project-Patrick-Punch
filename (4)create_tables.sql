-- Relational Model Tables

-- Creates User table
CREATE TABLE "user" 
    (
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
CREATE TABLE products 
    (
        product_id VARCHAR(40) NOT NULL,
        product_name VARCHAR(150) NOT NULL,
        product_brand VARCHAR(40),
        product_type VARCHAR(40),
        --key variable
        PRIMARY KEY (product_id)
    );

--creates service table
CREATE TABLE services 
    (
        services_id VARCHAR(50) NOT NULL,
        services_name VARCHAR(100),
        services_brand VARCHAR(50),
        services_category VARCHAR(50),
        --key varable
        PRIMARY KEY (services_id)
    );

--creates company table
CREATE TABLE company 
    (
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




