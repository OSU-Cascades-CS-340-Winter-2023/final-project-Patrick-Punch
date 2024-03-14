-- Create a view that counts the number of products or services with discounts each day, and additional conditions as mentioned.
-- Create a view that returns a sorted list of products.


/*The result will be the date, the number of items with discounts on the current day, the number of items with
discounts on the current day that were not discounted the previous day.*/
create view daily_discounts as
select CURRENT_DATE as date, COUNT(*) as active_discounted_items,  
    (select COUNT(*) from company_item as c
    join discount as d 
    on d.discount_id = c.discount_id
    where d.discount_start_date = current_date) as todays_new_discount_items
from company_item
where is_discounted = true;


/*Create a view that returns a sorted list of products that are discounted*/
CREATE VIEW discounted_products AS
SELECT item_id, item_name, item_price
FROM item
WHERE item_id IN (SELECT item_id FROM company_item WHERE is_discounted = true)
ORDER BY item_price DESC;