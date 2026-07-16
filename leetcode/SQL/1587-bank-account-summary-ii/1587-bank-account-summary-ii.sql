# Write your MySQL query statement below

select u.name,sum(t.amount) as balance
from
Users u
Inner join
Transactions t
on u.account = t.account
Group by u.name
having sum(t.amount) > 10000
