-- add random prices to items
UPDATE item
SET item_price = FLOOR(RANDOM() * (100 - 10 + 1) + 10) + 0.99
WHERE item_price IS null;

-- add 5 random companies
INSERT INTO company (company_id, company_name)
SELECT
    company_id,
    'Company ' || company_id
FROM
    generate_series(1, 5) AS company_id;

-- add 5 random discounts for 2024
INSERT INTO discount (discount_id, discount_type, discount_amount, discount_description, discount_start_date, discount_end_date)
VALUES 
    (1, 'percentage', 10, null, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL),
    (2, 'percentage', 20, null, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL),
    (3, 'percentage', 30, null, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL),
    (4, 'percentage', 40, null, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL),
    (5, 'percentage', 50, null, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL, DATE '2024-01-01' + (FLOOR(RANDOM() * 365) || ' days')::INTERVAL);

-- add the 5 random discounts to 100 items
WITH random_items AS (
    SELECT
        item_id,
        generate_series(1, 5) AS company_id,
        generate_series(1, 5) AS discount_id
    FROM
        item
    ORDER BY
        RANDOM()
    LIMIT
        100
)

-- add 10 random items to each company
INSERT INTO
    company_item (company_id, item_id, discount_id, is_discounted)
SELECT
    random_items.company_id,
    random_items.item_id,
    random_items.discount_id,
    True
FROM
    random_items
    LEFT JOIN company_item ON random_items.item_id = company_item.item_id
WHERE
    company_item.item_id IS NULL
LIMIT
    10;

