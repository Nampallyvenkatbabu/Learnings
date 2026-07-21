[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/students-and-examinations/)

# 1280. Students and Examinations

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 21, 2026](https://img.shields.io/badge/Solved%20Jul%2021%2C%202026-555555?style=flat-square)

## How I approached it

I need to find how many times each student attended each exam, so I join all students with all subjects, then add the actual attendance from the exams table. My first idea was to just join students with exams, but that would miss students who did not take any exams.

**How I got there:** I noticed that every student takes every course, so I need all possible combinations of students and subjects, which is a cross join of the students and subjects tables. Then I can add the actual exam attendance.

1. Cross join the `Students` and `Subjects` tables to get all possible student-subject combinations.
2. Left join the `Examinations` table on `student_id` and `subject_name` to add the actual exam attendance.
3. Group the result by `student_id`, `student_name`, and `subject_name` to count the attendance for each student-subject pair.
4. Count the number of rows for each group with `count(e.student_id)` and name it `attended_exams`.
5. Order the result by `student_id` and `subject_name`.

**Pattern to remember:** When I need all possible combinations of two tables, a cross join can be the right tool, and then I can filter or aggregate as needed.

**Watch out for:** If I used an inner join instead of a left join with the `Examinations` table, I would miss students who did not take any exams.

## Solution

![Time: O(n*m)](https://img.shields.io/badge/Time-O(n*m)-8250df?style=flat-square)
![Space: O(n*m)](https://img.shields.io/badge/Space-O(n*m)-d29922?style=flat-square)
![Runtime: 1357 ms (beats 8.5%)](https://img.shields.io/badge/Runtime-1357%20ms%20(beats%208.5%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT s.student_id,
s.student_name,
su.subject_name,
count(e.student_id) as attended_exams
FROM Students S
CROSS JOIN Subjects SU
LEFT JOIN Examinations E
    ON S.student_id = E.student_id
    AND SU.subject_name = E.subject_name
GROUP BY S.student_id, S.student_name, SU.subject_name
ORDER BY S.student_id, S.student_name, SU.subject_name
```

Source: [1280-students-and-examinations.sql](./1280-students-and-examinations.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Students`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
```

Table: `Subjects`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
```

Table: `Examinations`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
```

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by `student_id` and `subject_name`.

The result format is in the following example.

### Example 1

```text
Input:
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+
Output:
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
Explanation:
The result table should contain all students and all subjects.
Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
Alex did not attend any exams.
John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.
```

</details>
