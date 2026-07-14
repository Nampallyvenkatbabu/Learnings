[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/game-play-analysis-i/)

# 511. Game Play Analysis I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the first login date for each player, and since the table is already sorted by player and date, I can use the `min` function to get the earliest date. My first idea was to sort the table by date, but that would be slow, so using `min` with `group by` is a better fit. I group the table by `player_id` and use `min` on the `event_date` to get the first login date.

**How I got there:** I noticed that each player has multiple rows in the table, one for each time they logged in, so I needed a way to pick the earliest date for each player. I thought about sorting the table, but that would not be the best approach, so I looked for a function that could give me the smallest value in a group, which is `min`.

1. Group the `Activity` table by `player_id` so each player is counted on their own.
2. Use the `min` function on the `event_date` column to get the earliest date for each player.
3. Select `player_id` and the result of `min(event_date)` as `first_login` to get the desired output.

**Pattern to remember:** When I need to find the smallest or largest value in a group, I can use the `min` or `max` function with `group by`.

**Watch out for:** If I forget to use `group by`, I will only get one row with the smallest date overall, not one row per player.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 513 ms (beats 49.7%)](https://img.shields.io/badge/Runtime-513%20ms%20(beats%2049.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select player_id,
min(event_date) as first_login
from Activity
Group by player_id
```

Source: [0511-game-play-analysis-i.sql](./0511-game-play-analysis-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Activity`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
```

Write a solution to find the **first login date** for each player.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output:
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
```

</details>
