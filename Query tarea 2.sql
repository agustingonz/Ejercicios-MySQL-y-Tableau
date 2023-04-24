/* crear una visualizacion que compare la cantidad de gerentes masculinos con la cantidad de gerentes femeninos de diferentes departamentos
para cada año a partir de 1990*/

select d.dept_name,
	   ee.gender, 
       dm.emp_no, 
       dm.from_date, 
       dm.to_date,
       e.calendar_year,
       
	case 	
		when year(dm.to_date)>=e.calendar_year
		and year(dm.from_date)<=e.calendar_year 
        then 1 
		else 0
	end as active

from

	( select year(hire_date) as calendar_year from t_employees 
	group by calendar_year ) e
		cross join t_dept_manager dm 
		join t_departments d on dm.dept_no=d.dept_no
		join t_employees ee on dm.emp_no=ee.emp_no
	order by dm.emp_no, calendar_year;

