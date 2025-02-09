-- CTEs = Common Table Expression help you define a sub query block that you can reference within the main query

#Best way
WITH CTE_Example (Gender, AVG_Sal, Max_Sal, Min_Sal, Count_Sal) as 
(
SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example
;

#2nd way: subquery
SELECT AVG(average_salary)
FROM(
SELECT gender, AVG(salary) as average_salary, MAX(salary) as max_salary , MIN(salary) as min_salary, COUNT(salary) as count_sal
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) as example_subquery
;


SELECT AVG(average_salary)
FROM CTE_Example; #will result in an error because CTE is not a permanent item
#it is neither saved nor stored, it is used upon creation to simply query off of it

#CTE within another CTE

WITH CTE_Example as 
(
SELECT gender, employee_id, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example_2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example_2
	ON CTE_Example.employee_id = CTE_Example_2.employee_id 
;
