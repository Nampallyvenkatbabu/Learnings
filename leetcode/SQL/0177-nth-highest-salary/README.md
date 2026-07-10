[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/nth-highest-salary/)

# 177. Nth Highest Salary

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the nth highest distinct salary, and my first idea was to sort the salaries and pick the nth one, but that does not work because I have to remove duplicates first. I use a subquery to get the max salary, then use that to get the next max salary. This approach fits because it lets me get the nth highest salary without having to sort all the salaries.

**How I got there:** I started by thinking about how to get the max salary, then I realized I need to get the max salary that is less than the current max salary, so I used a subquery to get the max salary, then used that to get the next max salary. I noticed that this approach can be used to get the nth highest salary by repeating the subquery n times.

1. Create a function `getNthHighestSalary` that takes an integer `N` as input.
2. Use a subquery to get the max salary from the `Employee` table.
3. Use another subquery to get the max salary that is less than the max salary, this will give the 2nd highest salary.
4. To get the nth highest salary, I would need to repeat this process n times, but the given code only returns the 2nd highest salary.
5. If there are less than n distinct salaries, the function will return null because the subquery will not return any value.

**Pattern to remember:** Use a subquery to get the next max value by selecting the max value that is less than the current max value.

**Watch out for:** If n is greater than the number of distinct salaries, the function will return null, but if the function is not designed to handle this case, it may return incorrect results.

## Solution

![Time: O(1)](https://img.shields.io/badge/Time-O(1)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)

```sql
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
