/*
1. Elabora un listado (sin repeticiones) con los apellidos de los clientes de la empresa que hayan
hecho algún pedido online (order_mode online) junto con el apellido del empleado que
gestiona su cuenta. Muestra en el listado primero el apellido del empleado que gestiono la
cuenta y luego el apellido del cliente, y haz que el listado se encuentre ordenado por apellido
de empleado primero y luego por apellido del cliente. Usa reuniones para ello.
*/
SELECT DISTINCT E1.LAST_NAME, C1.CUST_LAST_NAME
FROM PR5_CUSTOMERS C1 JOIN PR5_ORDERS O1
  ON C1.CUSTOMER_ID = O1.CUSTOMER_ID JOIN PR3_EMPLOYEES E1
  ON O1.SALES_REP_ID = E1.EMPLOYEE_ID
WHERE O1.ORDER_MODE = 'online'
ORDER BY E1.LAST_NAME, C1.CUST_LAST_NAME;
/*
2. Listado de categorías con más de 2 productos obsoletos (PRODUCT_STATUS obsolete).
Lista la categoría y el número de productos obsoletos.
*/
SELECT DISTINCT P1.CATEGORY_ID
FROM PR5_PRODUCT_INFORMATION P1 JOIN PR5_ORDER_ITEMS O1
    USING(PRODUCT_ID)
WHERE O1.QUANTITY > 2 AND 
      P1.PRODUCT_STATUS = 'obsolete';
      
/*
3.Se quiere generar un “ranking” de los productos más vendidos en el último semestre del año
1990. Para ello nos piden mostrar el nombre de producto y el número de unidades vendidas
para cada producto vendido en el último semestre del año 1990 (ordenado por número de
unidades vendidas de forma descendente). 
*/

SELECT DISTINCT P1.PRODUCT_NAME, O2.QUANTITY
FROM PR5_ORDERS O1 JOIN PR5_ORDER_ITEMS O2
    USING (ORDER_ID) JOIN PR5_PRODUCT_INFORMATION P1
    USING(PRODUCT_ID) JOIN PR5_INVENTORIES I1
    USING(PRODUCT_ID) 
WHERE O1.ORDER_DATE BETWEEN '01/06/90 00:00:00,000000000' AND '31/12/90 23:59:59,999999999'
ORDER BY (O2.QUANTITY) DESC;

/*
4. Muestra los puestos en la empresa que tienen un salario mínimo superior al salario medio de
los empleados de la compañía. El listado debe incluir el puesto y su salario mínimo, y estar
ordenado ascendentemente por salario mínimo.
*/

SELECT DISTINCT J1.JOB_TITLE, J1.MIN_SALARY
FROM PR3_JOBS J1 JOIN PR3_EMPLOYEES E1
    USING(JOB_ID)

WHERE J1.MIN_SALARY > (SELECT AVG(SALARY)
                       FROM PR3_EMPLOYEES)
ORDER BY J1.MIN_SALARY ASC;

/*
5 Mostrar el código, nombre y precio mínimo de productos de la categoría 14 que no aparecen
en ningún pedido. Usa para ello una subconsulta no correlacionada.
*/

--Productos con categoria 14
SELECT DISTINCT P1.PRODUCT_ID, P1.PRODUCT_NAME, P1.MIN_PRICE
FROM PR5_PRODUCT_INFORMATION P1
WHERE P1.CATEGORY_ID = 14
MINUS
--Productos con categoria 14 que aparecen en algun pedido
SELECT DISTINCT P2.PRODUCT_ID, P2.PRODUCT_NAME, P2.MIN_PRICE
FROM PR5_PRODUCT_INFORMATION P2 JOIN PR5_ORDER_ITEMS O1
    ON P2.PRODUCT_ID = O1.PRODUCT_ID
WHERE P2.CATEGORY_ID = 14;

/*
6. Mostrar el código de cliente, nombre y apellidos de aquellos clientes alemanes
(NLS_TERRITORY GERMANY) que no han realizado ningún pedido. Usa para ello una consulta
correlacionada
*/
SELECT C1.CUSTOMER_ID, C1.CUST_FIRST_NAME, C1.CUST_LAST_NAME
FROM PR5_CUSTOMERS C1
WHERE C1.NLS_TERRITORY = 'GERMANY' 
AND C1.CUSTOMER_ID NOT IN (SELECT O1.CUSTOMER_ID
                           FROM PR5_ORDERS O1 JOIN PR5_CUSTOMERS C2
                             ON O1.CUSTOMER_ID = C2.CUSTOMER_ID
                          WHERE C2.NLS_TERRITORY = C1.NLS_TERRITORY);

/*
7. Mostrar el código de cliente, nombre y apellidos (sin repetición) de aquellos clientes que han
realizado al menos un pedido de tipo (order_mode) online y otro direct.
*/
SELECT DISTINCT A1.CUST_FIRST_NAME, A1.CUST_LAST_NAME
FROM PR5_CUSTOMERS A1 JOIN PR5_ORDERS O1
    USING(CUSTOMER_ID) JOIN PR5_ORDERS O2
    USING(CUSTOMER_ID)
WHERE O1.ORDER_MODE = 'online' AND O2.ORDER_MODE = 'direct';

/*
8. Mostrar el nombre y apellidos de aquellos clientes que, habiendo realizado algún pedido,
nunca han realizado pedidos de tipo direct.
*/

SELECT DISTINCT A1.CUST_FIRST_NAME, A1.CUST_LAST_NAME
FROM PR5_CUSTOMERS A1 JOIN PR5_ORDERS O2
  ON A1.CUSTOMER_ID = O2.CUSTOMER_ID
WHERE O2.ORDER_MODE <> 'direct'
  AND O2.ORDER_MODE <> ALL (SELECT O3.ORDER_MODE
                            FROM PR5_ORDERS O3
                            WHERE O3.CUSTOMER_ID = A1.CUSTOMER_ID);

/*9.Se quiere generar un listado de los productos que generan mayor beneficio. Mostrar el código
de producto, su precio mínimo, su precio de venta al público y el porcentaje de incremento
de precio. En el listado deben aparecer solo aquellos cuyo precio de venta al público ha
superado en un 30 % al precio mínimo.*/

SELECT DISTINCT P1.PRODUCT_ID, P1.MIN_PRICE, P1.LIST_PRICE, ((P1.LIST_PRICE - O1.UNIT_PRICE) * 100) AS PERCENTAGE 
FROM PR5_ORDER_ITEMS O1 JOIN PR5_PRODUCT_INFORMATION P1
  ON O1.PRODUCT_ID  = P1.PRODUCT_ID
WHERE P1.LIST_PRICE > P1.MIN_PRICE * 1.30
ORDER BY ((P1.LIST_PRICE - O1.UNIT_PRICE) * 100) DESC;


/*10. Mostrar el apellido de los empleados que ganen un 35% más del salario medio de su puesto.
El listado debe incluir el salario del empleado y su puesto.*/

SELECT DISTINCT E1.LAST_NAME, E1.SALARY, J1.JOB_TITLE
FROM PR3_EMPLOYEES E1 JOIN PR3_JOBS J1
  ON E1.JOB_ID = J1.JOB_ID
WHERE E1.SALARY = ((J1.MAX_SALARY + J1.MIN_SALARY)/2) * 1.35;
