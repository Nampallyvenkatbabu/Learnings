[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/rising-temperature/)

# 197. Rising Temperature

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I need to compare each day's temperature to the previous day's, so I join the table to itself on the date difference. My first idea was to use a subquery to get yesterday's temperature, but a self-join is easier with `DATEDIFF` and a `WHERE` clause.

**How I got there:** I noticed that each row has a unique `id` but the `recordDate` is what matters for this comparison, so I used `DATEDIFF` to find the rows that are one day apart. I also realized that I need to compare the temperatures where the dates are consecutive.

1. Join the `Weather` table to itself on the condition that the date difference is one day, using `DATEDIFF` to calculate this difference.
2. Use the `WHERE` clause to filter the joined rows where the temperature is higher than the previous day's temperature.
3. Select only the `id` from the joined table where the temperature condition is met.

**Pattern to remember:** When comparing rows that are related by a time or sequence difference, a self-join with a date or sequence condition can be a good approach.

**Watch out for:** Forgetting to include the date condition in the `JOIN` or `WHERE` clause would result in incorrect comparisons between unrelated rows.

## Solution

![Time: O(n^2)](https://img.shields.io/badge/Time-O(n%5E2)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 466 ms (beats 76.1%)](https://img.shields.io/badge/Runtime-466%20ms%20(beats%2076.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
```

Source: [0197-rising-temperature.sql](./0197-rising-temperature.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Weather`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
```

Write a solution to find all dates' `id` with higher temperatures compared to its previous dates (yesterday).

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation:
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
```

</details>
