[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/capital-gainloss/)

# 1393. Capital Gain/Loss

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 18, 2026](https://img.shields.io/badge/Solved%20Jul%2018%2C%202026-555555?style=flat-square)

## How I approached it

I need to calculate the total gain or loss for each stock, which is the sum of the differences between the sell and buy prices for each buy-sell pair. My first idea was to try to match each buy with its corresponding sell, but that gets complicated. Instead, I can just keep a running total of the sells minus the buys for each stock.

**How I got there:** I noticed that each sell has a corresponding buy and each buy has a corresponding sell, so I can just add up the sells and subtract the buys. I started thinking about how to match the buys and sells, but then I realized I could just use the prices directly.

1. Select all columns from the `Stocks` table and add a new column `updated_price` that is the `price` if the operation is 'Sell', and the negative of the `price` if the operation is 'Buy'.
2. Use a subquery to create this new column, which will make it easy to calculate the total gain or loss.
3. Group the results by `stock_name` so I can calculate the total gain or loss for each stock.
4. Calculate the sum of the `updated_price` for each group, which will give me the total gain or loss for each stock.

**Pattern to remember:** When calculating a running total, use a `case` statement to convert the values into the correct signs, then use `sum` to add them up.

**Watch out for:** Forgetting to use the negative sign for the buy prices would result in incorrect totals.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 496 ms (beats 86.4%)](https://img.shields.io/badge/Runtime-496%20ms%20(beats%2086.4%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select stock_name, sum(updated_price) as capital_gain_loss
from
(select *,
case when operation = 'Sell' then price 
else -price end as updated_price
from Stocks)t
Group by stock_name
```

Source: [1393-capital-gainloss.sql](./1393-capital-gainloss.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Stocks`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| stock_name    | varchar |
| operation     | enum    |
| operation_day | int     |
| price         | int     |
+---------------+---------+
(stock_name, operation_day) is the primary key (combination of columns with unique values) for this table.
The operation column is an ENUM (category) of type ('Sell', 'Buy')
Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
```

Write a solution to report the **Capital gain/loss** for each stock.

The **Capital gain/loss** of a stock is the total gain or loss after buying and selling the stock one or many times.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Stocks table:
+---------------+-----------+---------------+--------+
| stock_name    | operation | operation_day | price  |
+---------------+-----------+---------------+--------+
| Leetcode      | Buy       | 1             | 1000   |
| Corona Masks  | Buy       | 2             | 10     |
| Leetcode      | Sell      | 5             | 9000   |
| Handbags      | Buy       | 17            | 30000  |
| Corona Masks  | Sell      | 3             | 1010   |
| Corona Masks  | Buy       | 4             | 1000   |
| Corona Masks  | Sell      | 5             | 500    |
| Corona Masks  | Buy       | 6             | 1000   |
| Handbags      | Sell      | 29            | 7000   |
| Corona Masks  | Sell      | 10            | 10000  |
+---------------+-----------+---------------+--------+
Output:
+---------------+-------------------+
| stock_name    | capital_gain_loss |
+---------------+-------------------+
| Corona Masks  | 9500              |
| Leetcode      | 8000              |
| Handbags      | -23000            |
+---------------+-------------------+
Explanation:
Leetcode stock was bought at day 1 for 1000$ and was sold at day 5 for 9000$. Capital gain = 9000 - 1000 = 8000$.
Handbags stock was bought at day 17 for 30000$ and was sold at day 29 for 7000$. Capital loss = 7000 - 30000 = -23000$.
Corona Masks stock was bought at day 1 for 10$ and was sold at day 3 for 1010$. It was bought again at day 4 for 1000$ and was sold at day 5 for 500$. At last, it was bought at day 6 for 1000$ and was sold at day 10 for 10000$. Capital gain/loss is the sum of capital gains/losses for each ('Buy' --> 'Sell') operation = (1010 - 10) + (500 - 1000) + (10000 - 1000) = 1000 - 500 + 9000 = 9500$.
```

</details>
