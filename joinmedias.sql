-- Nº TOTAL DE ADMISIONES

SELECT 
    COUNT(*)
FROM
    admisiones;
    
-- PACIENTES QUE NO HAN RECIBIDO EL ALTA

SELECT 
    COUNT(*)
FROM
    admisiones
WHERE fecha_alta IS NULL;

SELECT 
    COUNT(1)
FROM
    admisiones
WHERE fecha_alta IS NULL;

-- PACIENTES QUE SÍ HAN RECIBIDO EL ALTA

SELECT 
    COUNT(fecha_alta) -- si especificamos un campo, el count, nos cuenta sólo los que no tengan valor null
FROM
    admisiones;
    
SELECT NOW(); -- NOS DA LA FECHA HORA ACTUALES (MÁS PRECISO)   
    
-- Nº DE ADMISIONES EN EL ÚLTIMO MES
SELECT 
    COUNT(*)
FROM
    admisiones
 -- filtrar las admisiones del último mes. la fecha de admisión sea mayor o igual que la fecha actual, menos un mes
WHERE fecha_admision >=  NOW() - INTERVAL 1 MONTH;


-- Nº DE ADMISIONES EN EL ÚLTIMO AÑO
SELECT 
    COUNT(*)
FROM
    admisiones
 -- filtrar las admisiones del último mes. la fecha de admisión sea mayor o igual que la fecha actual, menos un mes
WHERE fecha_admision >=  NOW() - INTERVAL 1 YEAR; 

-- Nº DE ADMISIONES EN UN INTERVALO CONCRETO

SELECT 
    COUNT(*)
FROM
    admisiones
WHERE fecha_admision BETWEEN '2025-01-01' AND '2026-03-26'; 

-- DADO UN ID DE PACIENTE, CONSULTAMOS CUÁNTAS ADMISIONES HA TENIDO EN EL ÚLITMO MES

SET @idpaciente := 1;
SELECT 
    COUNT(*)
FROM
    admisiones
WHERE
    paciente_id = @idpaciente
AND
fecha_admision >=  DATE_SUB(CURDATE(), INTERVAL 12 MONTH);

SELECT CURDATE(); -- SELECCIONA LA FECHA ACTUAL (SIN LA HORA)


-- UN LISTADO DE ALERGIAS, AGRUPADO POR SU NOMBRE Y EL NÚMERO DE PACIENTES QUE LA PADECEN

SELECT 
    alergias.nombre, COUNT(*) AS num_pacientes
FROM
    paciente_alergia
        JOIN
    alergias ON paciente_alergia.alergia_id = alergias.alergia_id
GROUP BY alergias.nombre;


-- OBTENEMOS LA MEDIA DE PESO DE LOS PACIENTES

SELECT 
    ROUND(AVG(pacientes.peso),1) AS peso_medio
FROM
    pacientes;


-- OBTENEMOS LA MEDIA DE ALTURA DE LOS PACIENTES

SELECT 
    ROUND(AVG(pacientes.altura),2) AS altura_media
FROM
    pacientes;


-- PACIENTES QUE TENGAN MÁS DE UNA ALERGIA

SELECT paciente_id, COUNT(*) AS num_alergias
FROM paciente_alergia
GROUP BY paciente_id
HAVING num_alergias > 1; -- "WHERE" FILTRO DE FILAS PERO DE GROUP BY

-- LIMIT 

-- ALERGÍA MÁS CÓMUN

SELECT a.nombre, COUNT(*) AS num_pacientes
FROM paciente_alergia pa 
JOIN alergias a ON pa.alergia_id = a.alergia_id
GROUP BY a.nombre
ORDER BY num_pacientes DESC
LIMIT 1;

-- PACIENTES CON UN PESO SUPERRIOR A LA MEDIA

-- 1 SACO LA MEDIA
-- 2 SACO LOS PACIENTES, QUE TENGA PESO SUPERIOR A ESA MEDIA


SELECT AVG(peso) FROM pacientes;

-- EJEMPLO DE SUBOCNULSTA CON AGREGACIÓN

SELECT 
    nombre, apellido, peso
FROM
    pacientes
WHERE
    peso > (SELECT 
            AVG(peso)
        FROM
            pacientes);