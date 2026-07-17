# Write your MySQL query statement below

select s.name
from SalesPerson s
left join
Orders o
on s.sales_id = o.sales_id and com_id <> 3
left join 
Company c
on o.com_id = c.com_id
where c.name <> 'RED' or c.name is null
