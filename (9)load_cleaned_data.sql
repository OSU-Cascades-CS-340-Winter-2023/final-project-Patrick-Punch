INSERT INTO item (item_id, item_type, item_name, item_description, item_price)
SELECT product_id, product_type, product_name, product_brand, null
FROM products_test
ON CONFLICT DO NOTHING;

INSERT INTO item (item_id, item_type, item_name, item_description, item_price)
select services_id, services_category, services_name, services_brand, null
from services_test
on CONFLICT do NOTHING;

insert into "user" (usr_id, usr_email, usr_fname, usr_lname, usr_username, usr_address_num, usr_city, usr_state)
select usr_id, email, first_name, last_name, username, street_address, city_address, state_address
from user_test
on CONFLICT do NOTHING;
