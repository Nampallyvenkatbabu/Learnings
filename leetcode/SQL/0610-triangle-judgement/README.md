[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/triangle-judgement/)

# 610. Triangle Judgement

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I check if the sum of the two shorter sides is longer than the longest side, which is the rule for a triangle, and my query uses a `CASE` statement to apply this rule. My first idea was to compare each side to the others, but this way is simpler. I use the triangle rule to decide if the line segments can form a triangle.

**How I got there:** I looked at the triangle rule, which says the sum of two sides must be longer than the third side, so I asked how to check this with the given lengths. I realized I need to check all three combinations, but since I only have three sides, I can just check if the sum of the two shorter sides is longer than the longest side.

1. Select all columns `x`, `y`, `z` from the `Triangle` table.
2. Use a `CASE` statement to check if `x+y` is less than or equal to `z`, because if it is, the segments cannot form a triangle.
3. If `x+y` is greater than `z`, then the segments can form a triangle, so return 'Yes', otherwise return 'No'.

**Pattern to remember:** When checking if three line segments can form a triangle, use the triangle rule that the sum of two sides must be longer than the third side.

**Watch out for:** Not checking all three combinations of sides, which would miss some cases where the segments cannot form a triangle.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 287 ms (beats 80.6%)](https://img.shields.io/badge/Runtime-287%20ms%20(beats%2080.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select x,y,z,
CASE
    when x+y > z
    and y+z > x
    and z+x > y then 'Yes' else 'No'
END as triangle
from Triangle
```

Source: [0610-triangle-judgement.sql](./0610-triangle-judgement.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Triangle`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
```

Report for every three line segments whether they can form a triangle.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Output:
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
```

</details>
