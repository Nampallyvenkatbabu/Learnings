[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/find-users-with-valid-e-mails/)

# 1517. Find Users With Valid E-Mails

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I need to filter the `Users` table for rows where the `mail` column has a valid email address, which means it must start with a letter and end with `@leetcode.com`. My first idea was to use string functions to check each part of the email, but a regular expression can do it all at once with a single `regexp` check.

**How I got there:** I noticed that the problem defines what makes a valid email, so I thought about how to match that definition with a `regexp`. The `regexp` has to check that the email starts with a letter, then has any number of allowed characters, and finally has the exact domain `@leetcode.com`.

1. Select all columns from the `Users` table.
2. Filter the rows with a `where` clause that checks the `mail` column against a `regexp` pattern.
3. The `regexp` pattern `^[A-Za-z][A-Za-z0-9_.-]*@leetcode.com$` checks that the email starts with a letter, has any number of allowed characters, and ends with `@leetcode.com`.

**Pattern to remember:** Use a `regexp` to check a string against a complex pattern, like the rules for a valid email address.

**Watch out for:** Forgetting to escape special characters like the dot in `leetcode.com` with a backslash `.`, so it gets treated as a wildcard instead of a literal dot.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

select user_id,name,mail
from Users
where mail regexp '^[A-Za-z][A-Za-z0-9_.-]*@leetcode.\com$'
```

Source: [1517-find-users-with-valid-e-mails.sql](./1517-find-users-with-valid-e-mails.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Users`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
```

Write a solution to find the users who have **valid emails**.

A valid e-mail has a prefix name and a domain where:

- **The prefix name** is a string that may contain letters (upper or lower case), digits, underscore `'_'`, period `'.'`, and/or dash `'-'`. The prefix name ** must** start with a letter.
- **The domain** must be exactly `'@leetcode.com'` in lowercase.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Users table:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
+---------+-----------+-------------------------+
Output:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
+---------+-----------+-------------------------+
Explanation:
The mail of user 2 does not have a domain.
The mail of user 5 has the # sign which is not allowed.
The mail of user 6 does not have the leetcode domain.
The mail of user 7 starts with a period.
```

</details>
