# Write your MySQL query statement below

-- ✅ Optimized Solution using ROW_NUMBER()
-- Why better:
-- 1. Labels duplicates directly in one pass (rn > 1).
-- 2. No need to build a survivor list and then compare.
-- 3. More flexible: you can change ORDER BY to keep latest instead of smallest.
-- 4. Generally faster on large tables because it avoids the NOT IN overhead.

DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
        FROM Person
    ) ranked
    WHERE rn > 1
);


/*
-- 🔄 Alternative Solution using NOT IN + MIN(id)
-- Why alternative:
-- 1. Simple and intuitive: build survivor list (MIN(id) per email).
-- 2. Works even in older MySQL versions (before 8.0, which don’t support ROW_NUMBER).
-- 3. But less optimized: requires two steps (aggregate → compare).
-- 4. Can be slower on big tables and tricky if NULLs are present.

DELETE FROM Person
WHERE id NOT IN (
    SELECT id 
    FROM (
        SELECT MIN(id) AS id
        FROM Person
        GROUP BY email
    ) t
);
*/
