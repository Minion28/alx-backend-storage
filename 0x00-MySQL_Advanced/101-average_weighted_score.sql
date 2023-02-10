-- create a stored procedure ComputeAverageWeightedScoreForUsers that computes and store average weighted score for all students

DELIMITER $$
create procedure ComputeAverageWeightedScoreForUsers ()
begin
    alter table users add total_weighted_score int not null;
    alter table users add total_weight int not null;
    update users
        set total_weighted_score = (
            select sum(corrections.score * projects.weight)
            from corrections
                inner join projects
                    on corrections.project_id = projects.id
            where corrections.user_id = users.id
            );
    update users
        set total_weight = (
            select sum(projects.weight)
                from corrections
                    inner join projects
                        on corrections.project_id = projects.id
                where corrections.user_id = users.id
            );
    update users
        set users.average_score = if(users.total_weight = 0, 0, users.total_weighted_score / users.total_weight);
    alter table users
        drop column total_weighted_score;
    alter table users
        drop column total_weight;
end $$
DELIMITER ;