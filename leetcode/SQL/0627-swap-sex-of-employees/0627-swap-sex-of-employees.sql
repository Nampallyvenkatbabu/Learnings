# Write your MySQL query statement below

Update Salary
set sex = 
(CASE when sex = 'm' then 'f' else 'm' END)
