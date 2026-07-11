# Write your MySQL query statement below

SELECT user_id, name, mail
FROM Users
WHERE REGEXP_like(mail,'^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$','c');
