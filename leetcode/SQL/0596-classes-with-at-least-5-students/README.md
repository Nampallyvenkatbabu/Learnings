[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/classes-with-at-least-5-students/)

# 596. Classes With at Least 5 Students

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I need to find classes with at least 5 students, so I group the `Courses` table by `class` and count the students in each group. My first idea was to use a `WHERE` clause, but that does not work because I am counting after grouping, not before. I use a `HAVING` clause instead, which filters groups based on the count of students.

**How I got there:** I noticed that each row of the `Courses` table represents one student in one class, so I can count the rows to find the number of students in each class. The `GROUP BY` clause lets me count the students for each class separately.

1. Group the `Courses` table by `class` so each class is counted on its own.
2. Count the students in each group with `count(*)`.
3. Use a `HAVING` clause to filter the groups and only include classes with more than 4 students, since I want classes with at least 5 students.

**Pattern to remember:** When I need to filter groups based on an aggregate like `count(*)`, I use a `HAVING` clause after `GROUP BY`.

**Watch out for:** Using `WHERE` instead of `HAVING` does not work because `WHERE` filters rows before grouping, not after.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 288 ms (beats 99.8%)](https://img.shields.io/badge/Runtime-288%20ms%20(beats%2099.8%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

Select class
from Courses
Group by class
having count(*) >= 5
```

Source: [0596-classes-with-at-least-5-students.sql](./0596-classes-with-at-least-5-students.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Courses`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
```

Write a solution to find all the classes that have **at least five students**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output:
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation:
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.
```

</details>
