[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/sales-analysis-iii/)

# 1084. Sales Analysis III

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to find products sold only in the first quarter of 2019, so I look for products where the earliest sale date is on or after January 1, 2019, and the latest sale date is on or before March 31, 2019. My first idea was to filter sales by date, but that would not tell me if a product was sold later. I use a `GROUP BY` to consider all sales of each product together.

**How I got there:** I noticed that a product can have many sales, and I need to consider all of them to decide if it was sold only in the first quarter. I thought about using `MIN` and `MAX` to find the earliest and latest sale dates for each product, and then I could filter those to find products that fit the date range.

1. Join the `Product` and `Sales` tables on `product_id` so I can consider each product's sales.
2. Group the joined table by `product_id` and `product_name` so I can look at all sales of each product together.
3. Use `MIN` and `MAX` to find the earliest and latest sale dates for each product, and filter those to find products where the earliest sale date is on or after January 1, 2019, and the latest sale date is on or before March 31, 2019.
4. Return the `product_id` and `product_name` of the products that pass the date filter.

**Pattern to remember:** When I need to consider all instances of something together, like all sales of a product, I use `GROUP BY` and aggregate functions like `MIN` and `MAX`.

**Watch out for:** Forgetting to filter by both the minimum and maximum sale dates could include products that were sold outside the first quarter.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1216 ms (beats 47.1%)](https://img.shields.io/badge/Runtime-1216%20ms%20(beats%2047.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select p.product_id as product_id ,
p.product_name as product_name
from
Product p
inner join
Sales s
on p.product_id = s.product_id
Group by p.product_id,p.product_name
having min(s.sale_date) >= '2019-01-01' and
max(s.sale_date) <= '2019-03-31'
```

Source: [1084-sales-analysis-iii.sql](./1084-sales-analysis-iii.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Product`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the name and the price of each product.
```

Table: `Sales`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table can have duplicate rows.
product_id is a foreign key (reference column) to the Product table.
Each row of this table contains some information about one sale.
```

Write a solution to report the **products** that were ** only** sold in the first quarter of `2019`. That is, between `2019-01-01` and `2019-03-31` inclusive.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+
Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+
Output:
+-------------+--------------+
| product_id  | product_name |
+-------------+--------------+
| 1           | S8           |
+-------------+--------------+
Explanation:
The product with id 1 was only sold in the spring of 2019.
The product with id 2 was sold in the spring of 2019 but was also sold after the spring of 2019.
The product with id 3 was sold after spring 2019.
We return only product 1 as it is the product that was only sold in the spring of 2019.
```

</details>
