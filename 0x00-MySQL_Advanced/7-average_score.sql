--create a stored procedure ComputeAverageScoreForUser that computes and store average score for student

DELIMITER $$
create procedure ComputeAverageScoreForUser (user_id int) begin
declare total_score int default 0;
declare projects_count int default 0;

select sum(score)
    into total_score
    from corrections
    where corrections.user_id = user_id;
select COUNT(*)
    into projects_count
    from corrections
    where corrections.user_id = user_id;

update users
    set users.average_score = IF(projects_count = 0, 0, total_score / projects_count)
    where users.id = user_id;
end $$
DELIMITER ;