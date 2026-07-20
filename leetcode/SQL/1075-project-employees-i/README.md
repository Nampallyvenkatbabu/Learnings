[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/project-employees-i/)

# 1075. Project Employees I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 20, 2026](https://img.shields.io/badge/Solved%20Jul%2020%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the average experience years for each project, so I join the `Project` and `Employee` tables on `employee_id`. My first idea was to just average the experience years, but I also need to group by `project_id` to get one average per project.

**How I got there:** I noticed that each project has multiple employees, and each employee has an experience year, so I thought to join the two tables and use the `avg` function to calculate the average experience years. I also realized that I need to group the results by `project_id` to get the average for each project.

1. Join the `Project` and `Employee` tables on `employee_id` to link each project with its employees.
2. Use the `avg` function to calculate the average experience years for each group of employees.
3. Group the results by `project_id` to get one average per project.
4. Select `project_id` and the average experience years, rounded to 2 digits, to get the final result.

**Pattern to remember:** When calculating an average for groups of data, use the `avg` function with a `group by` clause to get one average per group.

**Watch out for:** Forgetting to group by `project_id` would result in a single average experience year for all projects, instead of one average per project.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 553 ms (beats 39.5%)](https://img.shields.io/badge/Runtime-553%20ms%20(beats%2039.5%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select project_id,
Round(avg(experience_years),2) as average_years
from Employee e
inner join Project p
on e.employee_id = p.employee_id
Group by project_id
```

Source: [1075-project-employees-i.sql](./1075-project-employees-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Project`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
```

Table: `Employee`

```text
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
```

Write an SQL query that reports the **average** experience years of all the employees for each project, ** rounded to 2 digits**.

Return the result table in **any order**.

The query result format is in the following example.

### Example 1

```text
Input:
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output:
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
Explanation: The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50
```

</details>
