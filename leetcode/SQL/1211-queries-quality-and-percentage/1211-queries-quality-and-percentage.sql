# Write your MySQL query statement below

select query_name,
round(avg(rating/position),2) as quality,
(Round(sum(case when rating < 3 then 1 else 0 end) * 100.0 /count(*),2)) as poor_query_percentage
from Queries
Group by query_name
