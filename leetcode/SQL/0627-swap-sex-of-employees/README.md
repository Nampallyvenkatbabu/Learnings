[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/swap-sex-of-employees/)

# 627. Swap Sex of Employees

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to swap all 'f' and 'm' values in the `sex` column, so I use a `CASE` statement to check each value and return the opposite. My first idea was to use an `IF` statement, but a `CASE` statement is more concise and readable. I want to change the `sex` column directly without using any intermediate tables.

**How I got there:** I looked at the `sex` column and saw it only has two possible values, 'm' and 'f', so I thought of using a `CASE` statement to swap them. I considered using a temporary table, but the problem asks for a single update statement, so I had to find a way to do it in one step.

1. Update the `Salary` table with a new value for the `sex` column.
2. Use a `CASE` statement to check the current value of `sex` and return 'f' if it's 'm', and 'm' if it's 'f'.
3. Apply this `CASE` statement to every row in the table, effectively swapping all 'f' and 'm' values.

**Pattern to remember:** When I need to swap two values in a single column, I can use a `CASE` statement to check each value and return the opposite, all in a single update statement.

**Watch out for:** Not using the `CASE` statement correctly, like forgetting the `END` keyword or using the wrong syntax, can cause a syntax error and prevent the update from working.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

Update Salary
set sex = 
(CASE when sex = 'm' then 'f' else 'm' END)
```

Source: [0627-swap-sex-of-employees.sql](./0627-swap-sex-of-employees.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Salary`

```text
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+
id is the primary key (column with unique values) for this table.
The sex column is ENUM (category) value of type ('m', 'f').
The table contains information about an employee.
```

Write a solution to swap all `'f'` and `'m'` values (i.e., change all `'f'` values to `'m'` and vice versa) with a **single update statement** and no intermediate temporary tables.

Note that you must write a single update statement, **do not** write any select statement for this problem.

The result format is in the following example.

### Example 1

```text
Input:
Salary table:
+----+------+-----+--------+
| id | name | sex | salary |
+----+------+-----+--------+
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
+----+------+-----+--------+
Output:
+----+------+-----+--------+
| id | name | sex | salary |
+----+------+-----+--------+
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |
+----+------+-----+--------+
Explanation:
(1, A) and (3, C) were changed from 'm' to 'f'.
(2, B) and (4, D) were changed from 'f' to 'm'.
```

</details>
