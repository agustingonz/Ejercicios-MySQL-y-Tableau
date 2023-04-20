select * from t_employees;

select * from t_dept_emp;

/*Resolucion */

select e.gender,
       count(e.emp_no),
       year(de.from_date) año

from t_employees e
	join 
    t_dept_emp de on e.emp_no=de.emp_no
where year(de.from_date)>='1990'
group by e.gender, año
order by año;

/* Resolucion alternativa*/

select
      e.gender,
      year(d.from_date) as añocalendario,
      count(e.emp_no) as numerodeempleados
from
	t_employees e
    join 
    t_dept_emp d on d.emp_no=e.emp_no
group by añocalendario, e.gender having añocalendario>='1990'
order by añocalendario asc;
      
