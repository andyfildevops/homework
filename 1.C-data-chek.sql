
-- Перевірка цілісності даних:
SELECT table_name, row_count
FROM (
    SELECT 'Institutions' AS table_name, COUNT(*) AS row_count FROM Institutions
    UNION ALL
    SELECT 'Classes', COUNT(*) FROM Classes
    UNION ALL
    SELECT 'Children', COUNT(*) FROM Children
    UNION ALL
    SELECT 'Parents', COUNT(*) FROM Parents
) AS counts;


-- Перевірка зовнішніх ключів та обмежень:
SELECT conname, confrelid::regclass AS referenced_table
FROM pg_constraint
WHERE contype = 'f';
