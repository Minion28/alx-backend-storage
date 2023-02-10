-- create function SafeDiv that dividesthe first by the second number and returns 0 if the second number is 0

DELIMITER $$
create function SafeDiv (a int, b int)
returns float deterministic begin
declare result float default 0;

if b != 0 then
    set result = a / b;
end if;
return result;
end $$
DELIMITER ;