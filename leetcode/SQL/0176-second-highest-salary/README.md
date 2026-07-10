[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/second-highest-salary/)

# 176. Second Highest Salary

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I find the second highest salary by taking the max of all salaries that are less than the highest salary, which I get with a subquery. My first idea was to sort all salaries and pick the second one, but that does not work because salaries are not unique. Using a subquery to find the highest salary first makes this work.

**How I got there:** I noticed that I need to find the highest salary first, so I can exclude it from the rest of the salaries. Then I can take the max of the remaining salaries, which will be the second highest. I used a subquery to find the highest salary.

1. Find the highest salary with a subquery.
2. Select all salaries that are less than the highest salary.
3. Take the max of these salaries, which will be the second highest.

**Pattern to remember:** When I need to find the second highest or second smallest of something, I can find the highest or smallest first, then find the highest or smallest of the rest.

**Watch out for:** If there is only one unique salary, this will return null, which is correct, but I need to make sure my query handles this case.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)
![Runtime: 278 ms (beats 71.8%)](https://img.shields.io/badge/Runtime-278%20ms%20(beats%2071.8%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select max(salary) as SecondHighestSalary from Employee where salary
<
(
    select max(salary) from Employee
) ;
```

Source: [0176-second-highest-salary.sql](./0176-second-highest-salary.sql)

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

Write a solution to find the second highest **distinct** salary from the `Employee` table. If there is no second highest salary, return `null (return None in Pandas)`.

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
Output:
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
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
Output:
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
```

</details>
