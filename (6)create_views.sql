-- Create a view that counts the number of products or services with discounts each day, and additional conditions as mentioned.
-- Create a view that returns a sorted list of products.


/*The result will be the date, the number of items with discounts on the current day, the number of items with
discounts on the current day that were not discounted the previous day.*/
CREATE VIEW daily_discounts AS
SELECT CURRENT_DATE AS date, COUNT(*) AS num_discounts_today, COUNT(*) AS num_new_discounts_today
FROM company_item
WHERE is_discounted = true;

/*Create a view that returns a sorted list of products that are discounted*/
CREATE VIEW discounted_products AS
SELECT item_id, item_name, item_price
FROM item
WHERE item_id IN (SELECT item_id FROM company_item WHERE is_discounted = true)
ORDER BY item_price DESC;