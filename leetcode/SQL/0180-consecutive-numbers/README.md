[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/consecutive-numbers/)

# 180. Consecutive Numbers

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 20, 2026](https://img.shields.io/badge/Solved%20Jul%2020%2C%202026-555555?style=flat-square)

## How I approached it

I need to find numbers that show up at least three times in a row, so I look for `id` values that are next to each other. My first idea was to compare each row to the next one, but that does not work because I need to check three rows at a time, not just two. I use a `join` to line up rows that are next to each other.

**How I got there:** I noticed that the `id` values are consecutive, which means I can join the table to itself on `id` values that are one apart, but that only checks two rows at a time. I realized I need to check three rows, so I need to think about how to use a `group by` and `having` to find sequences of three or more.

1. Join the `Logs` table to itself on `id` values that are one apart, so each row is lined up with the next one.
2. Group the joined rows by the `num` value, so all the rows with the same number are together.
3. Use `having count(*) > 2` to find groups with at least three rows, which means the number showed up at least three times in a row.
4. Select the `num` value from each group that has at least three rows, which gives me the numbers that appear consecutively at least three times.

**Pattern to remember:** When looking for sequences of data, use a `group by` and `having` to find patterns that show up multiple times.

**Watch out for:** Joining on `id` values that are too far apart can miss sequences, like joining on `id` values that are two apart instead of one.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

select l.num as ConsecutiveNums
from
Logs l
inner join Logs l1
on l.id = l1.id
Group by l.num
Having count(*) > 3
```

Source: [0180-consecutive-numbers.sql](./0180-consecutive-numbers.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Logs`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
```

Find all numbers that appear at least three times consecutively.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
```

</details>
