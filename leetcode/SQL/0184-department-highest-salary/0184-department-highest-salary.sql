# Write your MySQL query statement below

SELECT d.name as "Department", e.name as "Employee", e.salary
FROM employee e JOIN department d ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (
SELECT departmentId, MAX(salary)
FROM employee
GROUP BY departmentId
)

/*
Inner query table: 

departmentId  | salary 
1               90000  
2               80000  

after Join table 

 id | name  | salary | departmentId |   name 
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            | IT 
| 2  | Jim   | 90000  | 1            | IT  
| 3  | Henry | 80000  | 2            | SALES 
| 4  | Sam   | 60000  | 2            | SALES
| 5  | Max   | 90000  | 1            | IT 
+----+-------+--------+----------

after applying filter condition: 

 id | name  | salary | departmentId |   name   | include/exclude
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            | IT      |  Exclude(because filter cond'n not satisfied)
| 2  | Jim   | 90000  | 1            | IT      | Inlude (filter cond'n satisfied)
| 3  | Henry | 80000  | 2            | SALES   | Inlude (filter cond'n satisfied)
| 4  | Sam   | 60000  | 2            | SALES   | Exclude(because filter cond'n not satisfied)
| 5  | Max   | 90000  | 1            | IT      | Inlude (filter cond'n satisfied)
+----+-------+--------+----------

final output :

------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000 

*/
