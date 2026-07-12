# Write your MySQL query statement below

Select e.name as Employee 
from 
Employee e
JOIN 
Employee m
on e.managerId = m.id
where e.salary > m.salary

/*
Alternative solution with corelated subquery

select e.name as Employee 
from Employee e
where e.salary > (
    select m.salary
    from Employee m
    where m.id = e.managerId 
)

*/
