[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/patients-with-a-condition/)

# 1527. Patients With a Condition

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to find patients with conditions that start with `DIAB1`, so I use a regular expression to match this pattern in the `conditions` column. My first idea was to split the conditions into separate codes, but that would be too slow. Using a regular expression fits because it can match a prefix in a string with multiple codes. I want all the columns for these patients, so I select `patient_id`, `patient_name`, and `conditions`.

**How I got there:** I noticed that the conditions are stored as a string with codes separated by spaces, and Type I Diabetes always starts with `DIAB1`. That told me to use a regular expression to match this prefix in the string. I asked what would be the easiest way to match a prefix in a string, and using `REGEXP` in MySQL seemed like the best option.

1. Select all columns `patient_id`, `patient_name`, and `conditions` from the `Patients` table.
2. Use a `WHERE` clause to filter the rows based on the `conditions` column.
3. In the `WHERE` clause, use the `REGEXP` function to match the pattern `DIAB1` in the `conditions` column.

**Pattern to remember:** When searching for a prefix in a string, use a regular expression with `REGEXP`.

**Watch out for:** Not using the `REGEXP` function would make it hard to match the prefix `DIAB1` in the string.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)
![Runtime: 529 ms (beats 10.6%)](https://img.shields.io/badge/Runtime-529%20ms%20(beats%2010.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select patient_id,
patient_name,
conditions
from Patients
where conditions REGEXP '(^| )DIAB1'
```

Source: [1527-patients-with-a-condition.sql](./1527-patients-with-a-condition.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Patients`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces.
This table contains information of the patients in the hospital.
```

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with `DIAB1` prefix.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+
Output:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.
```

</details>
