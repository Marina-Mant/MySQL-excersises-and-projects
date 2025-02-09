 -- Stored Procedures
 
 select *
 from employee_salary
 where salary >= 50000;
 
USE parks_and_recreation
CREATE PROCEDURE large_salaries()
select *
from employee_salary
where salary >= 50000;

CALL large_salaries();

DELIMITER $$ 
CREATE PROCEDURE large_salaries3()
BEGIN
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries3();


DELIMITER $$ 
CREATE PROCEDURE large_salaries4(employee_id_param INT)
BEGIN
	select salary
	from employee_salary
    where employee_id = employee_id_param
    ;
END $$
DELIMITER ;

CALL large_salaries4(1);