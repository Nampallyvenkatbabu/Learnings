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
