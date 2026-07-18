[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/primary-department-for-each-employee/)

# 1789. Primary Department for Each Employee

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 19, 2026](https://img.shields.io/badge/Solved%20Jul%2019%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the primary department for each employee, which is the department with `primary_flag` 'Y' if it exists, or the only department if there is only one. My first idea was to just filter on `primary_flag` 'Y', but that misses employees with only one department. I use an `OR` condition to include those cases.

**How I got there:** I noticed that employees with only one department have `primary_flag` 'N', so I had to find a way to include them. I realized I could use a subquery to find employees with only one department, and then use `OR` to combine those with employees who have a `primary_flag` 'Y' department.

1. Select `employee_id` and `department_id` from the `Employee` table where `primary_flag` is 'Y'.
2. Use a subquery to find `employee_id` values that appear only once in the table, which means the employee is in only one department.
3. Combine these two conditions with `OR` to get all employees with their primary department.

**Pattern to remember:** When a condition is not enough on its own, use `OR` to add an exception, like including a subquery to cover a special case.

**Watch out for:** Forgetting the `OR` condition would miss employees who are in only one department, because their `primary_flag` is 'N'.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 521 ms (beats 94.1%)](https://img.shields.io/badge/Runtime-521%20ms%20(beats%2094.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT employee_id,
       department_id
FROM Employee
WHERE primary_flag = 'Y'
   OR employee_id IN (
        SELECT employee_id
        FROM Employee
        GROUP BY employee_id
        HAVING COUNT(*) = 1
   );
```

Source: [1789-primary-department-for-each-employee.sql](./1789-primary-department-for-each-employee.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
```

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is `'N'`.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+
Output:
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
Explanation:
- The Primary department for employee 1 is 1.
- The Primary department for employee 2 is 1.
- The Primary department for employee 3 is 3.
- The Primary department for employee 4 is 3.
```

</details>
