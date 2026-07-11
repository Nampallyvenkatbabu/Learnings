[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/not-boring-movies/)

# 620. Not Boring Movies

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to filter the movies by `id` and `description`, then sort them by `rating`. My first idea was to use a complex query, but it turns out a simple `where` clause can do the job. I use the modulo operator to check if the `id` is odd.

**How I got there:** I noticed that the problem requires two conditions to be met: the `id` must be odd and the `description` must not be 'boring'. This told me to use an `and` operator in my `where` clause. I also saw that the result needs to be sorted by `rating` in descending order.

1. Select all columns from the `Cinema` table.
2. Use a `where` clause to filter the rows where the `id` is odd (`id%2 = 1`) and the `description` is not 'boring' (`description not like 'boring'`)
3. Order the result by `rating` in descending order (`order by rating DESC`)

**Pattern to remember:** When filtering data based on multiple conditions, use the `and` operator in the `where` clause.

**Watch out for:** Forgetting to use the `not like` operator to exclude the 'boring' descriptions would include unwanted rows in the result.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 259 ms (beats 84.7%)](https://img.shields.io/badge/Runtime-259%20ms%20(beats%2084.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select *
from Cinema
where id%2 = 1 and description not like 'boring'
order by rating DESC
```

Source: [0620-not-boring-movies.sql](./0620-not-boring-movies.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Cinema`

```text
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
```

Write a solution to report the movies with an odd-numbered ID and a description that is not `"boring"`.

Return the result table ordered by `rating` **in descending order**.

The result format is in the following example.

### Example 1

```text
Input:
Cinema table:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
Output:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
Explanation:
We have three movies with odd-numbered IDs: 1, 3, and 5. The movie with ID = 3 is boring so we do not include it in the answer.
```

</details>
