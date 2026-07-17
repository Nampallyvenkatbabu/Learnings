# Write your MySQL query statement below

select x,y,z,
CASE
    when x+y > z
    and y+z > x
    and z+x > y then 'Yes' else 'No'
END as triangle
from Triangle
