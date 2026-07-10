-- ✅ 1st Alternative: Comparison-based < MAX(salary)
-- Works in ALL MySQL versions (including LeetCode).
-- Simple and intuitive for 2nd highest, but requires nesting for 3rd, 4th, etc.
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);

/*
-- ✅ 2nd Alternative: ROW_NUMBER() (best for optimization, but needs MySQL 8+)
-- Modern, flexible, avoids LIMIT restriction, easy to extend to Nth highest.
-- ❌ Not usable on LeetCode because it runs MySQL 5.x (no window functions).
SELECT MAX(salary) AS SecondHighestSalary
FROM (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM Employee
) ranked
WHERE rn = 2;   -- rn = 2 → second highest salary



-- ✅ 3rd Alternative: LIMIT + OFFSET
-- Clean rank-based approach, supported in MySQL 8+.
-- ❌ Not usable on LeetCode because older MySQL doesn’t allow LIMIT inside IN subqueries.
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary = (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1   -- OFFSET 1 → second highest
);

*/
