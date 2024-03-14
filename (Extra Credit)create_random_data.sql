-- Create a random item from current items
WITH random_items AS (
    SELECT
        item_name || ' ' || item_name AS new_item_name,
        FLOOR(RANDOM() * (100 - 10 + 1) + 10) AS random_price,
        company_id,
        (
        SELECT CASE WHEN NOT EXISTS (
                SELECT 1
                FROM item
                WHERE item_id = (
                    SELECT FLOOR(RANDOM() * 1000000)
                )
            ) THEN (
                SELECT FLOOR(RANDOM() * 1000000)
            )
            ELSE (
                SELECT FLOOR(RANDOM() * 1000000)
            )
            END
        ) AS random_id, 
        (
        SELECT CASE WHEN NOT EXISTS ( -- We need decide if we want to create a new discount or use an existing one, probably easier to create a new one
                SELECT 1
                FROM discount
                WHERE discount_id = (
                    SELECT FLOOR(RANDOM() * 1000000)
                )
            ) THEN (
                SELECT FLOOR(RANDOM() * 1000000)
            )
            ELSE (
                SELECT FLOOR(RANDOM() * 1000000)
            )
            END
        ) AS random_discount_id
    FROM item
    ORDER BY RANDOM()
    LIMIT 2
)

-- Insert the random item into the company_item table
INSERT INTO
    company_item (company_id, item_id, discount_id, is_discounted)
SELECT
    random_items.company_id,
    random_items.random_id,
    random_items.random_discount_id,
    true
FROM
    random_items
    LEFT JOIN company_item ON random_items.random_id = company_item.item_id
WHERE
    company_item.item_id IS NULL
LIMIT
    100;


-- Create a random discount
WITH random_discounts AS (
    SELECT
        discount_id,
        FLOOR(RANDOM() * (100 - 10 + 1) + 10) AS random_discount,
        CURRENT_DATE AS start_date,
        CURRENT_DATE AS end_date
    FROM
        discount
    ORDER BY
        RANDOM()
    LIMIT
        100
)

-- Insert the random discount into the discount table
INSERT INTO
    discount (discount_id, discount, start_date, end_date)
SELECT
    random_discounts.discount_id,
    random_discounts.random_discount,
    random_discounts.start_date,
    random_discounts.end_date
FROM
    random_discounts
    LEFT JOIN discount ON random_discounts.discount_id = discount.discount_id
WHERE
    discount.discount_id IS NULL

