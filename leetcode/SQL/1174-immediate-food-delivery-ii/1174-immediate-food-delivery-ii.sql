# Write your MySQL query statement below

select 
Round(avg(order_date = customer_pref_delivery_date) * 100.0,2) as immediate_percentage 
from Delivery 
where (customer_id, order_date) in (
    select customer_id,min(order_date) as order_date 
    from Delivery 
    Group by customer_id
)
