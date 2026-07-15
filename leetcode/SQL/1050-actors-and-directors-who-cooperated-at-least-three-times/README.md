[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/)

# 1050. Actors and Directors Who Cooperated At Least Three Times

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I need to find all pairs of `actor_id` and `director_id` where they worked together at least three times. My first idea was to count all collaborations and then filter, but using `having` is a better fit because it filters after grouping. I can use `count(*)` to get the total collaborations for each pair.

**How I got there:** I looked at the table and saw that each row is a collaboration, so I can use `count(*)` to get the total collaborations for each pair of `actor_id` and `director_id`. I need to group by both `actor_id` and `director_id` to get the collaborations for each pair.

1. Group the `ActorDirector` table by `actor_id` and `director_id` so each pair is counted on their own.
2. Use `count(*)` to get the total collaborations for each pair.
3. Use `having count(*) >= 3` to filter the pairs and only keep the ones that collaborated at least three times.
4. Select `actor_id` and `director_id` to get the final result.

**Pattern to remember:** When I need to filter aggregated values, I use `having` instead of `where` because `having` filters after grouping.

**Watch out for:** Using `where` instead of `having` would not work because `where` filters before grouping.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 432 ms (beats 15.7%)](https://img.shields.io/badge/Runtime-432%20ms%20(beats%2015.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select actor_id, director_id
from ActorDirector
Group by actor_id, director_id
having  count(*) >=3
```

Source: [1050-actors-and-directors-who-cooperated-at-least-three-times.sql](./1050-actors-and-directors-who-cooperated-at-least-three-times.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `ActorDirector`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key (column with unique values) for this table.
```

Write a solution to find all the pairs `(actor_id, director_id)` where the actor has cooperated with the director at least three times.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
Output:
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
Explanation: The only pair is (1, 1) where they cooperated exactly 3 times.
```

</details>
