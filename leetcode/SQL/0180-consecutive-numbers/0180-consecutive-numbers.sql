# Write your MySQL query statement below

select l.num as ConsecutiveNums
from
Logs l
inner join Logs l1
on l.id = l1.id
Group by l.num
Having count(*) >= 3
