# Write your MySQL query statement below

Select class
from Courses
Group by class
having count(*) > 1
