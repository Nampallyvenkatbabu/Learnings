# Write your MySQL query statement below

select e.name,b.bonus 
from Employee e
LEFT JOIN
Bonus b
on e.empId = b.empId 
where b.bonus < 1000 or b.bonus is null

/*
Alternate solution with corelated subquery 

select e.name,
(
    select b.bonus 
    from Bonus b
    where b.empId = e.empId 
) as bonus
from Employee e
where 
(
    select b.bonus 
    from Bonus b
    where b.empId = e.empId 
) < 1000
or 
(
    select b.bonus 
    from Bonus b
    where b.empId = e.empId 
) is NULL;

*/
