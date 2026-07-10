[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/combine-two-tables/)

# 175. Combine Two Tables

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I need to get the first name, last name, city, and state of each person in the `Person` table, and if the address of a `personId` is not present in the `Address` table, I report `null` instead. I want to combine these two tables based on the `personId`. My first idea was to use a subquery, but a `JOIN` is more efficient.

**How I got there:** I noticed that the `personId` is the key to connecting the `Person` and `Address` tables, so I thought about how to use this to get the information I need. The `Person` table has all the people, and the `Address` table has addresses for some of them, so I need to include all people, even if they do not have an address.

1. Start with the `Person` table, since it has all the people.
2. Use a `LEFT JOIN` to add the `Address` table, so I get all people, even if they do not have an address.
3. Join the tables on `personId`, which is the key that connects them.
4. Select the columns I need: `firstName`, `lastName`, `city`, and `state`.

**Pattern to remember:** When I need to combine two tables based on a common column, and I want to include all rows from one table, even if there is no match in the other table, I use a `LEFT JOIN`.

**Watch out for:** If I use an `INNER JOIN` instead of a `LEFT JOIN`, I will miss people who do not have an address.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 435 ms (beats 44.9%)](https://img.shields.io/badge/Runtime-435%20ms%20(beats%2044.9%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

SELECT 
    p.FirstName AS firstName, 
    p.LastName AS lastName, 
    a.City AS city,
    a.State AS state
FROM Person p
LEFT JOIN Address a
ON p.PersonId = a.PersonId;

/*
Alternative solution using IN (less efficient than JOIN, but included here for conceptual understanding):

SELECT 
    p.FirstName AS firstName, 
    p.LastName AS lastName,
    (SELECT City FROM Address WHERE PersonId = p.PersonId LIMIT 1) AS city,
    (SELECT State FROM Address WHERE PersonId = p.PersonId LIMIT 1) AS state
FROM Person p;
*/
```

Source: [0175-combine-two-tables.sql](./0175-combine-two-tables.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Person`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key (column with unique values) for this table.
This table contains information about the ID of some persons and their first and last names.
```

Table: `Address`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key (column with unique values) for this table.
Each row of this table contains information about the city and state of one person with ID = PersonId.
```

Write a solution to report the first name, last name, city, and state of each person in the `Person` table. If the address of a `personId` is not present in the `Address` table, report `null` instead.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Person table:
+----------+----------+-----------+
| personId | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |
+----------+----------+-----------+
Address table:
+-----------+----------+---------------+------------+
| addressId | personId | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |
+-----------+----------+---------------+------------+
Output:
+-----------+----------+---------------+----------+
| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |
+-----------+----------+---------------+----------+
Explanation:
There is no address in the address table for the personId = 1 so we return null in their city and state.
addressId = 1 contains information about the address of personId = 2.
```

</details>
