[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customers-who-never-order/)

# 183. Customers Who Never Order

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## 🧠 How I Approached It
I needed to find customers who never ordered anything. My first thought was to use a `NOT IN` clause, since it directly checks for absence in the `Orders` table. However, I realized that a `JOIN` can also solve this problem and is often more reliable.

---

### 🔎 How I Got There
- The `Orders` table contains only customer IDs that have placed orders.  
- Using `NOT IN` allows me to filter customers whose IDs are missing from that list.  
- But `NOT IN` has two limitations:  
  1. It fails if the subquery returns `NULL`.  
  2. It can be slower for large datasets because the database must process the entire subquery result.  
- A `LEFT JOIN` with `IS NULL` avoids these issues and is optimized by the query planner.  

---

### 📝 Step‑by‑Step
1. Select the required column (`name`) from the `Customers` table.  
2. Use a `LEFT JOIN` to bring in matching rows from `Orders`.  
3. Filter with `WHERE o.customerId IS NULL` to keep only customers who never ordered.  

---

### 📌 Pattern to Remember
- **Use JOIN when combining data between tables** — it’s efficient and safe.  
- **Use NOT IN only for small static lists** — avoid it for subqueries with possible `NULL`s.  
- **Use NOT EXISTS for existence checks** — it short‑circuits and avoids `NULL` pitfalls.  

---

### ⚠️ Watch Out For
- `NOT IN` can fail if the subquery includes `NULL`.  
- Large datasets may perform better with `LEFT JOIN + IS NULL` or `NOT EXISTS`.  


## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1866 ms (beats 5.0%)](https://img.shields.io/badge/Runtime-1866%20ms%20(beats%205.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
# Write your MySQL query statement below

-- ✅ Preferred solution using LEFT JOIN + IS NULL
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;

/*
🔄 Alternative Solutions

1️⃣ Using NOT IN
--------------------------------------------------
Explanation:
- Filters customers whose id is not in the Orders table.
- ❌ Risky if Orders.customerId contains NULL values (query may return no rows).

Code:
SELECT name AS Customers
FROM Customers
WHERE id NOT IN (SELECT customerId FROM Orders);

--------------------------------------------------

2️⃣ Using NOT EXISTS
--------------------------------------------------
Explanation:
- Correlated subquery checks if a matching order exists.
- ✅ Efficient: short‑circuits after first match.
- ✅ Safe against NULL issues.
- Often considered the best alternative in interviews.

Code:
SELECT c.name AS Customers
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.customerId = c.id
);

--------------------------------------------------

3️⃣ Using EXCEPT / MINUS (Dialect Specific)
--------------------------------------------------
Explanation:
- Available in PostgreSQL (EXCEPT) or Oracle (MINUS).
- Conceptually clean: “Customers minus those who ordered.”
- ❌ Not supported in MySQL.

Code (PostgreSQL / SQL Server):
SELECT name AS Customers
FROM Customers
EXCEPT
SELECT c.name
FROM Customers c
JOIN Orders o ON c.id = o.customerId;

--------------------------------------------------

📊 Comparison Table (Quick Reference)

| Approach            | Efficiency | NULL Handling | Best Use Case |
|---------------------|------------|---------------|---------------|
| NOT IN              | ❌ Less efficient | ❌ Risky with NULLs | Simple syntax, small datasets |
| LEFT JOIN + IS NULL | ✅ Optimized | ✅ Safe        | Retrieving all customers without orders |
| NOT EXISTS          | ✅ Efficient | ✅ Safe        | Existence checks, interview‑favorite |
| EXCEPT / MINUS      | ✅ Clean semantics | ✅ Safe | Dialect‑specific set difference |

--------------------------------------------------

🎯 Key Takeaways:
- **LEFT JOIN + IS NULL** → Expected efficient solution.  
- **NOT IN** → Works but fragile with NULLs.  
- **NOT EXISTS** → Best for performance and correctness; 
- **EXCEPT/MINUS** → Clean but dialect‑specific.
*/
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
