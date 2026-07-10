[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/duplicate-emails/)

# 182. Duplicate Emails

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I need to find emails that show up more than once in the `Person` table. My first idea was to compare each email to every other one, but that would be slow. I can use a `GROUP BY` to count how many times each email appears, and then filter for the ones that appear more than once.

**How I got there:** I noticed that the `email` field is not unique, so I thought about how to group these emails together. I realized I could use the `GROUP BY` clause to make groups of emails, and then use `COUNT(*)` to see how many times each email appears.

1. Group the `Person` table by `email` so all the same emails are together.
2. Count how many times each `email` appears in its group with `COUNT(*)`.
3. Use `HAVING COUNT(*) > 1` to filter for only the groups with more than one email.

**Pattern to remember:** When I need to find duplicates, I can use `GROUP BY` and `HAVING COUNT(*) > 1` to find the values that appear more than once.

**Watch out for:** Forgetting the `HAVING` clause and using `WHERE` instead would cause an error because `WHERE` can't be used with aggregate functions like `COUNT(*)`.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 346 ms (beats 99.5%)](https://img.shields.io/badge/Runtime-346%20ms%20(beats%2099.5%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select email from Person
group by email
having count(*) > 1;
```

Source: [0182-duplicate-emails.sql](./0182-duplicate-emails.sql)

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

Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output:
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
```

</details>
