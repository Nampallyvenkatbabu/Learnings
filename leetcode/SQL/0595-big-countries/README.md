[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the countries that are big, which means they have a large `area` or a large `population`. My first idea was to use if statements, but that is too slow, and a `filter` can do the same thing faster.

**How I got there:** I looked at the conditions for a country to be big and saw that it is either a large `area` or a large `population`, so I asked how I can filter a table based on two conditions. That led me to use the `or` operator to combine the two conditions.

1. Import the `pandas` library to work with tables.
2. Define a function `big_countries` that takes a table `world` as input and returns a new table with the big countries.
3. Use a `filter` to select the rows where the `area` is at least 3000000 or the `population` is at least 25000000.
4. Select only the `name`, `population`, and `area` columns from the filtered table.

**Pattern to remember:** When I need to select rows based on multiple conditions, I can use the `or` operator to combine the conditions and then use a `filter` to select the rows.

**Watch out for:** If I forget to use the `or` operator and use the `and` operator instead, I will get only the countries that are big in both `area` and `population`, which is not what I want.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 271 ms (beats 99.5%)](https://img.shields.io/badge/Runtime-271%20ms%20(beats%2099.5%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select name,population,area from World
where area >= 3000000 or population >= 25000000
```

Source: [0595-big-countries.sql](./0595-big-countries.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `World`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
```

A country is **big** if:

- it has an area of at least three million (i.e., `3000000 km^2`), or
- it has a population of at least twenty-five million (i.e., `25000000`).

Write a solution to find the name, population, and area of the **big countries**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
World table:
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
Output:
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+
```

</details>
