# Write your MySQL query statement below

SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[a-z]+[a-z0-9._-]*@leetcode\\.com$', 'c');
