-- Temporary Tables (used as CTEs or to manipulate data before inserting it into a more permanent table)

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('Alex','Freberg','Lord of the Rings: The Two Towers');

Select *
from  temp_table;

select *
from employee_salary;

CREATE TEMPORARY TABLE salary_over_50k 
select *
from employee_salary
where salary >= 50000;

select *
from salary_over_50k;
