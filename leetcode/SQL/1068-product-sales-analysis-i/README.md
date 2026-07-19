[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/product-sales-analysis-i/)

# 1068. Product Sales Analysis I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 19, 2026](https://img.shields.io/badge/Solved%20Jul%2019%2C%202026-555555?style=flat-square)

## How I approached it

I need to get the product name from the Product table and the year and price from the Sales table. My first idea was to use a subquery, but a join is a better fit here because I have a clear link between the two tables with product_id. I can join the tables on product_id to get all the data I need in one query.

**How I got there:** I looked at the columns in both tables and saw that product_id is the key that links them, so I thought about how to use that to get the data I want. I realized I could join the tables on product_id to get the product name, year, and price all in one result set.

1. Select the columns I want to see in the result: product_name, year, and price.
2. Join the Sales table and the Product table on the product_id column, which is common to both tables.
3. Use an inner join, which returns only the rows that have a match in both tables, to get the data for each sale.

**Pattern to remember:** When two tables have a common column, use a join to combine them and get all the data in one query.

**Watch out for:** Forgetting to specify the tables that each column comes from, which can cause an error if the column names are not unique.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1230 ms (beats 69.7%)](https://img.shields.io/badge/Runtime-1230%20ms%20(beats%2069.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select p.product_name, 
s.year,
s.price
from Sales s
inner join Product p
on s.product_id = p.product_id
```

Source: [1068-product-sales-analysis-i.sql](./1068-product-sales-analysis-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Sales`

```text
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
```

Table: `Product`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
```

Write a solution to report the `product_name`, `year`, and `price` for each `sale_id` in the `Sales` table.

Return the resulting table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output:
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+
Explanation:
From sale_id = 1, we can conclude that Nokia was sold for 5000 in the year 2008.
From sale_id = 2, we can conclude that Nokia was sold for 5000 in the year 2009.
From sale_id = 7, we can conclude that Apple was sold for 9000 in the year 2011.
```

</details>
