
-- Anonymize Children  
UPDATE Children
SET first_name = 'Child',
    last_name = 'Anonymous';



-- Anonymize Parents 
WITH numbered_parents AS (
    SELECT parent_id, ROW_NUMBER() OVER (ORDER BY parent_id) AS rn
    FROM Parents
)
UPDATE Parents p
SET first_name = 'Parent' || np.rn,
    last_name = 'Anon'
FROM numbered_parents np
WHERE p.parent_id = np.parent_id;



-- Anonymize Institutions 
WITH numbered_institutions AS (
    SELECT institution_id, ROW_NUMBER() OVER (ORDER BY institution_id) AS rn
    FROM Institutions
)
UPDATE Institutions i
SET institution_name = 'Institution' || ni.rn
FROM numbered_institutions ni
WHERE i.institution_id = ni.institution_id;



-- Anonymize Tuition Fee
UPDATE Parents
SET tuition_fee = ROUND((1000 + random() * 2000)::numeric, 2);



-- Checking the results of anonymization
SELECT
    c.first_name AS child_first_name,
    c.last_name AS child_last_name,
    p.first_name AS parent_first_name,
    p.last_name AS parent_last_name,
    i.institution_name,
    p.tuition_fee
FROM
    Children c
JOIN
    Parents p ON c.child_id = p.child_id
JOIN
    Institutions i ON c.institution_id = i.institution_id
LIMIT 10;

