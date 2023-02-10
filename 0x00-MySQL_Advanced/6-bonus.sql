--create a stored procedure AddBonus that adds a new correction for a student

DELIMITER $$
create procedure AddBonus (user_id int, project_name varchar(255), score float) begin
declare project_count int DEFAULT 0;
declare project_id int DEFAULT 0;

select count(id)
    into project_count
    from projects
    where name = project_name;
if project_count = 0 then
    insert into projects(name)
        values(project_name);
end if;
select id
    into project_id
    from projects
    where = project_name;
insert into corrections(user_id, project_id, score)
    values (user_id, project_id, score);
end $$
DELIMITER ;