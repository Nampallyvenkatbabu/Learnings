-- ✅ Solution 1: DENSE_RANK() (handles duplicates properly, MySQL 8+ only)
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    SELECT DISTINCT salary
    FROM (
        SELECT salary,
               DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
        FROM Employee
    ) ranked
    WHERE rnk = N
  );
END;

/*
-- 🔄 Alternative Solution: ROW_NUMBER() (best for optimization, but fails with duplicates)
-- ❌ Not usable on LeetCode because it runs MySQL 5.x (no window functions).
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    SELECT MAX(salary)
    FROM (
        SELECT salary,
               ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
        FROM Employee
    ) ranked
    WHERE rn = N
  );
END;


-- ✅ Alternative 3: Comparison-based < MAX(salary) (LeetCode-compatible, but only for 2nd highest)
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    SELECT MAX(salary)
    FROM Employee
    WHERE salary < (
        SELECT MAX(salary)
        FROM Employee
    )
  );
END;
*/
