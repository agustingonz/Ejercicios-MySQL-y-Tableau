/*crear un procedimiento almacenado que permita obtener el salario prom de hombres y mujeres por departamento dentro de un rango 
salarial determinado. este rango sera definido mediante dos valores que el usuario puede insertar al llamar al procedimiento.
 finalmente visualizar el conj. de resultados en tableau con un grafico de barras doble*/
  
 
 drop procedure if exists p_sal_prom;
 delimiter $$
 create procedure p_sal_prom (in p_salary_from decimal(10,2), in p_salary_to decimal(10,2))
 begin
 select e.gender, round(avg( s.salary),2) as prom_sdo, d.dept_name as departamento
 from t_salaries s
 join t_employees e on s.emp_no=e.emp_no
 join t_dept_emp de on e.emp_no=de.emp_no
 join t_departments d on de.dept_no=d.dept_no
 where s.salary between p_salary_from and p_salary_to
 group by e.gender, departamento
 order by departamento;
 end $$
 delimiter ;
 
 
 
 
 