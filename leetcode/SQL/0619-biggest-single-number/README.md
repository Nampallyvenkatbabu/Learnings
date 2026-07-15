[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/biggest-single-number/)

# 619. Biggest Single Number

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the largest number that appears only once in the table, so I group the numbers and count how many times each appears. My first idea was to count all the numbers and then filter out the ones that appear more than once, but that would be slow, so I use a `having` clause to only consider numbers that appear once. I use `max` to get the largest of these single numbers.

**How I got there:** I noticed that the problem asks for the largest single number, which means I need to compare all the single numbers, and I can do that with `max`. I also saw that I can use `count` to find out how many times each number appears, and `having` to filter out the numbers that appear more than once.

1. Group the `MyNumbers` table by `num` so each number is counted on its own.
2. Count how many times each `num` appears with `count(*)`, and use `having count(*) = 1` to only consider numbers that appear once.
3. Use `max` to get the largest of these single numbers.

**Pattern to remember:** When I need to find the largest or smallest of something, I can use `max` or `min`, and when I need to filter groups, I can use `having`.

**Watch out for:** If I forget the `having` clause, I will get all numbers, not just the single ones.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 449 ms (beats 47.9%)](https://img.shields.io/badge/Runtime-449%20ms%20(beats%2047.9%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select max(num) as num
from(select num, count(*)
from MyNumbers
Group by num
having count(*) = 1) t
```

Source: [0619-biggest-single-number.sql](./0619-biggest-single-number.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `MyNumbers`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
```

A **single number** is a number that appeared only once in the `MyNumbers` table.

Find the largest **single number**. If there is no ** single number**, report `null`.

The result format is in the following example.

### Example 1

```text
Input:
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output:
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation: The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
```

### Example 2

```text
Input:
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output:
+------+
| num  |
+------+
| null |
+------+
Explanation: There are no single numbers in the input table so we return null.
```

</details>
