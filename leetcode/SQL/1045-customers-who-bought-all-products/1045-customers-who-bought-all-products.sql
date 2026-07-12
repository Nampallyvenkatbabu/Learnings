# Write your MySQL query statement below

select customer_id
from Customer
Group by customer_id
having count(DISTINCT product_key) = (
    select count(*)
    from Product
)

/* Alternative solution with corelated subquery

select DISTINCT c.customer_id
from Customer c
where not exists(
    select p.product_key 
    from Product p
    where not exists (
        select 1
        from Customer c2
        where c2.customer_id = c.customer_id 
        and  c2.product_key  = p.product_key 
    )
)

*/
