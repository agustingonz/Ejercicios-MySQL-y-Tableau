/*ejercicio 1*/

SELECT 
    ROUND(AVG(s.salary), 2) AS Salario_Prom,
    e.gender AS Genero,
    de.dept_name AS Departamento
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
        JOIN
    dept_emp d ON e.emp_no = d.emp_no
        JOIN
    departments de ON d.dept_no = de.dept_no
GROUP BY Departamento , Genero
ORDER BY Departamento;

 /* Ejercicio 2*/
 
SELECT 
    dept_no, dept_name AS Departamento
FROM
    departments
WHERE
    dept_no IN (SELECT 
            MIN(dept_no)
        FROM
            dept_emp) 
UNION 
SELECT 
    dept_no, dept_name AS Departamento
FROM
    departments
WHERE
    dept_no IN (SELECT 
            MAX(dept_no)
        FROM
            dept_emp);
  /* solucion alternativa*/
  
  select min(dept_no) from dept_emp;
  select max(dept_no) from dept_emp;
  
  
  
  
  
/* Ejercicio 3*/

SELECT 
    emp_no,
    dept_no,
    CASE
        WHEN emp_no <= 10020 THEN 110022
        ELSE 110039
    END AS gerente
FROM
    dept_emp
WHERE
    dept_no IN (SELECT 
            MIN(dept_no)
        FROM
            dept_emp
        GROUP BY emp_no)
GROUP BY emp_no
HAVING emp_no <= 10040;

/* Ejercicio 4 */

SELECT 
    *
FROM
    employees
WHERE
    YEAR(hire_date) = '2000'
ORDER BY hire_date ASC;

/* Ejercicio 5 */ 

SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%engineer%');
    
SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%senior engineer%');  
    
 /* Ejercicio 6 */
 
 drop procedure if exists num_dept;
 

 delimiter $$
 create procedure num_dept (in p_emp_no int)
 begin
 select de.emp_no, de.dept_no as ult_dept, d.dept_name
 from dept_emp de
 join departments d on de.dept_no=d.dept_no
 where de.emp_no=p_emp_no and de.to_date = (select to_date from dept_emp where emp_no=p_emp_no order by to_date desc limit 1);
 end $$
 delimiter ;
call employees.num_dept(10010);

/* Ejercicio 7*/

SELECT 
    COUNT(*) cont_mas_1anio_y_cienmil_salary
FROM
    salaries
WHERE
    YEAR(to_date) > (YEAR(from_date) + 1)
        AND salary >= 100000;
        
/* solucion alternativa*/
        select count(*) from salaries where salary >= 100000 and datediff(to_date, from_date) >365;

/* Ejercicio 8 */

commit;

delimiter $$
create trigger trig_fecha_cont
before insert on employees
for each row
begin 
if new.hire_date > date_format(sysdate(),'%y-%m-%d') then
set new.hire_date = date_format(sysdate(), '%y-%m-%d');
end if;
end $$
delimiter ;

    
delimiter $$
create trigger trig_fecha_contrato
before insert on employees
for each row
begin 
declare v_curr_date date;
select date_format(sysdate(), '%y-%m-%d') into v_curr_date;
if new.hire_date > v_curr_date then
set new.hire_date = v_curr_date;
end if;
end $$
delimiter ;

insert into employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
values ('989898', '1959-01-01', 'agus', 'gonzalez', 'm', '2023-01-01');

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 989898;
    
rollback;
delete from employees where emp_no=989898;
drop trigger trig_fecha_cont;
drop trigger trig_fecha_contrato;

/*Ejercicio 9 */

drop function if exists f_max_sal;

delimiter $$
create function f_max_sal (p_emp_no int)
returns decimal (10,2)
deterministic no sql reads sql data
begin
declare v_max_sal decimal (10,2);
select max(salary) into v_max_sal
from salaries
where emp_no=p_emp_no;
return v_max_sal;
end $$
delimiter ;

select f_max_sal(11356);

drop function if exists f_min_sal;

delimiter $$
create function f_min_sal (p_emp_no int)
returns decimal (10,2)
deterministic no sql reads sql data
begin
declare v_min_sal decimal (10,2);
select min(salary) into v_min_sal
from salaries
where emp_no=p_emp_no;
return v_min_sal;
end $$
delimiter ;
select f_min_sal(10356);

/* Ejercicio 10 */

drop function if exists f_dif_sal;

delimiter $$
create function f_dif_sal (p_emp_no int, p_sal varchar (255))
returns decimal (10,2)
deterministic no sql reads sql data
begin
declare v_res_sal decimal (10,2);
select case when p_sal like 'max' then max(salary)
			when p_sal like 'min' then min(salary)
            else max(salary) - min(salary)
            end as verificacion into v_res_sal
from salaries
where emp_no=p_emp_no;
return v_res_sal;
end $$
delimiter ;

select f_dif_sal(11356, 'min');
select f_dif_sal(11356, 'max');
select f_dif_sal(11356, 'maxxx');


