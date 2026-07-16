[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/daily-leads-and-partners/)

# 1693. Daily Leads and Partners

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the number of distinct `lead_id` and `partner_id` for each `date_id` and `make_name`. My first idea was to count all `lead_id` and `partner_id`, but that would not give the distinct count. Using `count(distinct ...)` solves this problem because it only counts each `lead_id` and `partner_id` once.

**How I got there:** I noticed that the problem asks for the distinct count of `lead_id` and `partner_id`, so I thought about how to get that from the table. I realized that I can use `count(distinct ...)` to get the count of unique `lead_id` and `partner_id` for each group of `date_id` and `make_name`.

1. Group the `DailySales` table by `date_id` and `make_name` so each date and make is counted separately.
2. Count the distinct `lead_id` for each group using `count(distinct lead_id)` and store it as `unique_leads`.
3. Count the distinct `partner_id` for each group using `count(distinct partner_id)` and store it as `unique_partners`.
4. Return one row per group with the `date_id`, `make_name`, `unique_leads`, and `unique_partners`.

**Pattern to remember:** Using `count(distinct ...)` to get the count of unique values in a group

**Watch out for:** Not using `distinct` in the count would result in incorrect counts if there are duplicate `lead_id` or `partner_id` in the table

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 651 ms (beats 16.6%)](https://img.shields.io/badge/Runtime-651%20ms%20(beats%2016.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select date_id, make_name,
count(distinct lead_id) as unique_leads,
count(distinct partner_id) as unique_partners 
from DailySales
Group by date_id, make_name
```

Source: [1693-daily-leads-and-partners.sql](./1693-daily-leads-and-partners.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `DailySales`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| date_id     | date    |
| make_name   | varchar |
| lead_id     | int     |
| partner_id  | int     |
+-------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
This table contains the date and the name of the product sold and the IDs of the lead and partner it was sold to.
The name consists of only lowercase English letters.
```

For each `date_id` and `make_name`, find the number of **distinct** `lead_id`'s and ** distinct** `partner_id`'s.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
DailySales table:
+-----------+-----------+---------+------------+
| date_id   | make_name | lead_id | partner_id |
+-----------+-----------+---------+------------+
| 2020-12-8 | toyota    | 0       | 1          |
| 2020-12-8 | toyota    | 1       | 0          |
| 2020-12-8 | toyota    | 1       | 2          |
| 2020-12-7 | toyota    | 0       | 2          |
| 2020-12-7 | toyota    | 0       | 1          |
| 2020-12-8 | honda     | 1       | 2          |
| 2020-12-8 | honda     | 2       | 1          |
| 2020-12-7 | honda     | 0       | 1          |
| 2020-12-7 | honda     | 1       | 2          |
| 2020-12-7 | honda     | 2       | 1          |
+-----------+-----------+---------+------------+
Output:
+-----------+-----------+--------------+-----------------+
| date_id   | make_name | unique_leads | unique_partners |
+-----------+-----------+--------------+-----------------+
| 2020-12-8 | toyota    | 2            | 3               |
| 2020-12-7 | toyota    | 1            | 2               |
| 2020-12-8 | honda     | 2            | 2               |
| 2020-12-7 | honda     | 3            | 2               |
+-----------+-----------+--------------+-----------------+
Explanation:
For 2020-12-8, toyota gets leads = [0, 1] and partners = [0, 1, 2] while honda gets leads = [1, 2] and partners = [1, 2].
For 2020-12-7, toyota gets leads = [0] and partners = [1, 2] while honda gets leads = [0, 1, 2] and partners = [1, 2].
```

</details>
