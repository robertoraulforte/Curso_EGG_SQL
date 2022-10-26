-- Active: 1665101065679@@localhost@3306@superheroe
/*Actividad 6
a) Ahora veamos cómo ha quedado la tabla “superheroes” que creaste anteriormente. Para ello 
necesitarás una consulta de tipo SELECT.
b) Realiza una consulta que devuelva todos los valores de la columna “nombre_real” de la tabla 
superhéroe.
c) Realiza una consulta que devuelva todos los nombres reales de los personajes cuyo nombre 
empieza con “B”*/

use superheroe;
select * from personaje;
select * from creador;
select nombre_real from personaje;
seLECT nombre_real FROM personaje WHERE personaje LIKE'b%';
