[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/percentage-of-users-attended-a-contest/)

# 1633. Percentage of Users Attended a Contest

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to find what percentage of users signed up for each contest, so I count the distinct users per contest and divide by the total number of users. My first idea was to count all users, but that does not work because I need to count each user only once per contest, which is why I use `count(distinct user_id)`. This way fits because it gives the right percentage for each contest.

**How I got there:** I noticed that the same user can sign up for many contests, so I had to count each user only once per contest. That told me to use `count(distinct user_id)` instead of just `count(user_id)`. I also saw that I need the total number of users, which I can get with a subquery on the `Users` table.

1. Group the `Register` table by `contest_id` so each contest is counted on its own.
2. Count the distinct `user_id` for each contest with `count(distinct user_id)` and divide by the total number of users from the `Users` table.
3. Use `Round` to round the result to two decimals.
4. Order the result by `percentage` in descending order, and by `contest_id` in ascending order in case of a tie.

**Pattern to remember:** When counting things that can appear more than once, use `count(distinct ...)` to count each one only once.

**Watch out for:** Not using `distinct` when counting users per contest would pass the sample data but break once a user signs up for the same contest multiple times.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1188 ms (beats 15.9%)](https://img.shields.io/badge/Runtime-1188%20ms%20(beats%2015.9%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select contest_id,
Round(count(distinct user_id)/(select count(user_id) from Users) * 100.0,2) as percentage 
from Register
Group by contest_id
order by percentage desc,contest_id asc
```

Source: [1633-percentage-of-users-attended-a-contest.sql](./1633-percentage-of-users-attended-a-contest.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Users`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
```

Table: `Register`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
```

Write a solution to find the percentage of the users registered in each contest rounded to **two decimals**.

Return the result table ordered by `percentage` in **descending order**. In case of a tie, order it by `contest_id` in ** ascending order**.

The result format is in the following example.

### Example 1

```text
Input:
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+
Output:
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+
Explanation:
All the users registered in contests 208, 209, and 210. The percentage is 100% and we sort them in the answer table by contest_id in ascending order.
Alice and Alex registered in contest 215 and the percentage is ((2/3) * 100) = 66.67%
Bob registered in contest 207 and the percentage is ((1/3) * 100) = 33.33%
```

</details>
