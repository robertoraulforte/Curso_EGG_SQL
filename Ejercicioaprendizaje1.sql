-- Active: 1665101065679@@localhost@3306@personal
/*Ejercicio 1. Abrir el script llamado “personal” y ejecutarlo de modo tal que se cree la base de datos 
“personal”, se creen las tablas y se inserten todos los datos en las tablas para que quede de la 
siguiente manera:
a) A continuación, realizar las siguientes consultas sobre la base de datos personal:
1. Obtener los datos completos de los empleados.*/

use personal;

select * from empleado;

/*2. Obtener los datos completos de los departamentos.*/

select * from departamento;

/*3. Listar el nombre de los departamentos.*/

select nombre_depto from departamento;

/*4. Obtener el nombre y salario de todos los empleados.*/

select nombre,salario from empleado;

/*5. Listar todas las comisiones.*/

select comision from empleado;

/*6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.*/

select * from empleado where cargo like 'Secretaria';

/*7. Obtener los datos de los empleados vendedores, ordenados por nombre 
alfabéticamente.*/

SELECT * from empleado where cargo like 'Vendedor' order by nombre asc;

/*8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a 
mayor.*/

select nombre,cargo, salario from empleado order by salario asc;

/*9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las 
respectivas tablas de empleados.*/

select nombre, cargo from empleado;

select nombre as 'Nombre', cargo as 'Cargo' from empleado;

/*10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado 
por comisión de menor a mayor*/

SELECT salario, comision FROM empleado WHERE id_depto = 2000 ORDER BY comision ASC;

/*11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los 
empleados del departamento 3000 una bonificación de 500, en orden alfabético del 
empleado.*/

SELECT nombre, (salario+comision+500) as 'Total a pagar' FROM empleado WHERE id_depto = 3000 ORDER BY nombre;

SELECT salario, comision, (salario + 500) AS 'Salario + Comisión' FROM empleado 
WHERE id_depto = '3000' ORDER BY nombre ASC;


/*12. Muestra los empleados cuyo nombre empiece con la letra J.*/

SELECT * FROM empleado WHERE nombre LIKE 'j%';  


/*13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos 
empleados que tienen comisión superior a 1000.*/

select nombre, salario, comision, (salario+comision) as 'salario total' from empleado where comision >1000;

/*14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen 
comisión.*/

select nombre, salario, comision, (salario+comision) as 'salario total' from empleado where comision =0;

/*15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.*/

select * from empleado where comision > salario;

/*16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.*/

select * from empleado where comision <= salario * .3;

/*17. Hallar los empleados cuyo nombre no contiene la cadena “MA”*/

select * from empleado where nombre not like '%MA%';

/*18. Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación” ni 
‘Mantenimiento*/

select * from departamento where nombre_depto like 'Ventas';

/*19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni 
“Investigación” ni ‘Mantenimiento.*/

SELECT * FROM departamento WHERE nombre_depto NOT IN ('Ventas','Mantenimiento', 'Investigación');

/*20. Mostrar el salario más alto de la empresa.*/

SELECT MAX(salario) FROM empleado;

/*21. Mostrar el nombre del último empleado de la lista por orden alfabético.*/

select nombre from empleado order by nombre asc;   /*para ver todos y chequear*/

SELECT nombre FROM empleado ORDER BY nombre DESC LIMIT 1;

select max(nombre) from empleado;

/*22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.*/

SELECT max(salario), min(salario), max(salario)-min(salario) as 'Diferencia' from empleado;

/*23. Hallar el salario promedio por departamento.*/

SELECT id_depto, ROUND(AVG(salario), 0) as 'Salario promedio' FROM empleado GROUP BY id_depto;

/* round redondea para arriba y el 0 es sin decimales

/*Consultas con Having 

24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de 
empleados de esos departamentos.*/

/*SELECT nombre/s de la/s columna/s FROM tablaOrigen GROUP BY nombres de 
columnas por la cual Agrupar HAVING condiciónBúsqueda para Group By;*/

SELECT id_depto, COUNT(*) as 'Cantidad' FROM empleado GROUP BY id_depto HAVING Cantidad > 3;

/*25. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. 
Solo los que tengan más de dos empleados (2 incluido).*/

SELECT *, COUNT(*) as 'Cantidad'FROM empleado GROUP BY id_depto HAVING Cantidad > 2 AND cargo LIKE 'Jefe%';

/*26. Hallar los departamentos que no tienen empleados*/

SELECT *, COUNT(*) FROM empleado GROUP BY id_depto HAVING COUNT(*) = 0;

SELECT *, COUNT(*)
FROM empleado
GROUP BY id_depto
HAVING COUNT(*) = 0;

SELECT *
FROM departamento as d
LEFT JOIN empleado as e
ON d.id_depto = e.id_depto
GROUP BY d.id_depto
HAVING count(nombre) = 0;


/*Consulta con Subconsulta

27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la 
empresa. Ordenarlo por departamento.*/

SELECT *
FROM empleado
WHERE salario >= (SELECT AVG(salario) FROM empleado)
ORDER BY id_depto;

SELECT *
FROM empleado as e
INNER JOIN departamento as d
ON e.id_depto = d.id_depto
WHERE e.salario >= (SELECT AVG(salario) FROM empleado)
ORDER BY d.nombre_depto;