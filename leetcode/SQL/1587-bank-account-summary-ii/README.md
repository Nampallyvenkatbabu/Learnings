[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/bank-account-summary-ii/)

# 1587. Bank Account Summary II

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 16, 2026](https://img.shields.io/badge/Solved%20Jul%2016%2C%202026-555555?style=flat-square)

## How I approached it

I need to find users with a balance over 10000, which is the sum of all `amount` values in the `Transactions` table for each account. My first idea was to just sum these values, but I also need to connect this to the `name` in the `Users` table. I use a `join` to connect these tables by `account`.

**How I got there:** I noticed the `account` is the key that links `Users` and `Transactions`, so I knew I had to join these tables on that. Then I saw I could sum the `amount` values and group by `name` to get each user's balance.

1. Join the `Users` and `Transactions` tables on `account` so I can access both `name` and `amount` in one query.
2. Group the results by `name` so I can sum the `amount` values for each user.
3. Sum the `amount` values for each group to get the balance for each user.
4. Use `having` to filter the results to only include users with a balance over 10000.

**Pattern to remember:** When I need to filter aggregated values, I use `having` instead of `where`.

**Watch out for:** Forgetting to use `having` instead of `where` for filtering after aggregation will cause an error.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 955 ms (beats 23.3%)](https://img.shields.io/badge/Runtime-955%20ms%20(beats%2023.3%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select u.name,sum(t.amount) as balance
from
Users u
Inner join
Transactions t
on u.account = t.account
Group by u.name
having sum(t.amount) > 10000
```

Source: [1587-bank-account-summary-ii.sql](./1587-bank-account-summary-ii.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Users`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| account      | int     |
| name         | varchar |
+--------------+---------+
account is the primary key (column with unique values) for this table.
Each row of this table contains the account number of each user in the bank.
There will be no two users having the same name in the table.
```

Table: `Transactions`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| trans_id      | int     |
| account       | int     |
| amount        | int     |
| transacted_on | date    |
+---------------+---------+
trans_id is the primary key (column with unique values) for this table.
Each row of this table contains all changes made to all accounts.
amount is positive if the user received money and negative if they transferred money.
All accounts start with a balance of 0.
```

Write a solution to report the name and balance of users with a balance higher than `10000`. The balance of an account is equal to the sum of the amounts of all transactions involving that account.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Users table:
+------------+--------------+
| account    | name         |
+------------+--------------+
| 900001     | Alice        |
| 900002     | Bob          |
| 900003     | Charlie      |
+------------+--------------+
Transactions table:
+------------+------------+------------+---------------+
| trans_id   | account    | amount     | transacted_on |
+------------+------------+------------+---------------+
| 1          | 900001     | 7000       |  2020-08-01   |
| 2          | 900001     | 7000       |  2020-09-01   |
| 3          | 900001     | -3000      |  2020-09-02   |
| 4          | 900002     | 1000       |  2020-09-12   |
| 5          | 900003     | 6000       |  2020-08-07   |
| 6          | 900003     | 6000       |  2020-09-07   |
| 7          | 900003     | -4000      |  2020-09-11   |
+------------+------------+------------+---------------+
Output:
+------------+------------+
| name       | balance    |
+------------+------------+
| Alice      | 11000      |
+------------+------------+
Explanation:
Alice's balance is (7000 + 7000 - 3000) = 11000.
Bob's balance is 1000.
Charlie's balance is (6000 + 6000 - 4000) = 8000.
```

</details>
