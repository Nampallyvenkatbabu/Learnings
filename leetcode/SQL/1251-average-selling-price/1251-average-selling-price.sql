# Write your MySQL query statement below

select p.product_id,
IFNULL(Round((sum(price * units)/sum(units)),2),0) as average_price 
FROM Prices p
Left join
UnitsSold u
on p.product_id = u.product_id and 
u.purchase_date BETWEEN p.Start_date and p.end_date
Group by p.product_id
