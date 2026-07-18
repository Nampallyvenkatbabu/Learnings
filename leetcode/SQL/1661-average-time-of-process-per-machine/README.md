[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/average-time-of-process-per-machine/)

# 1661. Average Time of Process per Machine

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 18, 2026](https://img.shields.io/badge/Solved%20Jul%2018%2C%202026-555555?style=flat-square)

## How I approached it

I calculate the average time each machine takes to complete a process by finding the difference between the average `end` and average `start` timestamps for each machine. My first idea was to join the table with itself, but using `AVG` with a `CASE` statement is simpler. I use `ROUND` to get the result to 3 decimal places.

**How I got there:** I noticed that each process has a `start` and an `end` timestamp, so I looked for a way to calculate the average of these differences for each machine. I realized I could use `AVG` with a `CASE` statement to separate the `start` and `end` timestamps.

1. Group the `activity` table by `machine_id` so each machine is counted on its own.
2. Use `AVG` with a `CASE` statement to find the average `end` timestamp and the average `start` timestamp for each machine.
3. Subtract the average `start` timestamp from the average `end` timestamp to get the average time for each machine.
4. Use `ROUND` to round the result to 3 decimal places and name it `processing_time`.

**Pattern to remember:** When calculating an average based on conditional values, use `AVG` with a `CASE` statement to filter the values.

**Watch out for:** Not using `ROUND` would result in a longer decimal expansion than required.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 260 ms (beats 49.6%)](https://img.shields.io/badge/Runtime-260%20ms%20(beats%2049.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT
machine_id,
ROUND(
AVG(CASE WHEN activity_type = 'end' THEN timestamp END) -
AVG(CASE WHEN activity_type = 'start' THEN timestamp END), 3
) AS processing_time
FROM
activity 
GROUP BY
machine_id;
```

Source: [1661-average-time-of-process-per-machine.sql](./1661-average-time-of-process-per-machine.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Activity`

```text
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The `start` timestamp will always be less than or equal to the `end` timestamp for every `(machine_id, process_id)` pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.
```

There is a factory website that has several machines each running the **same number of processes**. Write a solution to find the ** average time** each machine takes to complete a process.

The time to complete a process is the `'end' timestamp` minus the `'start' timestamp`. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the `machine_id` along with the **average time** as `processing_time`, which should be ** rounded to 3 decimal places**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+
Output:
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+
Explanation:
There are 3 machines running 2 processes each.
Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456
```

</details>
