# Write your MySQL query statement below

select stock_name, sum(updated_price) as capital_gain_loss
from
(select *,
case when operation = 'Sell' then price 
else -price end as updated_price
from Stocks)t
Group by stock_name
