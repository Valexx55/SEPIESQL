-- CTE COMMON TABLE EXPRESSION " WITH " 
-- idea -> simplificar 
-- 1 filtro (DE LA PRIMERA SELECT) --> CONSULTO
-- DESCOPONER PORBLEMAS COMPLEJOS

-- 1 HACEMOS UNA CONUSLTA PARA SACAR LOS PACIENTES HOMBRE
-- 2 SACAMOS LOS NOMBRES DE ESOS HOMBRES

WITH pacientes_hombre AS ( -- pacientes_hombre es una tabla temporal 
 	SELECT 
    *
FROM
    pacientes
WHERE
    genero = 'M'
) SELECT nombre FROM pacientes_hombre;




WITH admisiones_2025 AS (
	SELECT 
    *
FROM
    admisiones
WHERE
    YEAR(fecha_admision) = 2025
) SELECT * FROM admisiones_2025;


-- TAREA: SACAD EL NOMBRE Y EL APELLIDO DE LOS PACIENTES CON ADMSIONES EN 2025 USANDO WITH ANTERIOR


WITH admisiones_2025 AS (
	SELECT 
    *
FROM
    admisiones
WHERE
    YEAR(fecha_admision) = 2025
)SELECT 
    p.nombre, p.apellido
FROM
    pacientes p
        JOIN
    admisiones_2025 ad 
    ON p.paciente_id = ad.paciente_id;
    

-- seleccionamos los pacientes con más de 2 admisiones VERSIÓN "NORMAL" VS CTE

SELECT p.nombre, p.apellido, COUNT(*) AS total_admisiones 
FROM pacientes p 
JOIN admisiones a ON a.paciente_id = p.paciente_id
GROUP BY p.paciente_id, p.nombre, p.apellido
HAVING total_admisiones > 2;

-- cte with

WITH total_admisiones AS (
	SELECT paciente_id, COUNT(*) AS num_admisiones  -- contamos total de admsiones por paciente
    FROM admisiones
    GROUP BY paciente_id
) SELECT p.nombre, p.apellido, t.num_admisiones -- filtramos el subconjunto anterior, extrayendo los nombres de pacientes que han estado más de 2 veces
FROM pacientes p 
JOIN total_admisiones t ON p.paciente_id = t.paciente_id
WHERE t.num_admisiones >2; -- para ver algún dato, usamos >= 1;


EXPLAIN ANALYZE
SELECT p.nombre, p.apellido, COUNT(*) AS total_admisiones 
FROM pacientes p 
JOIN admisiones a ON a.paciente_id = p.paciente_id
GROUP BY p.paciente_id, p.nombre, p.apellido
HAVING total_admisiones > 2;

  