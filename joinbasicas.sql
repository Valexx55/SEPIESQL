-- SELECCIÓN DE PACIENTES CON SU NOMBRE, APELLIDO Y EL NOMBRE DE LA POBLACIÓN

SELECT 
    pacientes.nombre, pacientes.apellido, poblaciones.nombre
FROM
    pacientes
        JOIN
    poblaciones ON pacientes.poblacion_id = poblaciones.poblacion_id;

-- igual con SUBCONSULTAS anidadas

SELECT nombre, apellido FROM pacientes -- subconsulta 1
WHERE poblacion_id IN (
	SELECT poblacion_id FROM poblaciones -- subconsulta 2
);    

SELECT 
    pa.nombre AS nombre_paciente, 
    pa.apellido AS apellido_paciente, 
    po.nombre AS localidad
FROM
    pacientes pa
        JOIN
    poblaciones po ON pa.poblacion_id = po.poblacion_id;
    
    
-- SELECCIÓN DE PACIENTES CON SU NOMBRE, APELLIDO Y EL NOMBRE DE LA POBLACIÓN
-- ojo, USAMOS LEFT JOIN, por lo que si un paciente no tuviera población asignada, también
-- aparecería en el listado. En esta caso, como todos los pacientes tiene población asignada
-- el resultado es idéntico al JOIN (consulta anterior)


SELECT 
    pacientes.nombre, pacientes.apellido, poblaciones.nombre
FROM
    pacientes
       LEFT JOIN
    poblaciones ON pacientes.poblacion_id = poblaciones.poblacion_id;
 
 
-- SELECCIÓN DE PACIENTES CON SU NOMBRE, APELLIDO Y EL NOMBRE DE LA POBLACIÓN
-- ojo, USAMOS RIGHT JOIN, por lo que si un POBLACIÓN no tuviera relación con ningún paciente, también
-- aparecería en el listado. En esta caso, si añadimos una población nueva, 
-- aparecerá aún sin relación con ningún paciente

INSERT INTO `poblaciones` VALUES (11,'Málaga',6);


SELECT 
    pacientes.nombre, pacientes.apellido, poblaciones.nombre
FROM
    pacientes
       RIGHT JOIN
    poblaciones ON pacientes.poblacion_id = poblaciones.poblacion_id;
    
    
    
-- SACAD UN LISTADO DE AMDISIONES (CON SU ID Y LA FECHA DE ENTRADA) y el NOMBRE Y APELLIDO DEL PACIENTE 
-- CON INNER JOIN O JOIN 

-- SOLUCIÓN GONZALO

SELECT 
    a.admision_id,
    a.fecha_admision,
    p.nombre,
    p.apellido
FROM admisiones a
INNER JOIN pacientes p 
    ON a.paciente_id = p.paciente_id;

-- TAREA OPCIONAL SACAD UN LISTADO DE AMDISIONES (CON SU ID Y LA FECHA DE ENTRADA) y el NOMBRE Y APELLIDO DEL PACIENTE 
-- CON INNER JOIN O JOIN SOLAMENTE DE LAS ADMISIONES EN EL 2024 

SELECT 
    a.admision_id,
    a.fecha_admision,
    p.nombre,
    p.apellido
FROM admisiones a
INNER JOIN pacientes p 
    ON a.paciente_id = p.paciente_id
WHERE 
	YEAR (a.fecha_admision) = 2024;
    
-- TODO SACAD UN LISTADO DE LOS NOMBRES DE LOS PACIENTES, SU LOCALIDAD Y SU PROVINCIA
-- ORDER 

SELECT 
    pacientes.nombre AS nombre_paciente,
    pacientes.apellido AS apellido_paciente,
    poblaciones.nombre AS localidad,
    provincias.nombre AS provincia
FROM
    pacientes
        JOIN
    poblaciones ON pacientes.poblacion_id = poblaciones.poblacion_id
        JOIN
    provincias ON poblaciones.provincia_id = provincias.provincia_id
ORDER BY provincias.nombre, pacientes.nombre; -- ORDENACIÓN MÚLTIPLE 


-- SACAD UN LISTADO DE TODOS LOS PACIENTES (NOMBRE) CON TODAS SUS ALERGIAS (NOMBRE)

-- sol Marta

SELECT 
    pacientes.nombre AS nombre_paciente,
    alergias.nombre AS alergia
FROM
    pacientes
        JOIN
    paciente_alergia ON paciente_alergia.paciente_id = pacientes.paciente_id
        JOIN
    alergias ON alergias.alergia_id = paciente_alergia.alergia_id
ORDER BY nombre_paciente;

-- sol GOnzalo

SELECT 
    p.nombre,
    p.apellido,
    a.nombre AS alergia
FROM pacientes p,paciente_alergia pa , alergias a
WHERE
	p.paciente_id = pa.paciente_id
AND
	pa.alergia_id = a.alergia_id;
    

-- CONSULTAD EL NOMBRE DE TODOS LOS PACIENTES QUE TIENEN ALERGIA

SELECT 
    nombre, apellido
FROM
    pacientes
WHERE
    paciente_id IN (SELECT -- buscamos si ese paciente, está en este conjunto de ids
            paciente_id
        FROM
            paciente_alergia);
            
SELECT
	p.nombre, 
    p.apellido
FROM  pacientes p
WHERE EXISTS (
	SELECT 1  -- me da igual el contenido, sólo quiero saber si exsite al menos una fila
    FROM paciente_alergia pa
    WHERE pa.paciente_id = p.paciente_id -- BUSCA REGUSTROS EN PACIENTE_ALERGIA que correspondan a este paciente. COn que haya uno, ya para de comprobar. Es más efiecente que JOIN
);

            
SELECT DISTINCT -- arreglo duplicados 
    pacientes.nombre AS nombre_paciente,
    pacientes.apellido AS apellido
FROM
    pacientes
        JOIN
    paciente_alergia ON paciente_alergia.paciente_id = pacientes.paciente_id -- aquí recorro toda la tabla intermedia paciente_alergia
ORDER BY nombre_paciente;


-- CONSULTAD EL NOMBRE Y APELLIDO DE TODOS LOS PACIENTES QUE NO TIENEN ALERGIA

-- enfoque join

SELECT 
    p.nombre, p.apellido -- , pa.paciente_id
FROM
    pacientes p
        LEFT JOIN
    paciente_alergia pa ON p.paciente_id = pa.paciente_id
WHERE pa.paciente_id IS NULL;

-- enfoque exists

SELECT
	p.nombre, 
    p.apellido
FROM  pacientes p
WHERE NOT EXISTS (
	SELECT 1  -- me da igual el contenido, sólo quiero saber si exsite al menos una fila
    FROM paciente_alergia pa
    WHERE pa.paciente_id = p.paciente_id -- BUSCA REGUSTROS EN PACIENTE_ALERGIA que correspondan a este paciente. COn que haya uno, ya para de comprobar. Es más efiecente que JOIN
);

SELECT 
    nombre, apellido
FROM
    pacientes
WHERE
    paciente_id NOT IN (SELECT 
            paciente_id
        FROM
            paciente_alergia);