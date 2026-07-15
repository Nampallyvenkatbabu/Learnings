# Write your MySQL query statement below

select customer_number
from Orders
Group by customer_number
having count(*) > 1
