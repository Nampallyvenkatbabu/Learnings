[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/delete-duplicate-emails/)

# 196. Delete Duplicate Emails

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I want to keep only one row per email, the one with the smallest `id`. My first idea was to find the smallest `id` for each email, but I need a way to mark the duplicates so I can delete them. I use `ROW_NUMBER()` to label duplicates directly.

**How I got there:** I noticed that `ROW_NUMBER()` can assign a unique number to each row within a group, so I can use it to mark duplicates by partitioning the table by `email` and ordering by `id`. This way I can identify the rows that are not the smallest `id` for each email.

1. Partition the `Person` table by `email` so each email is grouped together.
2. Use `ROW_NUMBER()` to assign a unique number to each row within each group, ordering by `id` so the smallest `id` gets number 1.
3. Select the `id` of rows where the row number is greater than 1, which are the duplicates.
4. Delete the rows from the `Person` table where the `id` is in the list of duplicates.

**Pattern to remember:** Use `ROW_NUMBER()` to label duplicates when the goal is to keep only one row per group based on some criteria.

**Watch out for:** Using `NOT IN` with a subquery that returns `NULL` values can lead to incorrect results, so be careful when using this approach with tables that may contain `NULL` values.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 519 ms (beats 99.8%)](https://img.shields.io/badge/Runtime-519%20ms%20(beats%2099.8%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

-- ✅ Optimized Solution using ROW_NUMBER()
-- Why better:
-- 1. Labels duplicates directly in one pass (rn > 1).
-- 2. No need to build a survivor list and then compare.
-- 3. More flexible: you can change ORDER BY to keep latest instead of smallest.
-- 4. Generally faster on large tables because it avoids the NOT IN overhead.

DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
        FROM Person
    ) ranked
    WHERE rn > 1
);


/*
-- 🔄 Alternative Solution using NOT IN + MIN(id)
-- Why alternative:
-- 1. Simple and intuitive: build survivor list (MIN(id) per email).
-- 2. Works even in older MySQL versions (before 8.0, which don’t support ROW_NUMBER).
-- 3. But less optimized: requires two steps (aggregate → compare).
-- 4. Can be slower on big tables and tricky if NULLs are present.

DELETE FROM Person
WHERE id NOT IN (
    SELECT id 
    FROM (
        SELECT MIN(id) AS id
        FROM Person
        GROUP BY email
    ) t
);
*/
```

Source: [0196-delete-duplicate-emails.sql](./0196-delete-duplicate-emails.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Person`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
```

Write a solution to **delete** all duplicate emails, keeping only one unique email with the smallest `id`.

For SQL users, please note that you are supposed to write a `DELETE` statement and not a `SELECT` one.

For Pandas users, please note that you are supposed to modify `Person` in place.

After running your script, the answer shown is the `Person` table. The driver will first compile and run your piece of code and then show the `Person` table. The final order of the `Person` table **does not matter**.

The result format is in the following example.

### Example 1

```text
Input:
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
```

</details>
