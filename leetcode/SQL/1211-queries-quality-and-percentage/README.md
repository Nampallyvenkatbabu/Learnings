[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/queries-quality-and-percentage/)

# 1211. Queries Quality and Percentage

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I calculate the `quality` of each query by averaging the ratio of `rating` to `position`, and the `poor_query_percentage` by counting the queries with a `rating` less than 3. My first idea was to calculate these values separately, but I can do both in one query with `GROUP BY`.

**How I got there:** I noticed that I need to group the queries by `query_name`, so I can calculate the average `quality` and `poor_query_percentage` for each query separately. I also saw that I can use a `CASE` statement to count the poor queries.

1. Group the `Queries` table by `query_name` so each query is counted on its own.
2. Calculate the `quality` by averaging the ratio of `rating` to `position` with `AVG(rating/position)`.
3. Calculate the `poor_query_percentage` by counting the queries with a `rating` less than 3 with `SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)` and dividing by the total count of queries.
4. Round both `quality` and `poor_query_percentage` to 2 decimal places with `ROUND`.

**Pattern to remember:** When calculating multiple aggregate values for each group, use `GROUP BY` and calculate all values in one query.

**Watch out for:** Forgetting to multiply by 100.0 when calculating the percentage can result in a truncated value.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 358 ms (beats 80.1%)](https://img.shields.io/badge/Runtime-358%20ms%20(beats%2080.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select query_name,
round(avg(rating/position),2) as quality,
(Round(sum(case when rating < 3 then 1 else 0 end) * 100.0 /count(*),2)) as poor_query_percentage
from Queries
Group by query_name
```

Source: [1211-queries-quality-and-percentage.sql](./1211-queries-quality-and-percentage.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Queries`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
```

We define query `quality` as:

The average of the ratio between query rating and its position.

We also define `poor query percentage` as:

The percentage of all queries with rating less than 3.

Write a solution to find each `query_name`, the `quality` and `poor_query_percentage`.

Both `quality` and `poor_query_percentage` should be **rounded to 2 decimal places**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output:
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation:
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33
```

</details>
