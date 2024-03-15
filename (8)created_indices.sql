--something here

--test indeices 
/* key terms
idx= index 
ON = used to specify the table on which the index is to be created
*/
/* Quick explanations (sourced from sql naming convetnions)
idx_user_interests_usr_id, follows a naming convention to make the index's 
purpose and associated columns clear. In this specific example, the inclusion 
of _usr_id after the main part of the index name indicates that the index is 
built on the usr_id column of the user_interests table.
*/
--user 
CREATE INDEX idx_user_interests_usr_id ON usr_interests(usr_id);
CREATE INDEX idx_user_item_preference_usr_id ON user_item_preference(usr_id);
CREATE INDEX idx_user_company_preference_usr_id ON user_company_preference(usr_id);
CREATE INDEX idx_user_location_preference_usr_city_state_zip ON user_location_preference(usr_city, usr_state, usr_zip);
CREATE INDEX idx_user_company_review_usr_id ON user_company_review(usr_id);
--item and service data
CREATE INDEX idx_item_item_type ON item(item_type);
CREATE INDEX idx_services_services_brand ON services(services_brand);
CREATE INDEX idx_products_product_typebrand ON products(product_type, product_brand);
-- --company data
-- CREATE INDEX idx_company_location_company_id ON company_location(company_location);
-- CREATE INDEX idx_company_item_company_id ON company_item(company_id);
-- CREATE INDEX idx_user_company_review_company_id ON user_company_review(company_id);
-- CREATE INDEX idx_company_transaction_company_id ON company_transaction(company_id);
-- CREATE INDEX idx_user_checkin_company_id ON user_checkin(company_id);
