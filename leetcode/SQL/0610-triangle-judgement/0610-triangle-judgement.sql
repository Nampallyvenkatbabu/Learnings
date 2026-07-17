# Write your MySQL query statement below

select x,y,z,
CASE
    when x+y <=z then 'No' else 'Yes'
END as triangle
from Triangle
