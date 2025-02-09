# WHERE Clause

SELECT*
FROM employee_salary
WHERE first_name = 'Leslie';



SELECT*
FROM employee_salary
WHERE salary <= 50000
;

SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT-- LOGICAL OPERATORS
SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male';

SELECT*
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

-- LIKE Statement--
-- % (= anything) and _ (= exact number of characters ) --
SELECT*
FROM employee_demographics
WHERE first_name LIKE 'a__'
;

SELECT*
FROM employee_demographics
WHERE birth_date LIKE '198%'


