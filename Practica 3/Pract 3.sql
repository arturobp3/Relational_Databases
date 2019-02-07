/*
1. Listado de departamentos (con toda la información disponible) de los departamentos cuya localización sea 1500
*/
SELECT *
FROM pr3_departments
WHERE  LOCATION_ID = 1500;

/*
2. Listado con los nombres de los empleados que trabajan en el departamento cuyo identificador es 100.
*/
SELECT FIRST_NAME
FROM PR3_EMPLOYEES
WHERE DEPARTMENT_ID = 100;
/*
3. Listado con los nombres de los empleados que no tienen jefe.
*/
SELECT FIRST_NAME
FROM PR3_EMPLOYEES
WHERE MANAGER_ID IS NULL;
/*
4. Listado con los identificadores de departamento de aquellos empleados que reciben algún tipo de comisión. Sin repetición.
*/
SELECT DISTINCT  DEPARTMENT_ID
FROM PR3_EMPLOYEES
WHERE COMMISSION_PCT > 0;

/*
5. Listado con los nombres de los empleados (ordenados por apellido) que trabajan en el departamento Finance
*/

SELECT PR3_EMPLOYEES.FIRST_NAME
FROM PR3_EMPLOYEES JOIN PR3_DEPARTMENTS
ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'Finance'
ORDER BY PR3_EMPLOYEES.LAST_NAME;
/*
6. Nombres de los empleados que tienen personal a su cargo, es decir, que son jefes de algún empleado. Sin repetición
*/
SELECT DISTINCT E1.FIRST_NAME
FROM PR3_EMPLOYEES E1, PR3_EMPLOYEES E2
WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID;

/*
7. Listado de los apellidos de los empleados que ganan más que su jefe, incluyendo también el
apellido de su jefe y los salarios de ambos.
*/
SELECT E1.LAST_NAME AS EMPLOYEE_LAST_NAME, E1.SALARY AS SALARY_EMPLOYEE, E2.LAST_NAME AS BOSS_LAST_NAME, E2.SALARY AS BOSS_SALARY
FROM PR3_EMPLOYEES E1, PR3_EMPLOYEES E2
WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID AND E1.SALARY > E2.SALARY;

/*
8. Listado con los nombres de los empleados que han trabajado en el departamento Sales. 
*/
SELECT PR3_EMPLOYEES.FIRST_NAME
FROM PR3_EMPLOYEES JOIN PR3_JOB_HISTORY
ON PR3_EMPLOYEES.EMPLOYEE_ID = PR3_JOB_HISTORY.EMPLOYEE_ID JOIN PR3_DEPARTMENTS
ON PR3_JOB_HISTORY.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'Sales';

/*
9. Nombres de los puestos que desempeñan los empleados en el departamento IT, sin tuplas
repetidas.
*/
SELECT DISTINCT PR3_JOBS.JOB_TITLE
FROM PR3_EMPLOYEES JOIN PR3_DEPARTMENTS
ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_JOB_HISTORY
ON PR3_JOB_HISTORY.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_JOBS
ON PR3_JOB_HISTORY.JOB_ID = PR3_JOBS.JOB_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'IT';

/*
10. . Listado con los nombres de los empleados que trabajan en el departamento IT que no trabajan
en Europa, junto con el nombre del país en el que trabajan.
*/
SELECT PR3_EMPLOYEES.FIRST_NAME, PR3_COUNTRIES.COUNTRY_NAME
FROM PR3_EMPLOYEES JOIN PR3_DEPARTMENTS
ON PR3_EMPLOYEES.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_LOCATIONS
ON PR3_DEPARTMENTS.LOCATION_ID = PR3_LOCATIONS.LOCATION_ID JOIN PR3_COUNTRIES
ON PR3_LOCATIONS.COUNTRY_ID = PR3_COUNTRIES.COUNTRY_ID JOIN PR3_REGIONS
ON PR3_COUNTRIES.REGION_ID = PR3_REGIONS.REGION_ID
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'IT' AND PR3_REGIONS.REGION_NAME != 'Europe';

/*
11. Listado de los apellidos de los empleados del departamento SALES que no trabajan en el
mismo departamento que su jefe, junto con el apellido de su jefe y el departamento en el que
trabaja el jefe.
*/

SELECT E1.LAST_NAME AS EMPLOYEE_LAST_NAME, E2.LAST_NAME AS BOSS_LAST_NAME, E2.DEPARTMENT_ID AS BOSS_DEPARTMENT
FROM PR3_EMPLOYEES E1 JOIN PR3_DEPARTMENTS
                      ON E1.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID,
     PR3_EMPLOYEES E2 
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'SALES' AND E1.DEPARTMENT_ID != E2.DEPARTMENT_ID;

/*
12. Listado con los nombres de los empleados que han trabajado en el departamento IT, pero que
actualmente trabajan en otro departamento distinto.
*/

SELECT PR3_EMPLOYEES.FIRST_NAME
FROM PR3_EMPLOYEES JOIN PR3_JOB_HISTORY
                   ON PR3_EMPLOYEES.EMPLOYEE_ID = PR3_JOB_HISTORY.EMPLOYEE_ID JOIN PR3_DEPARTMENTS
                   ON PR3_JOB_HISTORY.DEPARTMENT_ID = PR3_DEPARTMENTS.DEPARTMENT_ID JOIN PR3_EMPLOYEES E2
                   ON PR3_EMPLOYEES.EMPLOYEE_ID = E2.EMPLOYEE_ID
                       
WHERE PR3_DEPARTMENTS.DEPARTMENT_NAME = 'IT' AND
      E2.DEPARTMENT_ID != PR3_EMPLOYEES.DEPARTMENT_ID;
