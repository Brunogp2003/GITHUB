-- 1. Mostrar todos los campos de todos los registros de las dos tablas.
SELECT * FROM equipos;
SELECT * FROM partidos;

-- 2. Actualizar los datos de algunos registros de las dos tablas de forma que los cambios afecten a varios campos.
-- Por ejemplo, actualizamos el nombre del entrenador y la población de algunos equipos
UPDATE equipos SET nombre_entrenador = 'Nuevo Entrenador', poblacion = 'Nueva Poblacion' WHERE registro IN (1, 3, 5);

-- 3. Volver a mostrar todos los campos de todos los registros de las dos tablas.
SELECT * FROM equipos;
SELECT * FROM partidos;

-- 4. Mostrar la información introducida en las dos tablas de la forma siguiente:
-- Mostrar el número de registro, el nombre equipo, la población y año de fundación de aquellos equipos fundados después de 1940.
SELECT registro, nombre, poblacion, anio_fundacion
FROM equipos
WHERE anio_fundacion > 1940;

-- Hallar la media de puntos de cada partido entre los dos equipos.
SELECT ROUND(AVG(resultado_equipo1 + resultado_equipo2), 2) 
FROM partidos;

-- Hallar la media de los goles de cada equipo y nombre del equipo, ordenar el resultado decrecientemente por el nº de goles.
SELECT nombre, ROUND(AVG(goles)) AS media_goles
FROM (
    SELECT id_equipo1 AS id_equipo, resultado_equipo1 AS goles FROM partidos
    UNION ALL
    SELECT id_equipo2 AS id_equipo, resultado_equipo2 AS goles FROM partidos
) AS goles_equipo
JOIN equipos ON goles_equipo.id_equipo = equipos.registro
GROUP BY nombre
ORDER BY media_goles DESC;

-- Hallar la diferencia de puntos entre todos los partidos de los equipos.
SELECT 
    e1.nombre AS equipo1, 
    e2.nombre AS equipo2, 
    ABS(resultado_equipo1 - resultado_equipo2) AS diferencia_puntos
FROM partidos
JOIN equipos e1 ON partidos.id_equipo1 = e1.registro
JOIN equipos e2 ON partidos.id_equipo2 = e2.registro
ORDER BY diferencia_puntos DESC;

-- Hallar el mayor número de partidos ganados por cada equipo.
SELECT nombre, MAX(partidos_ganados) AS max_partidos_ganados
FROM (
    SELECT id_equipo1 AS id_equipo, COUNT(*) AS partidos_ganados FROM partidos WHERE resultado_equipo1 > resultado_equipo2 GROUP BY id_equipo1
    UNION ALL
    SELECT id_equipo2 AS id_equipo, COUNT(*) AS partidos_ganados FROM partidos WHERE resultado_equipo2 > resultado_equipo1 GROUP BY id_equipo2
) AS partidos_ganados_equipo
JOIN equipos ON partidos_ganados_equipo.id_equipo = equipos.registro
GROUP BY nombre
ORDER BY max_partidos_ganados DESC;