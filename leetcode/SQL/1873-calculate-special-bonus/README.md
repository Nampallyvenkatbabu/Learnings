[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/calculate-special-bonus/)

# 1873. Calculate Special Bonus

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to give a 100% bonus to employees with odd IDs and names that do not start with 'M', so I use a conditional statement to check these conditions and return the `salary` or 0. My first idea was to use separate `IF` statements for the conditions, but a single `IF` with `AND` works better.

**How I got there:** I looked at the conditions for the bonus and saw that both the `employee_id` and `name` columns are involved, so I asked how I can combine these conditions in one statement. Once I saw that I can use `AND` and `NOT LIKE` together, the fix was to put them in one `IF` statement.

1. Select the `employee_id` column to include it in the result.
2. Use an `IF` statement to check if the `employee_id` is odd and the `name` does not start with 'M'.
3. If the conditions are met, return the `salary` as the bonus, otherwise return 0.
4. Order the result by `employee_id` to match the required output format.

**Pattern to remember:** When multiple conditions need to be met, use `AND` to combine them in a single conditional statement.

**Watch out for:** Forgetting the `NOT` keyword before `LIKE 'M%'` would incorrectly filter out names that do start with 'M', instead of the other way around.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 618 ms (beats 56.0%)](https://img.shields.io/badge/Runtime-618%20ms%20(beats%2056.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

Select employee_id, 
if(employee_id % 2 = 1 and name not like 'M%',salary,0) as bonus
from Employees
order by employee_id;
```

Source: [1873-calculate-special-bonus.sql](./1873-calculate-special-bonus.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employees`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key (column with unique values) for this table.
Each row of this table indicates the employee ID, employee name, and salary.
```

Write a solution to calculate the bonus of each employee. The bonus of an employee is `100%` of their salary if the ID of the employee is **an odd number** and ** the employee's name does not start with the character** `'M'`. The bonus of an employee is `0` otherwise.

Return the result table ordered by `employee_id`.

The result format is in the following example.

### Example 1

```text
Input:
Employees table:
+-------------+---------+--------+
| employee_id | name    | salary |
+-------------+---------+--------+
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addilyn | 7400   |
| 8           | Juan    | 6100   |
| 9           | Kannon  | 7700   |
+-------------+---------+--------+
Output:
+-------------+-------+
| employee_id | bonus |
+-------------+-------+
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 7700  |
+-------------+-------+
Explanation:
The employees with IDs 2 and 8 get 0 bonus because they have an even employee_id.
The employee with ID 3 gets 0 bonus because their name starts with 'M'.
The rest of the employees get a 100% bonus.
```

</details>
