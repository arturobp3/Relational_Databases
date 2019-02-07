/*
1. Listado con el nombre y apellido de los empleados que trabajan en el departamento Finance. Ordenados por apellido.
*/

SELECT PR3_EMPLOYEES.FIRST_NAME, PR3_EMPLOYEES.LAST_NAME
FROM PR3_EMPLOYEES JOIN PR3_DEPARTMENTS
     ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'Finance'
ORDER BY PR3_EMPLOYEES.LAST_NAME;

/*
2. Nombre y apellido de los empleados que tienen personal a su cargo, es decir, que son jefes de algún empleado. Sin repetición.
*/
SELECT DISTINCT E2.first_name, E2.last_name 
FROM pr3_employees E1 JOIN pr3_employees E2
     ON E1.manager_id = E2.employee_id;

/*
3. Listado de los apellidos de los empleados que ganan más que su jefe, incluyendo también el apellido de su jefe y los salarios de ambos.
*/

SELECT E1.last_name, E1.salary, E2.last_name, E2.salary
FROM pr3_employees E1 JOIN pr3_employees E2
     ON E1.manager_id = E2.employee_id
WHERE E1.salary > E2.salary;

/*
4. Listado con el nombre y apellido de los empleados que han trabajado en el departamento Sales.
*/
SELECT PR3_EMPLOYEES.FIRST_NAME, PR3_EMPLOYEES.LAST_NAME
FROM PR3_EMPLOYEES JOIN PR3_JOB_HISTORY
     ON PR3_EMPLOYEES.EMPLOYEE_ID = PR3_JOB_HISTORY.EMPLOYEE_ID JOIN PR3_DEPARTMENTS
     ON PR3_JOB_HISTORY.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'Sales';

/*
5. Nombres de los puestos que desempeñan los empleados en el departamento IT, sin tuplas repetidas.
*/

SELECT DISTINCT PR3_JOBS.JOB_TITLE
FROM PR3_EMPLOYEES JOIN PR3_DEPARTMENTS
     ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_JOB_HISTORY
     ON PR3_JOB_HISTORY.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_JOBS
     ON PR3_JOB_HISTORY.JOB_ID = PR3_JOBS.JOB_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'IT';

/*
6. Listado con los nombres de los empleados que trabajan en cualquier departamento cuyo nombre contenga una e que no trabajan en Europa,
junto con el nombre del departamento y del país en el que trabajan.
*/

SELECT PR3_EMPLOYEES.FIRST_NAME, PR3_DEPARTMENTS.DEPARTMENT_NAME, PR3_COUNTRIES.COUNTRY_NAME
FROM PR3_EMPLOYEES JOIN PR3_DEPARTMENTS
     ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_LOCATIONS
     ON PR3_DEPARTMENTS.LOCATION_ID = PR3_LOCATIONS.LOCATION_ID JOIN PR3_COUNTRIES
     ON PR3_LOCATIONS.COUNTRY_ID = PR3_COUNTRIES.COUNTRY_ID JOIN PR3_REGIONS
     ON PR3_COUNTRIES.REGION_ID = PR3_REGIONS.REGION_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME LIKE '%e%' AND PR3_REGIONS.REGION_NAME <> 'Europe';

/*
7. Listado de las localizaciones de los departamentos de la empresa
(identificador del país, ciudad, identificador de la localización
y nombre del departamento) en la que se encuentra algún departamento de UK,
incluyendo aquellas localizaciones de UK en las que no hay departamento. El listado debe estar ordenado por ciudad.
*/

SELECT PR3_COUNTRIES.COUNTRY_ID, PR3_LOCATIONS.LOCATION_ID, PR3_LOCATIONS.CITY, PR3_DEPARTMENTS.DEPARTMENT_NAME
FROM PR3_DEPARTMENTS RIGHT OUTER JOIN PR3_LOCATIONS
     ON PR3_DEPARTMENTS.LOCATION_ID = PR3_LOCATIONS.LOCATION_ID JOIN PR3_COUNTRIES
     ON PR3_LOCATIONS.COUNTRY_ID = PR3_COUNTRIES.COUNTRY_ID
WHERE PR3_COUNTRIES.COUNTRY_NAME ='United Kingdom'
ORDER BY PR3_LOCATIONS.CITY;

/*
8. Nombre de todos los países que no tengan ninguna localización, ordenados alfabéticamente en orden descendente.
*/
SELECT PR3_COUNTRIES.COUNTRY_NAME
FROM PR3_COUNTRIES LEFT OUTER JOIN PR3_LOCATIONS
     ON PR3_COUNTRIES.COUNTRY_ID = PR3_LOCATIONS.COUNTRY_ID 
WHERE PR3_LOCATIONS.LOCATION_ID IS NULL
ORDER BY PR3_COUNTRIES.COUNTRY_NAME DESC;

/*
9. Nombre, apellidos y departamento de los empleados sin departamento (el departamento aparecerá vacío)
y de los departamentos sin empleados (el nombre y apellidos aparecerán vacíos).
*/

SELECT PR3_EMPLOYEES.FIRST_NAME, PR3_EMPLOYEES.LAST_NAME, PR3_DEPARTMENTS.DEPARTMENT_NAME
FROM PR3_EMPLOYEES FULL OUTER JOIN PR3_DEPARTMENTS
     ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME IS NULL
  OR PR3_EMPLOYEES.FIRST_NAME IS NULL
  OR PR3_EMPLOYEES.LAST_NAME IS NULL;

