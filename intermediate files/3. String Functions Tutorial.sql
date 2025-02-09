-- string functions--

SELECT LENGTH('skyyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT UPPER('sky');
SELECT LOWER ('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;


SELECT RTRIM('      sky       ');


select first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) AS bith_month
from employee_demographics;

SELECT first_name, REPLACE(first_name, 's','z')
FROM employee_demographics;

SELECT LOCATE('x','Alexander');


SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics
ORDER BY 1;

SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) AS full_name
FROM employee_demographics;









