-- create a trigger that resets attribute valid_email only when email is changed

DELIMITER $$
create TRIGGER validate_email
before update on users
for each row begin
if OLD.email != NEW.email them
    set NEW.valid_email = 0;
else
    set NEW.valid_email = NEW.valid_email;
end if;
end $$
DELIMITER