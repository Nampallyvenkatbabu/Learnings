# Write your MySQL query statement below

SELECT user_id,name,mail
FROM Users
WHERE REGEXP_LIKE(mail, '^[a-z]+[a-z0-9._-]*@leetcode\\.com$', 'c');
