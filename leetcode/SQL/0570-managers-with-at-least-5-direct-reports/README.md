[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/)

# 570. Managers with at Least 5 Direct Reports

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 20, 2026](https://img.shields.io/badge/Solved%20Jul%2020%2C%202026-555555?style=flat-square)

## How I approached it

I need to find managers with at least five direct reports, so I join the `Employee` table to itself on the `managerId` and `id` columns. My first idea was to just count all employees, but that does not work because I need to count employees per manager. I use a `GROUP BY` to count employees per manager and a `HAVING` clause to filter for managers with at least five direct reports.

**How I got there:** I noticed that the `managerId` column in the `Employee` table is what links an employee to their manager, so I used that to join the table to itself. I then saw that I could use `GROUP BY` and `HAVING` to count the number of direct reports per manager and filter for the ones with at least five.

1. Join the `Employee` table to itself on the `managerId` and `id` columns to link each employee to their manager.
2. Group the joined table by the manager's `name` so I can count direct reports per manager.
3. Use the `HAVING` clause to filter for groups with at least five direct reports, which are the managers I want.
4. Select the `name` of each manager that meets the condition.

**Pattern to remember:** When I need to count items per group and filter groups based on the count, I use `GROUP BY` and `HAVING`.

**Watch out for:** If I use `WHERE` instead of `HAVING` to filter for managers with at least five direct reports, my query will not work because `WHERE` filters rows before grouping, not after.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 327 ms (beats 95.7%)](https://img.shields.io/badge/Runtime-327%20ms%20(beats%2095.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

Select m.name
from employee as e
inner join employee as m
on e.managerId=m.id
Group by m.id,m.name
having count(*) >= 5
```

Source: [0570-managers-with-at-least-5-direct-reports.sql](./0570-managers-with-at-least-5-direct-reports.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
```

Write a solution to find managers with at least **five direct reports**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output:
+------+
| name |
+------+
| John |
+------+
```

</details>
