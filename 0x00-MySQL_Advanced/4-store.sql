--create a trigger that decreases the quantity of an item after adding a new order

DELIMITER $$
create TRIGGER reduce_quantity
after insert on orders
for each row begin
update items
    set quantity = quantity - NEW.number
    where name = NEW.item_name;
END $$
DELIMITER;