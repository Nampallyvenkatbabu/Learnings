[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/)

# 1141. User Activity for the Past 30 Days I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I count active users per day by grouping the `Activity` table by `activity_date` and counting `distinct user_id`. My first idea was to filter the dates first, but that does not work because I need to filter after grouping. This way fits because it lets me count users per day.

**How I got there:** I noticed that the problem asks for the count of active users per day, so I thought about how to group the table by date. The `having` clause lets me filter the dates after grouping, which is what I need.

1. Select `activity_date` and count `distinct user_id` to get the active users per day.
2. Group the `Activity` table by `activity_date` so each day is counted on its own.
3. Use the `having` clause to filter the dates between '2019-06-27' and '2019-07-27'.

**Pattern to remember:** When counting per group, use `distinct` to count each item only once and `having` to filter after grouping.

**Watch out for:** Using `where` instead of `having` to filter the dates would filter the rows before grouping, which is not what I want.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

select activity_date as day,
count(distinct user_id) as active_users
from Activity
Group by activity_date
having activity_date between '2019-06-27' and '2019-07-27'
```

Source: [1141-user-activity-for-the-past-30-days-i.sql](./1141-user-activity-for-the-past-30-days-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Activity`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website.
Note that each session belongs to exactly one user.
```

Write a solution to find the daily active user count for a period of `30` days ending `2019-07-27` inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in **any order**.

The result format is in the following example.

Note: **Any** activity from (`'open_session'`, `'end_session'`, `'scroll_down'`, `'send_message'`) will be considered valid activity for a user to be considered active on a day.

### Example 1

```text
Input:
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output:
+------------+--------------+
| day        | active_users |
+------------+--------------+
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+
Explanation: Note that we do not care about days with zero active users.
```

</details>
