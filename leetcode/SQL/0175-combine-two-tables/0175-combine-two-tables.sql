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
