[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/employees-earning-more-than-their-managers/)

# 181. Employees Earning More Than Their Managers

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to compare each employee's salary to their manager's, which means I have to join the `Employee` table to itself. My first idea was to use a subquery, but a `JOIN` is a better fit here because it lets me access both the employee and manager in the same row. I join on `managerId` equal to `id` so each employee is paired with their manager.

**How I got there:** I started by looking at the relationships between employees, and I saw that each employee has a `managerId` that points to another row in the same table. That told me to join the table to itself, and then I could compare salaries between an employee and their manager.

1. Join the `Employee` table to itself on `managerId` equal to `id`, so each employee is paired with their manager.
2. Select the `name` of the employee where their `salary` is greater than their manager's `salary`.
3. Return a list of employee names who earn more than their managers.

**Pattern to remember:** When comparing rows within the same table based on a relationship like a foreign key, a self-join can be a good approach.

**Watch out for:** Forgetting to handle the case where `managerId` is `Null` would not be a problem here because the `JOIN` will exclude those rows, but it is something to think about in other problems.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 342 ms (beats 99.7%)](https://img.shields.io/badge/Runtime-342%20ms%20(beats%2099.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

Select e.name as Employee 
from 
Employee e
JOIN 
Employee m
on e.managerId = m.id
where e.salary > m.salary

/*
Alternative solution with corelated subquery

select e.name as Employee 
from Employee e
where e.salary > (
    select m.salary
    from Employee m
    where m.id = e.managerId 
)

*/
```

Source: [0181-employees-earning-more-than-their-managers.sql](./0181-employees-earning-more-than-their-managers.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
```

Write a solution to find the employees who earn more than their managers.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output:
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.
```

</details>
