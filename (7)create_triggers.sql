/*Write a trigger that adds a record to an archive table whenever an item is updated.*/
CREATE TABLE item_archive
    (
        item_id     varchar(50)     not null,
        item_type   varchar(50),
        item_name   varchar(300),
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
--added the item_archive table vales in () to the insert into.
    INSERT INTO item_archive(item_id, item_type, item_name, item_description, item_price, item_picture, date_updated)
--changed select to values  to make it select values
--also changed NEW. to OLD.
    VALUES (OLD.item_id, OLD.item_type, OLD.item_name, OLD.item_description, OLD.item_price, OLD.item_picture, CURRENT_DATE);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*The INSERT INTO statement correctly lists all the target columns.
The VALUES clause is used with OLD.* columns to get the values before the update and CURRENT_DATE to record the update time.
The NEW.item_price was removed, and NEW.item_price doesn't have a corresponding column in the item_archive table. (changed to OLD.item_price)
*/
$$ LANGUAGE plpgsql;

create trigger ia_update
before update on item
    for each row execute function item_update_trigger();


-- testing trigger
-- insert into item(item_id, item_type, item_name, item_description) 
-- values (1, 'service', 'patricks grade', 'd');

-- update item set item_description = 'A' where item_id = 1;

