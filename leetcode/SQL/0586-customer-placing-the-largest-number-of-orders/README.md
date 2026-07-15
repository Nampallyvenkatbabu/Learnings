[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/)

# 586. Customer Placing the Largest Number of Orders

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I want the customer who placed the most orders, which is the one with the highest count of rows in the Orders table. My first idea was to just count the orders for each customer, but I need to find the one with the highest count. I can use a `GROUP BY` and `HAVING` to filter the results.

**How I got there:** I noticed that I need to count the orders for each customer, so I used a `GROUP BY` on the `customer_number`. Then I realized I need to find the customer with the highest count, which led me to use a `HAVING` clause to filter the results.

1. Group the Orders table by `customer_number` so each customer is counted on their own.
2. Count the number of rows for each customer using `count(*)`.
3. Use a `HAVING` clause to filter the results and only return the customer with the highest count, but the submitted code uses `having count(*) > 1` which is incorrect because it doesn't guarantee the customer with the most orders.
4. The correct approach should use a subquery to find the maximum count and then select the customer with that count.

**Pattern to remember:** When I need to find the row with the maximum or minimum value in a group, I can use a subquery to find that value and then select the row with that value.

**Watch out for:** The submitted code `having count(*) > 1` is incorrect because it only returns customers with more than one order, not the customer with the most orders.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

select customer_number
from Orders
Group by customer_number
having count(*) > 1
order by count(*)
Limit 1
```

Source: [0586-customer-placing-the-largest-number-of-orders.sql](./0586-customer-placing-the-largest-number-of-orders.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Orders`

```text
+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
```

Write a solution to find the `customer_number` for the customer who has placed **the largest number of orders**.

The test cases are generated so that **exactly one customer** will have placed more orders than any other customer.

The result format is in the following example.

### Example 1

```text
Input:
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output:
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation:
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order.
So the result is customer_number 3.
```

**Follow up:** What if more than one customer has the largest number of orders, can you find all the `customer_number` in this case?

</details>
