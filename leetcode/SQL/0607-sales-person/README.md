[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/sales-person/)

# 607. Sales Person

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I want to find all salespersons who did not have any orders related to the company with the name `RED`. My first idea was to look for salespersons with no orders, but that is not enough because a salesperson can have orders with other companies. I need to find salespersons who have orders but none of them are with `RED`.

**How I got there:** I noticed that the `Orders` table has a foreign key to both `SalesPerson` and `Company`, so I can join these tables to find salespersons with orders from specific companies. I realized I need to exclude salespersons who have orders with `RED`, and include those who have no orders or only orders with other companies.

1. Join the `SalesPerson` table with the `Orders` table on `sales_id` to find all salespersons who have orders.
2. Join the `Orders` table with the `Company` table on `com_id` to find the companies associated with each order.
3. Filter the results to exclude salespersons who have orders with the company `RED`, and include salespersons who have no orders or only orders with other companies by using `where c.name <> 'RED' or c.name is null`.

**Pattern to remember:** When excluding items based on a condition, consider using a `left join` and filtering the results to include `null` values, which represent the absence of a match.

**Watch out for:** Not including `or c.name is null` in the `where` clause would exclude salespersons who have no orders, which is not the desired result.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
# Write your MySQL query statement below

select s.name
from SalesPerson s
left join
Orders o
on s.sales_id = o.sales_id and com_id <> 3
left join 
Company c
on o.com_id = c.com_id
where c.name <> 'RED' or c.name is null
```

Source: [0607-sales-person.sql](./0607-sales-person.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `SalesPerson`

```text
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| sales_id        | int     |
| name            | varchar |
| salary          | int     |
| commission_rate | int     |
| hire_date       | date    |
+-----------------+---------+
sales_id is the primary key (column with unique values) for this table.
Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.
```

Table: `Company`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| com_id      | int     |
| name        | varchar |
| city        | varchar |
+-------------+---------+
com_id is the primary key (column with unique values) for this table.
Each row of this table indicates the name and the ID of a company and the city in which the company is located.
```

Table: `Orders`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| order_date  | date |
| com_id      | int  |
| sales_id    | int  |
| amount      | int  |
+-------------+------+
order_id is the primary key (column with unique values) for this table.
com_id is a foreign key (reference column) to com_id from the Company table.
sales_id is a foreign key (reference column) to sales_id from the SalesPerson table.
Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.
```

Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name **"RED"**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
SalesPerson table:
+----------+------+--------+-----------------+------------+
| sales_id | name | salary | commission_rate | hire_date  |
+----------+------+--------+-----------------+------------+
| 1        | John | 100000 | 6               | 4/1/2006   |
| 2        | Amy  | 12000  | 5               | 5/1/2010   |
| 3        | Mark | 65000  | 12              | 12/25/2008 |
| 4        | Pam  | 25000  | 25              | 1/1/2005   |
| 5        | Alex | 5000   | 10              | 2/3/2007   |
+----------+------+--------+-----------------+------------+
Company table:
+--------+--------+----------+
| com_id | name   | city     |
+--------+--------+----------+
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |
+--------+--------+----------+
Orders table:
+----------+------------+--------+----------+--------+
| order_id | order_date | com_id | sales_id | amount |
+----------+------------+--------+----------+--------+
| 1        | 1/1/2014   | 3      | 4        | 10000  |
| 2        | 2/1/2014   | 4      | 5        | 5000   |
| 3        | 3/1/2014   | 1      | 1        | 50000  |
| 4        | 4/1/2014   | 1      | 4        | 25000  |
+----------+------------+--------+----------+--------+
Output:
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
Explanation:
According to orders 3 and 4 in the Orders table, it is easy to tell that only salesperson John and Pam have sales to company RED, so we report all the other names in the table salesperson.
```

</details>
