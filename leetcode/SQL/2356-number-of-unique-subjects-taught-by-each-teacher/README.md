[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/)

# 2356. Number of Unique Subjects Taught by Each Teacher

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 20, 2026](https://img.shields.io/badge/Solved%20Jul%2020%2C%202026-555555?style=flat-square)

## How I approached it

I need to count the unique subjects each teacher teaches, so I group the table by `teacher_id` and `subject_id` to count each subject only once per teacher. My first idea was to count rows directly, but that would count the same subject in different departments multiple times. I use a subquery to count unique subjects first.

**How I got there:** I noticed that the same `subject_id` can appear in multiple rows for the same `teacher_id` if it's taught in different departments, so I decided to group by both `teacher_id` and `subject_id` to get a count of unique subjects per teacher. This led me to use a subquery to first count the subjects, then group by `teacher_id` to get the total count per teacher.

1. Group the `Teacher` table by `teacher_id` and `subject_id` so each subject taught by a teacher is counted only once.
2. Count the rows in each group, which gives the number of times a teacher teaches a subject, but since we grouped by subject, this count will always be 1 for each unique subject.
3. Wrap this count in a subquery to get a list of teachers and their unique subjects.
4. Group the result of the subquery by `teacher_id` to get the total count of unique subjects per teacher.
5. Count the rows in each of these groups to get the final count of unique subjects per teacher.

**Pattern to remember:** When counting unique items in a table that may have duplicates, use a subquery to first group by the item and then group by the category to count the unique items per category.

**Watch out for:** Not grouping by `subject_id` in the subquery would result in counting each row individually, leading to incorrect counts when a teacher teaches the same subject in multiple departments.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 534 ms (beats 51.3%)](https://img.shields.io/badge/Runtime-534%20ms%20(beats%2051.3%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id
```

Source: [2356-number-of-unique-subjects-taught-by-each-teacher.sql](./2356-number-of-unique-subjects-taught-by-each-teacher.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Teacher`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
```

Write a solution to calculate the number of unique subjects each teacher teaches in the university.

Return the result table in **any order**.

The result format is shown in the following example.

### Example 1

```text
Input:
Teacher table:
+------------+------------+---------+
| teacher_id | subject_id | dept_id |
+------------+------------+---------+
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 3          | 1       |
| 2          | 4          | 1       |
+------------+------------+---------+
Output:
+------------+-----+
| teacher_id | cnt |
+------------+-----+
| 1          | 2   |
| 2          | 4   |
+------------+-----+
Explanation:
Teacher 1:
- They teach subject 2 in departments 3 and 4.
- They teach subject 3 in department 3.
Teacher 2:
- They teach subject 1 in department 1.
- They teach subject 2 in department 1.
- They teach subject 3 in department 1.
- They teach subject 4 in department 1.
```

</details>
