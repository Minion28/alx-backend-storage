--create a view need_meeting that lists all students that score under 80(strict) and no last_meeting or more than 1 month

create view need_meeting as
    select name from students where score < 80 and
(
    last_meeting is null
    or last_meeting < subdate(current_date(), interval 1 month)
);