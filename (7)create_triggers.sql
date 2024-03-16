/*Write a trigger that adds a record to an archive table whenever an item is updated.*/
CREATE TABLE item_archive
    (
        item_id     varchar(50)     not null,
        item_type   varchar(50),
        item_name   varchar(300),
        item_description varchar(1000),
        item_price  float,
        item_picture    bytea,
        old_item_id     varchar(50),
        old_item_type   varchar(50),
        old_item_name   varchar(300),
        old_item_description varchar(1000),
        old_item_price  float,
        old_item_picture    bytea,
        date_updated    timestamp,
        primary key(item_id, date_updated)
    );


CREATE OR REPLACE FUNCTION item_update_trigger()
RETURNS TRIGGER AS 
$$
BEGIN
    INSERT INTO item_archive(item_id, item_type, item_name, item_description, item_price, item_picture, old_item_id, old_item_type, old_item_name, old_item_description, old_item_price, old_item_picture, date_updated)
    VALUES (NEW.item_id, NEW.item_type, NEW.item_name, NEW.item_description, NEW.item_price, NEW.item_picture, OLD.item_id, OLD.item_type, OLD.item_name, OLD.item_description, OLD.item_price, OLD.item_picture, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE  or replace TRIGGER ia_update
BEFORE UPDATE ON item
    FOR EACH ROW EXECUTE FUNCTION item_update_trigger();


-- testing trigger

INSERT INTO item (item_id, item_type, item_name, item_description, item_price)
VALUES ('1', 'Tool', 'Hammer', 'A tool used for pounding or extracting nails', 25.75);

UPDATE item
SET item_description = 'A heavy tool used for pounding nails into surfaces', item_price = 26.00
WHERE item_id = '1';