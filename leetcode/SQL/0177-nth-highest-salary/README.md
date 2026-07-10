[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/nth-highest-salary/)

# Nth Highest Salary

![Hard](https://img.shields.io/badge/Hard-d73a49?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

The most efficient way to solve this problem in modern SQL (MySQL 8+) is to use **window functions**.  
- **Solution 1:** `DENSE_RANK()` handles duplicates properly, ensuring tied salaries share the same rank.  
- **Alternative Solution:** `ROW_NUMBER()` works but does not handle duplicates correctly (two employees with the same salary will get different ranks).  
- **Fallback Solution:** `< MAX(salary)` works universally but only for the second highest salary, not generalized for N.  

**Pattern to remember:**  
- Use `DENSE_RANK()` when duplicates matter.  
- Use `ROW_NUMBER()` if duplicates are not a concern.  
- Fall back to `< MAX(salary)` when restricted by older MySQL versions (like LeetCode’s MySQL 5.x).  

**Watch out for:**  
If there are fewer than N distinct salaries, the query correctly returns `NULL`.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)

```sql
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
```

Source: [0177-nth-highest-salary.sql](./0177-nth-highest-salary.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
```

Write a solution to find the `n^th` highest **distinct** salary from the `Employee` table. If there are less than `n` distinct salaries, return `null`.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output:
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
```

### Example 2

```text
Input:
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output:
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
```

</details>
