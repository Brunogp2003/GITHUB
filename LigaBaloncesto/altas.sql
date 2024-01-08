--1.  Crear una base de datos que se denomine “liga_futbol”.
Create DATABASE liga_futbol;
use liga_futbol;

/*2.  Dentro de “liga_futbol” crear dos tablas: “equipos” y “partidos”.
En esta tabla se asocian mediante los campos registro de la tabla equipos con los campos id_equipo1 e id_equipo2 de esta tabla. 
Los campos resultado_equipo1 y resultado_equipo2 indican los goles marcados por cada equipo en ese partido. */
-- Crear la tabla "equipos"
CREATE TABLE equipos (
    registro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE,
    nombre_entrenador VARCHAR(35),
    nombre_campo_futbol VARCHAR(30),
    poblacion VARCHAR(25),
    anio_fundacion INT,
    anotaciones BLOB
);

-- Crear la tabla "partidos"
CREATE TABLE partidos (
    registro INT AUTO_INCREMENT PRIMARY KEY,
    id_equipo1 INT,
    resultado_equipo1 INT,
    id_equipo2 INT,
    resultado_equipo2 INT,
    FOREIGN KEY (id_equipo1) REFERENCES equipos(registro),
    FOREIGN KEY (id_equipo2) REFERENCES equipos(registro)
);

/*3.  Introducir de 8 a 10 registros en cada tabla con datos variados y coherentes, que puedes inventar, para que sea posible realizar consultas con resultados. 
Conviene que leas antes el tipo de consultas que se van a pedir para introducir los datos que convenga. Las consultas aparecen en el punto 4 de los dos primeros scripts sql.*/

INSERT INTO equipos (nombre, nombre_entrenador, nombre_campo_futbol, poblacion, anio_fundacion, anotaciones)
VALUES 
('FC Bayern Munich', 'Hans-Dieter Flick', 'Allianz Arena', 'Munich', 1900, 'German Giants'),
('Paris Saint-Germain', 'Mauricio Pochettino', 'Parc des Princes', 'Paris', 1970, 'City of Lights'),
('Manchester City', 'Pep Guardiola', 'Etihad Stadium', 'Manchester', 1880, 'Sky Blues'),
('Juventus FC', 'Massimiliano Allegri', 'Allianz Stadium', 'Turin', 1897, 'Bianconeri'),
('Borussia Dortmund', 'Marco Rose', 'Signal Iduna Park', 'Dortmund', 1909, 'Yellow Wall'),
('Chelsea FC', 'Thomas Tuchel', 'Stamford Bridge', 'London', 1905, 'Blues'),
('AC Milan', 'Stefano Pioli', 'San Siro', 'Milan', 1899, 'Rossoneri'),
('Ajax Amsterdam', 'Erik ten Hag', 'Johan Cruijff Arena', 'Amsterdam', 1900, 'Godenzonen'),
('FC Porto', 'Sérgio Conceição', 'Estádio do Dragão', 'Porto', 1893, 'Dragões'),
('AS Roma', 'José Mourinho', 'Stadio Olimpico', 'Rome', 1927, 'Giallorossi');

-- Partidos
INSERT INTO partidos (id_equipo1, resultado_equipo1, id_equipo2, resultado_equipo2)
VALUES
(1, 2, 2, 1),
(3, 0, 4, 2),
(5, 1, 6, 1),
(7, 3, 8, 0),
(9, 2, 10, 2),
(2, 1, 4, 1),
(6, 0, 8, 2),
(10, 3, 1, 1),
(3, 2, 5, 0),
(7, 1, 9, 2);

/*4.  Mostrar la información introducida en las dos tablas de la forma siguiente:
Todos los campos de todos los registros de la tabla “equipos”.*/
Select * from equipos;

/*Los campos nombre, entrenador y nombre del campo de fútbol sólo de los equipos de una determinada población.*/
SELECT nombre, nombre_entrenador, nombre_campo_futbol
FROM equipos
WHERE poblacion = 'Madrid';

/*Los campos nombre del equipo, población y anotaciones de los equipos cuyo nombre empieza por el carácter 'B'.*/
SELECT nombre, poblacion, anotaciones
FROM equipos
WHERE nombre LIKE 'B%';

/*El número de equipos y población agrupados por la población ordenados decrecientemente por el número de equipos.*/
SELECT poblacion, COUNT(*) AS num_equipos
FROM equipos
GROUP BY poblacion
ORDER BY num_equipos DESC;

/* Año de la fundación del primer equipo. */
SELECT MIN(anio_fundacion) FROM equipos;

/*Partidos jugados: nombre del equipo1, nombre del equipo2, resultado equipo1, resultado equipo2 ordenados por el nombre del equipo1. */
SELECT e1.nombre AS equipo1, e2.nombre AS equipo2, p.resultado_equipo1, p.resultado_equipo2
FROM partidos p
JOIN equipos e1 ON p.id_equipo1 = e1.registro
JOIN equipos e2 ON p.id_equipo2 = e2.registro
ORDER BY equipo1;

/*Los campos nº total de partidos jugados (campo calculado) y nombre del equipo ordenado decrecientemente por el nº de partidos jugados.*/
SELECT equipo, SUM(num_partidos) AS total_partidos_jugados
FROM (
    SELECT e.nombre AS equipo, COUNT(*) AS num_partidos
    FROM partidos p
    JOIN equipos e ON p.id_equipo1 = e.registro
    GROUP BY equipo
    UNION ALL
    SELECT e.nombre AS equipo, COUNT(*) AS num_partidos
    FROM partidos p
    JOIN equipos e ON p.id_equipo2 = e.registro
    GROUP BY equipo
) AS partidos_equipo
GROUP BY equipo
ORDER BY total_partidos_jugados DESC;