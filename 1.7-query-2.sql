
-- Інформація про батьків і їхніх дітей разом із вартістю навчання
SELECT
    p.first_name AS parent_first_name,
    p.last_name AS parent_last_name,
    c.first_name AS child_first_name,
    c.last_name AS child_last_name,
    p.tuition_fee
FROM
    Parents p
JOIN
    Children c ON p.child_id = c.child_id
ORDER BY
    p.last_name, p.first_name;


