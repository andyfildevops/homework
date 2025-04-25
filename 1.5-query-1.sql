
-- Список всіх дітей разом із закладом та напрямом навчання:
SELECT
    c.first_name AS child_first_name,
    c.last_name AS child_last_name,
    i.institution_name,
    cl.direction
FROM
    Children c
JOIN
    Institutions i ON c.institution_id = i.institution_id
LEFT JOIN
    Classes cl ON c.class_id = cl.class_id
ORDER BY
    c.last_name, c.first_name;

