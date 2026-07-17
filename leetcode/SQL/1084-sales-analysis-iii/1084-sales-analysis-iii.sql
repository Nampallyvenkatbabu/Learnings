# Write your MySQL query statement below

select p.product_id as product_id ,
p.product_name as product_name
from
Product p
inner join
Sales s
on p.product_id = s.product_id
Group by p.product_id,p.product_name
having min(s.sale_date) >= '2019-01-01' and
max(s.sale_date) <= '2019-03-31'
