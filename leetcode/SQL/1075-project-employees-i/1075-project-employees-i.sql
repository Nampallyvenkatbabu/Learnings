# Write your MySQL query statement below

select project_id,
Round(avg(experience_years),2) as average_years
from Employee e
inner join Project p
on e.employee_id = p.employee_id
Group by project_id
