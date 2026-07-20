# Write your MySQL query statement below

select project_id,
avg(experience_years) as average_years
from Employee e
inner join Project p
on e.employee_id = p.employee_id
Group by project_id
