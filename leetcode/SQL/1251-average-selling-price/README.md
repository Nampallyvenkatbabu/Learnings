[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/average-selling-price/)

# 1251. Average Selling Price

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 16, 2026](https://img.shields.io/badge/Solved%20Jul%2016%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the average selling price for each product by matching sales with the correct price period. My first idea was to calculate the total price and total units separately, but it's more straightforward to do it in one step with a join and sum of price times units. I use a join to match sales with the correct price period, then group by product to calculate the average price.

**How I got there:** I noticed that the sales date must fall within a price period, so I used a join with a date range condition to match sales with the correct price. I also saw that I need to calculate the total price for each product, which is the sum of the price times the units sold, and divide it by the total units sold.

1. Join the `Prices` and `UnitsSold` tables on `product_id` and the date range condition to match sales with the correct price period.
2. Calculate the total price for each product by summing the product of `price` and `units`.
3. Calculate the total units sold for each product by summing `units`.
4. Divide the total price by the total units to get the average price for each product, and round it to 2 decimal places.
5. Group the results by `product_id` to get one row per product.

**Pattern to remember:** When calculating an average that depends on a condition, use a join and sum of the product of the values to be averaged and the condition, then divide by the sum of the condition.

**Watch out for:** If the join condition is incorrect, sales may be matched with the wrong price period, resulting in incorrect average prices.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

select p.product_id,
Round((sum(price * units)/sum(units)),2) as average_price 
FROM Prices p
Inner join
UnitsSold u
on p.product_id = u.product_id and 
u.purchase_date BETWEEN p.Start_date and p.end_date
Group by p.product_id
```

Source: [1251-average-selling-price.sql](./1251-average-selling-price.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Prices`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
```

Table: `UnitsSold`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold.
```

Write a solution to find the average selling price for each product. `average_price` should be **rounded to 2 decimal places**. If a product does not have any sold units, its average selling price is assumed to be 0.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output:
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
Explanation:
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
```

</details>
