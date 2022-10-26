/*Ejercicio extra 1. Abrir el script de la base de datos llamada “nba.sql” y ejecutarlo para crear todas las tablas e 
insertar datos en las mismas.*/

use nba;


/*A continuación, se deben realizar las siguientes consultas sobre la base de datos:
1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.*/

select nombre from jugador order by nombre asc;

/*2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, 
ordenados por nombre alfabéticamente.*/

select nombre,posicion from jugador;

select nombre,posicion from jugador where posicion like '%C%' and peso > 200 order by nombre asc;

/*3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/

select nombre from equipo order by nombre;

/*4. Mostrar el nombre de los equipos del este (East).*//* AGREGUE CONFERENCIA PARA QUE SE VEA MEJOR*/

SELECT nombre, conferencia FROM equipo WHERE conferencia = 'East';

/*5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/

select nombre, ciudad from equipo where ciudad like 'C%' order by nombre;

/*6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.*/

select nombre, nombre_equipo from jugador order by nombre_equipo;

/*7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.*/

select nombre,nombre_equipo from jugador where nombre_equipo like 'Raptors' order by nombre;

/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.    VERRRRRRRRR*/

SELECT e.Puntos_por_partido, j.nombre as 'NOMBRE'
FROM estadistica as e
INNER JOIN jugador as j
ON e.jugador = j.codigo
WHERE NOMBRE = 'Pau Gasol';


/*9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.    VERRRRRRR*/

SELECT e.Puntos_por_partido, j.nombre as 'NOMBRE'
FROM estadistica as e
INNER JOIN jugador as j
ON e.jugador = j.codigo
WHERE NOMBRE = 'Pau Gasol' AND e.temporada = '04/05';

/*10. Mostrar el número de puntos de cada jugador en toda su carrera.  VERRRRRR*/

SELECT j.nombre, ROUND(SUM(e.Puntos_por_partido), 2) as 'Total_de_puntos'
FROM jugador as j
INNER JOIN estadistica as e
ON j.codigo = e.jugador
GROUP BY j.nombre;


/*11. Mostrar el número de jugadores de cada equipo.*/

select nombre_equipo, count(*) as 'Cantidad' from jugador group by nombre_equipo;

/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/


select suma.nombre, round(suma.puntos,2)
from (select jug.nombre, sum(est.Puntos_por_partido) as 'puntos'
from jugador jug, estadistica est
where jug.codigo = est.jugador 
group by jug.nombre
order by jug.nombre) suma
where suma.puntos = (select max(suma2.puntos) from (select jug.nombre, sum(est.Puntos_por_partido) as puntos 
from jugador jug, estadistica est
where jug.codigo = est.jugador 
group by  jug.nombre) suma2);



/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/

SELECT j.nombre, e.conferencia, e.division
FROM jugador as j
INNER JOIN equipo as e
ON j.nombre_equipo = e.nombre
WHERE j.altura = (SELECT MAX(altura) FROM jugador);

/*14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/

SELECT * FROM partido;
SELECT * FROM equipo;
SELECT e1.equipo_local, AVG(e1.puntos_local) as 'Media_de_puntos'
FROM partido as e1
INNER JOIN equipo as e2
ON e1.equipo_local = e2.nombre
WHERE e2.division = 'Pacific'
GROUP BY e1.equipo_local;

/*15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor 
diferencia de puntos.*/

SELECT *
FROM partido
WHERE ABS(puntos_local-puntos_visitante) = (SELECT MAX(ABS(puntos_local-puntos_visitante)) FROM partido);


/*16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/

SELECT e.nombre, AVG(puntos_local)
FROM partido as p
INNER JOIN equipo as e
ON p.equipo_local = e.nombre
WHERE e.division = 'Pacific'
GROUP BY e.nombre;

/*17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante. */

SELECT * FROM partido;
SELECT equipo_local, puntos_local, equipo_visitante, puntos_visitante FROM partido;

SELECT DISTINCT(e.nombre),
        (SELECT SUM(puntos_local) FROM partido WHERE equipo_local = e.nombre) as Puntos_local,
        (SELECT SUM(puntos_visitante) FROM partido WHERE equipo_visitante = e.nombre) as Puntos_visitante
FROM equipo as e;


/*18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, 
equipo_ganador), en caso de empate sera null.*/

SELECT codigo, equipo_local, equipo_visitante, IF(puntos_local>puntos_visitante, equipo_local, IF(puntos_local<puntos_visitante, equipo_visitante, null)) as 'equipo_ganador'
FROM partido;


/*IF(condición, obtener_si_verdadero, obtener_si_falso)*/

