[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/find-customer-referee/)

# 584. Find Customer Referee

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 15, 2026](https://img.shields.io/badge/Solved%20Jul%2015%2C%202026-555555?style=flat-square)

## How I approached it

I need to find customers who were referred by someone other than the customer with id 2, or who were not referred by anyone. I can use a `where` clause to filter these customers, and the `or` operator to combine the two conditions. My first idea was to use a subquery, but a simple `where` clause is enough.

**How I got there:** I looked at the conditions and saw that I need to check the `referee_id` column. If it's not 2, or if it's `null`, then the customer meets the conditions. I thought about using a subquery to find the customers who referred others, but it's not necessary.

1. Select the `name` column from the `Customer` table.
2. Use a `where` clause to filter the customers based on the conditions.
3. Check if the `referee_id` is not equal to 2, or if it's `null`, using the `or` operator.
4. Return the names of the customers who meet the conditions.

**Pattern to remember:** When filtering data based on multiple conditions, use the `or` operator to combine the conditions in a `where` clause.

**Watch out for:** Forgetting to check for `null` values in the `referee_id` column can cause customers who were not referred by anyone to be missed.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 504 ms (beats 48.6%)](https://img.shields.io/badge/Runtime-504%20ms%20(beats%2048.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

Select name
from Customer
where 
    referee_id <> 2 
    or referee_id is null;
```

Source: [0584-find-customer-referee.sql](./0584-find-customer-referee.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Customer`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
```

Find the names of the customer that are either:

1. **referred by** any customer with `id != 2`.
2. **not referred by** any customer.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output:
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
```

</details>
