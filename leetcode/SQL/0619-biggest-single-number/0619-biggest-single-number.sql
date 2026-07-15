# Write your MySQL query statement below

select max(num) as num
from(select num, count(*)
from MyNumbers
Group by num
having count(*) = 1) t
