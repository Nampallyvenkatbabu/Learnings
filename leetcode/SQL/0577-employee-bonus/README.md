[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/employee-bonus/)

# 577. Employee Bonus

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to get the name and bonus of each employee who has a bonus less than 1000 or no bonus at all. My first idea was to use a subquery, but a `LEFT JOIN` is a better fit because it can handle the case where an employee has no bonus in one step.

**How I got there:** I noticed that an employee can either have a bonus or not, so I looked for a way to get all employees and their bonuses in one result set, which led me to use a `LEFT JOIN` on the `empId` column in both tables.

1. Join the `Employee` table with the `Bonus` table on the `empId` column using a `LEFT JOIN`, so I get all employees and their bonuses if they exist.
2. Add a `WHERE` clause to filter the results to only include employees with a bonus less than 1000 or no bonus at all, using the `OR` operator to check for `NULL` bonuses.
3. Select the `name` column from the `Employee` table and the `bonus` column from the `Bonus` table in the result set.

**Pattern to remember:** When combining data from two tables where one table may not have a match in the other, use a `LEFT JOIN` to get all rows from the first table and the matching rows from the second table, if any.

**Watch out for:** Forgetting to use `OR b.bonus is null` in the `WHERE` clause would miss employees who do not have a bonus, because a `LEFT JOIN` returns `NULL` for the right table when there is no match.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 977 ms (beats 72.0%)](https://img.shields.io/badge/Runtime-977%20ms%20(beats%2072.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select e.name,b.bonus 
from Employee e
LEFT JOIN
Bonus b
on e.empId = b.empId 
where b.bonus < 1000 or b.bonus is null

/*
Alternate solution with corelated subquery 

select e.name,
(
    select b.bonus 
    from Bonus b
    where b.empId = e.empId 
) as bonus
from Employee e
where 
(
    select b.bonus 
    from Bonus b
    where b.empId = e.empId 
) < 1000
or 
(
    select b.bonus 
    from Bonus b
    where b.empId = e.empId 
) is NULL;

*/
```

Source: [0577-employee-bonus.sql](./0577-employee-bonus.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
```

Table: `Bonus`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
```

Write a solution to report the name and bonus amount of each employee who satisfies either of the following:

- The employee has a bonus **less than** `1000`.
- The employee did not get any bonus.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output:
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
```

</details>
