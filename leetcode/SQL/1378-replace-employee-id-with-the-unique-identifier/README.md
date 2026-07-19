[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)

# 1378. Replace Employee ID With The Unique Identifier

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 19, 2026](https://img.shields.io/badge/Solved%20Jul%2019%2C%202026-555555?style=flat-square)

## How I approached it

I need to show each employee's unique ID from the `EmployeeUNI` table, or `null` if it does not exist, along with their name from the `Employees` table. My first idea was to use an inner join, but that would leave out employees without a unique ID. A `left join` fits because it includes all employees, even if they do not have a match in the other table.

**How I got there:** I looked at the tables and saw that an employee might not have a unique ID, so I needed a way to include all employees, even if they do not have a match in the `EmployeeUNI` table. I thought about how a `left join` works and how it would give me all the employees, with `null` for the unique ID if it does not exist.

1. Select the `unique_id` and `name` columns, which are the ones I need for the output.
2. Use a `left join` to combine rows from the `Employees` and `EmployeeUNI` tables where the `id` matches.
3. The `left join` ensures that I get all employees, with `null` for the `unique_id` if there is no match in the `EmployeeUNI` table.

**Pattern to remember:** When I need to include all rows from one table, even if there is no match in another table, I use a `left join` to get all the rows, with `null` in the columns from the other table where there is no match.

**Watch out for:** Using an `inner join` instead of a `left join` would leave out employees without a unique ID, which is not what I want.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1527 ms (beats 12.1%)](https://img.shields.io/badge/Runtime-1527%20ms%20(beats%2012.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select unique_id, 
e.name
from Employees e
left join EmployeeUNI EUI
on e.id = EUI.id
```

Source: [1378-replace-employee-id-with-the-unique-identifier.sql](./1378-replace-employee-id-with-the-unique-identifier.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employees`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.
```

Table: `EmployeeUNI`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.
```

Write a solution to show the **unique ID** of each user, If a user does not have a unique ID replace just show `null`.

Return the result table in **any** order.

The result format is in the following example.

### Example 1

```text
Input:
Employees table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |
+----+----------+
EmployeeUNI table:
+----+-----------+
| id | unique_id |
+----+-----------+
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |
+----+-----------+
Output:
+-----------+----------+
| unique_id | name     |
+-----------+----------+
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
+-----------+----------+
Explanation:
Alice and Bob do not have a unique ID, We will show null instead.
The unique ID of Meir is 2.
The unique ID of Winston is 3.
The unique ID of Jonathan is 1.
```

</details>
