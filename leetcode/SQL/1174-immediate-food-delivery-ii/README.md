[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/immediate-food-delivery-ii/)

# 1174. Immediate Food Delivery II

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the percentage of immediate orders in the first orders of all customers. My first idea was to count all orders, but that does not work because I only care about the first order per customer, and I need to compare `order_date` and `customer_pref_delivery_date` to decide if an order is immediate. I use a subquery to find the first order for each customer.

**How I got there:** I noticed that the first order for a customer is the one with the earliest `order_date`, so I used `min(order_date)` to find that. Then I compared `order_date` and `customer_pref_delivery_date` to see if an order is immediate.

1. Find the first order for each customer by selecting the minimum `order_date` per `customer_id`.
2. Use the result of the subquery to filter the `Delivery` table and only keep the first order for each customer.
3. Compare `order_date` and `customer_pref_delivery_date` for each of these first orders to decide if the order is immediate.
4. Calculate the average of these immediate orders, treating each immediate order as 1 and each scheduled order as 0.
5. Multiply this average by 100 to convert it to a percentage and round to 2 decimal places.

**Pattern to remember:** When I need to find a percentage based on some condition, I can use `avg` with a boolean expression that treats true as 1 and false as 0.

**Watch out for:** If I forget to filter for the first order per customer, I will count some customers multiple times.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 631 ms (beats 69.1%)](https://img.shields.io/badge/Runtime-631%20ms%20(beats%2069.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select 
Round(avg(order_date = customer_pref_delivery_date) * 100.0,2) as immediate_percentage 
from Delivery 
where (customer_id, order_date) in (
    select customer_id,min(order_date) as order_date 
    from Delivery 
    Group by customer_id
)
```

Source: [1174-immediate-food-delivery-ii.sql](./1174-immediate-food-delivery-ii.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Delivery`

```text
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
```

If the customer's preferred delivery date is the same as the order date, then the order is called **immediate;** otherwise, it is called ** scheduled**.

The **first order** of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, **rounded to 2 decimal places**.

The result format is in the following example.

### Example 1

```text
Input:
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output:
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
Explanation:
The customer id 1 has a first order with delivery id 1 and it is scheduled.
The customer id 2 has a first order with delivery id 2 and it is immediate.
The customer id 3 has a first order with delivery id 5 and it is scheduled.
The customer id 4 has a first order with delivery id 7 and it is immediate.
Hence, half the customers have immediate first orders.
```

</details>
