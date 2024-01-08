-- 1. Mostrar los campos nombre, nombre del entrenador, nombre del campo de fútbol, población y año de fundación de todos los equipos.
SELECT nombre, nombre_entrenador, nombre_campo_futbol, poblacion, anio_fundacion FROM equipos;

-- 2. Mostrar los campos nombre, nombre del entrenador, nombre del campo de fútbol, población y año de fundación de todos los equipos que no hayan jugado ningún partido.
SELECT e.nombre, e.nombre_entrenador, e.nombre_campo_futbol, e.poblacion, e.anio_fundacion
FROM equipos e
LEFT JOIN partidos p ON e.registro = p.id_equipo1 OR e.registro = p.id_equipo2
WHERE p.registro IS NULL;

-- 3. Borrar los equipos que no hayan jugado ningún partido.
DELETE FROM equipos
WHERE registro IN (
    SELECT e.registro
    FROM equipos e
    LEFT JOIN partidos p ON e.registro = p.id_equipo1 OR e.registro = p.id_equipo2
    WHERE p.registro IS NULL
);

-- 4. Mostrar los campos nombre, nombre del entrenador, nombre del campo de fútbol, población y año de fundación de los equipos no borrados.
SELECT nombre, nombre_entrenador, nombre_campo_futbol, poblacion, anio_fundacion FROM equipos;

-- 5. Borrar las tablas de la base de datos liga_futbol.
DROP TABLE partidos;
DROP TABLE equipos;

-- 6. Borrar la base de datos liga_futbol.
DROP DATABASE liga_futbol;