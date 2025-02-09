-- WINDOW FUNCTIONS

SELECT gender, AVG (salary) as avg_salary
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender; 

SELECT dem.first_name, dem.last_name, gender, AVG (salary) OVER(PARTITION BY gender)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
; 

SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) as ROLLING_TOTAL
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;


SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) as row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as dense_rank_sum
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;
#notice how row and rank nums differ regarding the next number (numerically vs positionally)
#row num does not repeat nums, while rank does and goes to the next number POSITIONALLY
#And dense rank gives the next number numerically when it comes down to duplicates (which repeats just like rank num)





