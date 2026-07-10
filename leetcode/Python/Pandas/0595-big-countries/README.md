[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I filter the `World` table to get the big countries, which are the ones with a big `area` or a big `population`. My first idea was to use separate filters for `area` and `population`, but I realized I can combine them with `or`. This way fits because it is easy to read and understand.

**How I got there:** I noticed that a country is big if it has a big `area` or a big `population`, so I thought about how to write that as a filter. The `or` operator seemed like the right choice because it lets me combine the two conditions in a straightforward way.

1. Filter the `World` table to get the rows where `area` is at least 3000000 or `population` is at least 25000000.
2. Use the `or` operator to combine the two conditions, so a country is included if either condition is true.
3. Select only the `name`, `population`, and `area` columns from the filtered table.

**Pattern to remember:** When a condition has two parts that are alternatives, use the `or` operator to combine them in a filter.

**Watch out for:** Forgetting to use the `or` operator and trying to filter the table in two separate steps can lead to incorrect results.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 308 ms (beats 8.8%)](https://img.shields.io/badge/Runtime-308%20ms%20(beats%208.8%25)-2cbb5d?style=flat-square)
![Memory: 68.6 MB (beats 78.1%)](https://img.shields.io/badge/Memory-68.6%20MB%20(beats%2078.1%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    return world[
        (world["area"] >= 3000000 ) | (world["population"]>= 25000000)
    ] [["name","population","area"]]
```

Source: [0595-big-countries.py](./0595-big-countries.py)

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
