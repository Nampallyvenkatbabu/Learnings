# Write your MySQL query statement below

Select m.name
from employee as e
inner join employee as m
on e.managerId=m.id
Group by m.name
having count(*) >= 5
