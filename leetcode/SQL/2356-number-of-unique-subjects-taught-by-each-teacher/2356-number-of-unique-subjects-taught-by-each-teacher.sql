# Write your MySQL query statement below

select teacher_id,count(*) as cnt
from
(select teacher_id, count(*) as cnt
from Teacher
Group by teacher_id, subject_id) t
Group by teacher_id
