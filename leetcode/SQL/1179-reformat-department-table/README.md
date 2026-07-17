[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/reformat-department-table/)

# 1179. Reformat Department Table

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to turn the `month` column into separate columns for each month. My first idea was to use a `PIVOT` but since I am using MySQL I used `CASE` statements inside `SUM` instead. This way I can get the `revenue` for each `id` and `month` in one query.

**How I got there:** I looked at the `month` column and saw it only has 12 possible values, so I thought I could use a `CASE` statement for each one. I also noticed that the `id` and `month` are the primary key, so I knew I had to `GROUP BY` the `id` to get the `revenue` for each one.

1. Select the `id` column to keep it in the result.
2. Use `SUM` with a `CASE` statement to get the `revenue` for each `month`, like `Jan` or `Feb`, and give it a name like `Jan_Revenue`.
3. Repeat the `SUM` and `CASE` statement for each of the 12 months.
4. Use `GROUP BY` to group the results by `id` so each `id` only appears once.
5. Run the query to get the result table with a `revenue` column for each month.

**Pattern to remember:** When I need to turn rows into columns, I use `CASE` statements inside `SUM` or `MAX` to get the values for each column.

**Watch out for:** Forgetting to `GROUP BY` the `id` would give a wrong result because it would try to sum all revenues together.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 539 ms (beats 56.1%)](https://img.shields.io/badge/Runtime-539%20ms%20(beats%2056.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT
    id,

    SUM(CASE WHEN month='Jan' THEN revenue END) AS Jan_Revenue,
    SUM(CASE WHEN month='Feb' THEN revenue END) AS Feb_Revenue,
    SUM(CASE WHEN month='Mar' THEN revenue END) AS Mar_Revenue,
    SUM(CASE WHEN month='Apr' THEN revenue END) AS Apr_Revenue,
    SUM(CASE WHEN month='May' THEN revenue END) AS May_Revenue,
    SUM(CASE WHEN month='Jun' THEN revenue END) AS Jun_Revenue,
    SUM(CASE WHEN month='Jul' THEN revenue END) AS Jul_Revenue,
    SUM(CASE WHEN month='Aug' THEN revenue END) AS Aug_Revenue,
    SUM(CASE WHEN month='Sep' THEN revenue END) AS Sep_Revenue,
    SUM(CASE WHEN month='Oct' THEN revenue END) AS Oct_Revenue,
    SUM(CASE WHEN month='Nov' THEN revenue END) AS Nov_Revenue,
    SUM(CASE WHEN month='Dec' THEN revenue END) AS Dec_Revenue

FROM Department
GROUP BY id;
```

Source: [1179-reformat-department-table.sql](./1179-reformat-department-table.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Department`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
In SQL,(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
```

Reformat the table such that there is a department id column and a revenue column **for each month**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+
Output:
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+
Explanation: The revenue from Apr to Dec is null.
Note that the result table has 13 columns (1 for the department id + 12 for the months).
```

</details>
