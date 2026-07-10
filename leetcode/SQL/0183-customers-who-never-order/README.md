[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customers-who-never-order/)

# 183. Customers Who Never Order

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I need to find customers who never ordered anything, so I look for customers whose id is not in the Orders table. My first idea was to join the tables, but a `NOT IN` clause is a better fit here because it directly checks for absence in one table.

**How I got there:** I noticed that the Orders table only contains customer ids that have made an order, so I can use that to find the customers who are missing from the Orders table. I thought about using a join, but that would require checking for null values, which is more complicated than a simple `NOT IN` check.

1. Select all columns from the Customers table that I need, which is just the `name` column.
2. Use a `WHERE` clause to filter the results to only include customers whose id is not in the Orders table, which I do with a `NOT IN` clause.
3. Inside the `NOT IN` clause, select the `customerID` column from the Orders table, which contains all the customer ids that have made an order.

**Pattern to remember:** When looking for items that are missing from one table, use a `NOT IN` clause to check for absence in the other table.

**Watch out for:** If the Orders table is very large, using `NOT IN` can be slow, and using a `LEFT JOIN` with a `WHERE` clause to check for null values might be faster.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 553 ms (beats 81.0%)](https://img.shields.io/badge/Runtime-553%20ms%20(beats%2081.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

select name as Customers from Customers 
where id not in (select customerID from Orders);
```

Source: [0183-customers-who-never-order.sql](./0183-customers-who-never-order.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Customers`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.
```

Table: `Orders`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
```

Write a solution to find all customers who never order anything.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output:
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
```

</details>
