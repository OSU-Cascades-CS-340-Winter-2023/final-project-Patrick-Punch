-- Create a view that counts the number of products or services with discounts each day, and additional conditions as mentioned.
-- Create a view that returns a sorted list of products.


-- Creates a view that displays the following columns:
    -- discount_date, which displays every day that at least 1 discount is active.
    -- active_discounts, which displays for each day how many discounts are currently active
    -- new_discounts, which shows for each day how many discounts are newly active
create or replace view daily_discounts as
select
    discount_date, COUNT(*) as active_discounts, COUNT(case when discount_date = lower(discount_period) then 1 end) as new_discounts
from 
    (select
        generate_series(
            lower(daterange(discount_start_date, discount_end_date, '[]')), 
            upper(daterange(discount_start_date, discount_end_date, '[]')) - INTERVAL '1 day', 
            INTERVAL '1 day')::date as discount_date,
        c.discount_id,
        daterange(discount_start_date, discount_end_date, '[]') as discount_period
        from discount as d
        join company_item as c on d.discount_id = c.discount_id and c.is_discounted = true) as active_discounts
group by discount_date
order by discount_date;


/*Create a view that returns a sorted list of products that are discounted*/
CREATE or replace VIEW discounted_products AS
SELECT item_id, item_name, item_price
FROM item
WHERE item_id IN (SELECT item_id FROM company_item WHERE is_discounted = true)
ORDER BY item_price DESC;