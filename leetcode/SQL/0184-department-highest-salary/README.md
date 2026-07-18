[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/department-highest-salary/)

# 184. Department Highest Salary

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 19, 2026](https://img.shields.io/badge/Solved%20Jul%2019%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the employees with the highest salary in each department, and my first idea was to just find the highest salary overall, but that does not work because it only gives one employee. I want to find the highest salary in each department, so I use a subquery to find the `MAX(salary)` for each `departmentId`. This way I can get all employees with the highest salary in their department.

**How I got there:** I noticed that I can use a subquery to find the maximum salary for each department, and then use that result to filter the employees. I also saw that I need to join the `Employee` and `Department` tables to get the department name for each employee. My first query was not giving me all the employees with the highest salary, so I added the subquery to get the correct results.

1. Join the `Employee` and `Department` tables on `departmentId` so I can get the department name for each employee.
2. Use a subquery to find the `MAX(salary)` for each `departmentId` in the `Employee` table.
3. Filter the joined table to only include employees where the `departmentId` and `salary` match the results of the subquery.
4. Select the `Department` name, `Employee` name, and `salary` from the filtered table.

**Pattern to remember:** Use a subquery to find the maximum or minimum value for each group, and then use that result to filter the main table.

**Watch out for:** If I do not use the `departmentId` in the subquery, I will only get the overall maximum salary, not the maximum salary for each department.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 650 ms (beats 84.1%)](https://img.shields.io/badge/Runtime-650%20ms%20(beats%2084.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT d.name as "Department", e.name as "Employee", e.salary
FROM employee e JOIN department d ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (
SELECT departmentId, MAX(salary)
FROM employee
GROUP BY departmentId
)

/*
Inner query table: 

departmentId  | salary 
1               90000  
2               80000  

after Join table 

 id | name  | salary | departmentId |   name 
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            | IT 
| 2  | Jim   | 90000  | 1            | IT  
| 3  | Henry | 80000  | 2            | SALES 
| 4  | Sam   | 60000  | 2            | SALES
| 5  | Max   | 90000  | 1            | IT 
+----+-------+--------+----------

after applying filter condition: 

 id | name  | salary | departmentId |   name   | include/exclude
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            | IT      |  Exclude(because filter cond'n not satisfied)
| 2  | Jim   | 90000  | 1            | IT      | Inlude (filter cond'n satisfied)
| 3  | Henry | 80000  | 2            | SALES   | Inlude (filter cond'n satisfied)
| 4  | Sam   | 60000  | 2            | SALES   | Exclude(because filter cond'n not satisfied)
| 5  | Max   | 90000  | 1            | IT      | Inlude (filter cond'n satisfied)
+----+-------+--------+----------

final output :

------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000 

*/
```

Source: [0184-department-highest-salary.sql](./0184-department-highest-salary.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
```

Table: `Department`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.
```

Write a solution to find employees who have the highest salary in each of the departments.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output:
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
```

</details>
