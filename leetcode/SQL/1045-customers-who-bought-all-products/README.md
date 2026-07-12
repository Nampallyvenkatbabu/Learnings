[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customers-who-bought-all-products/)

# 1045. Customers Who Bought All Products

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to find which customers bought all products, so I compare the number of distinct products each customer bought to the total number of products. My first idea was to join the tables, but that gets complicated, so I used a `GROUP BY` and a subquery to count products. I want to avoid counting duplicate products for the same customer, so a `COUNT(DISTINCT ...)` helps.

**How I got there:** I noticed the `Customer` table can have duplicate rows, so I had to use `DISTINCT` when counting products per customer. I also saw that I need to know the total number of products, which is easy to get from the `Product` table.

1. Group the `Customer` table by `customer_id` so each customer is counted on their own.
2. Count `DISTINCT product_key` inside each group to get the number of unique products each customer bought.
3. Use a subquery to get the total number of products from the `Product` table.
4. Use a `HAVING` clause to filter the customers who bought all products, by comparing the count of distinct products to the total number of products.

**Pattern to remember:** When comparing counts, use `COUNT(DISTINCT ...)` to avoid counting duplicates, and subqueries to get related counts from other tables.

**Watch out for:** Not using `DISTINCT` when counting products per customer will give incorrect results if a customer bought the same product multiple times.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 658 ms (beats 22.1%)](https://img.shields.io/badge/Runtime-658%20ms%20(beats%2022.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select customer_id
from Customer
Group by customer_id
having count(DISTINCT product_key) = (
    select count(*)
    from Product
)

/* Alternative solution with corelated subquery

select DISTINCT c.customer_id
from Customer c
where not exists(
    select p.product_key 
    from Product p
    where not exists (
        select 1
        from Customer c2
        where c2.customer_id = c.customer_id 
        and  c2.product_key  = p.product_key 
    )
)

*/
```

Source: [1045-customers-who-bought-all-products.sql](./1045-customers-who-bought-all-products.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Customer`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows.
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
```

Table: `Product`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
```

Write a solution to report the customer ids from the `Customer` table that bought all the products in the `Product` table.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output:
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation:
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.
```

</details>
