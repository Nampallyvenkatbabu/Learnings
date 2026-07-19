# Write your MySQL query statement below

select unique_id, 
e.name
from Employees e
left join EmployeeUNI EUI
on e.id = EUI.id
