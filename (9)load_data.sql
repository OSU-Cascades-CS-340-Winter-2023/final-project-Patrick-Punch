INSERT INTO item (item_id, item_type, item_name, item_description, item_price, item_picture)
SELECT product_id, product_type, product_name, product_brand, null, null
FROM products_test
ON CONFLICT DO NOTHING;

