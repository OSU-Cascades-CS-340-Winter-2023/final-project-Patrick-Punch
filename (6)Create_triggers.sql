/*Write a trigger that adds a record to an archive table whenever an item is updated.*/
CREATE TABLE item_archive
    (
        item_id     varchar(50)     not null,
        item_type   varchar(50),
        item_name   varchar(50),
        item_description varchar(1000),
        item_price  float,
        item_picture    bytea,
        date_updated    date,
        primary key(item_id, date_updated)
    );

CREATE OR REPLACE FUNCTION item_update_trigger()
RETURNS TRIGGER AS 
$$
BEGIN
    INSERT INTO item_archive
    SELECT OLD.item_id, OLD.item_type, OLD.item_name, OLD.item_description, OLD.item_price, OLD.item_picture, NEW.item_price, CURRENT_DATE;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger ia_update
before update on item
    for each row execute function item_update_trigger();


-- testing trigger
-- insert into item(item_id, item_type, item_name, item_description) 
-- values (1, 'service', 'patricks grade', 'd');

-- update item set item_description = 'A' where item_id = 1;