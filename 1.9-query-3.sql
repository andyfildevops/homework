
-- Список всіх закладів з адресами та кількістю дітей, які навчаються в кожному закладі:
SELECT
    i.institution_name,
    i.address,
    COUNT(c.child_id) AS number_of_children
FROM
    Institutions i
LEFT JOIN
    Children c ON i.institution_id = c.institution_id
GROUP BY
    i.institution_id, i.institution_name, i.address
ORDER BY
    number_of_children DESC;



