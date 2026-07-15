[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/monthly-transactions-i/)

# 1193. Monthly Transactions I

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I want to get the total and approved transactions for each month and country, but my first idea was to use subqueries which would be too slow. I can use `GROUP BY` and `CASE` statements to get the counts and sums I need in one query. This way I can get all the information I need without having to join multiple queries together.

**How I got there:** I noticed that the `trans_date` column has a date type, so I can use the `DATE_FORMAT` function to get the month and year. I also saw that the `state` column has only two values, 'approved' and 'declined', so I can use a `CASE` statement to count and sum only the approved transactions.

1. Extract the month and year from the `trans_date` column using `DATE_FORMAT(trans_date, '%Y-%m')`.
2. Group the transactions by the extracted month and `country` using `GROUP BY`.
3. Count all transactions using `count(trans_date)` and approved transactions using `sum(case when state ='approved' then 1 else 0 end)`.
4. Sum all transaction amounts using `sum(amount)` and approved transaction amounts using `sum(case when state ='approved' then amount else 0 end)`.

**Pattern to remember:** Using `CASE` statements inside `SUM` and `COUNT` aggregation functions to filter data without having to use subqueries or joins.

**Watch out for:** Using `month(trans_date)` in the `GROUP BY` clause instead of the extracted month from `DATE_FORMAT` would not work because `month(trans_date)` returns only the month number, not the year.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 639 ms (beats 34.0%)](https://img.shields.io/badge/Runtime-639%20ms%20(beats%2034.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select DATE_FORMAT(trans_date, '%Y-%m') as month,
country,
count(trans_date) as trans_count,
sum(case when state ='approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state ='approved' then amount else 0 end) as approved_total_amount
from Transactions
Group by DATE_FORMAT(trans_date, '%Y-%m'),country;
```

Source: [1193-monthly-transactions-i.sql](./1193-monthly-transactions-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Transactions`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
```

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in **any order**.

The query result format is in the following example.

### Example 1

```text
Input:
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
```

</details>
