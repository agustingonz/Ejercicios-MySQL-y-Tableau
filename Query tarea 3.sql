/* crear una visualizac que compare el salario promedio de los empleados masc y fem en toda la empresa hasta el año 2002.
agregue un filtro que permita ver eso por cada departamento*/


SELECT 
    ROUND(AVG(s.salary), 2) prom_sueldos,
    e.gender,
    YEAR(s.from_date) AS anio,
    d.dept_name AS departamento
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON e.emp_no = de.emp_no
        JOIN
    t_departments d ON de.dept_no = d.dept_no
WHERE
    YEAR(s.from_date) <= 2002
GROUP BY e.gender , anio , departamento
ORDER BY anio DESC , departamento;

