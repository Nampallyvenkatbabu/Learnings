CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    SELECT MAX(salary)
    FROM (
        SELECT salary,
               ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
        FROM Employee
    ) ranked
    WHERE rn = N
  );
END;
