--create a stored procedure ComputeAverageWeightedScoreForUser that computes and store the average weeighted score for a student

DELIMITER $$
create procedure ComputeAverageWeightedScoreForUser (user_id int)
begin
    declare total_weighted_score int default 0;
    declare total_weight int DEFAULT 0;

    select sum(corrections.score * projects.weight)
        into total_weighted_score
        from corrections
            inner join projects
                on corrections.project_id = projects.id
        where corrections.user_id = user_id;

    select sum(projects.weight)
        into total_weight
        from corrections
            inner join projects
                on corrections.project_id = projects.id
        where corrections.user_id = user_id;

    if total_weight = 0 then
        update users
            set users.average_score = 0
            where users.id = user_id;
    else
        update users
            set users.average_score = total_weighted_score / total_weight
            where users.id = user_id;
    end if;
end $$
DELIMITER ;