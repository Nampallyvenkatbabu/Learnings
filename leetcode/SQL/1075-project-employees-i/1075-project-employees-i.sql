# Write your MySQL query statement below

select p.project_id,
Round(avg(e.experience_years),2) as average_years
from
Project p
Inner join
Employee e
on p.employee_id = e.employee_id
Group by p.project_id
