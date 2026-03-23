USE hospital;

-- 1 SELECCIONAMOS TODOS LOS DATOS DE TODOS LOS PACIENTES
SELECT 
    *
FROM
    pacientes;

-- 2 SELECCIONAMOS NOMBRE Y APELLIDOS DE TODOS LOS PACIENTES
SELECT 
    nombre, apellido
FROM
    pacientes;


-- SELECCIONAMOS EL NOMBRE, APELLIDO Y GÉNERO DE LOS PACIENTES DEL GÉNERO MASCULINO

SELECT 
    nombre, apellido, genero
FROM
    pacientes
WHERE
    genero = 'M';
    
    
-- SELECCIONAMOS EL NOMBRE, APELLIDO Y GÉNERO DE LOS PACIENTES DEL GÉNERO FEMENINO

SELECT 
    nombre, apellido, genero
FROM
    pacientes
WHERE
    genero = 'F';
    
-- SELECCIONAMOS EL NOMBRE DE LOS PACIENTES QUE EMPIECEN POR LA LETRA 'L'

SELECT 
    nombre
FROM
    pacientes
WHERE
    nombre LIKE 'L%'; -- nombre empiece por L . O sea, que sea L la primera y lo que sea después % comodín
    
    
-- mysql> SELECT SUBSTRING('Quadratically',5,6);
--        -> 'ratica'

-- versión 2, usamos Substring en vez de LIke

SELECT 
    nombre
FROM
    pacientes
WHERE
    -- la primera letra del Nombre sea una L 
    SUBSTRING(nombre, 1, 1) = 'L';


-- SELECCIONAMOS EL NOMBRE DE LOS PACIENTES QUE CONTENGAN UNA a

SELECT 
    nombre
FROM
    pacientes
WHERE
    nombre LIKE '%a%' ; 
    
-- SELECCIONAR LOS PACIENTES QUE ESTÁN ENTRE 70 Y 90 KGS

SELECT 
    *
FROM
    pacientes
WHERE
    ((peso >= 70) AND (peso <= 90)); -- con OR estaríamos seleccionando todos y no sería válido
    
    
SELECT 
    *
FROM
    pacientes
WHERE
    peso BETWEEN 70 AND 90; -- [70 , 90] incluídos
    
-- CUÁNTOS PACIENTES TENGO

SELECT 
    COUNT(*) -- obtengo el número de filas devuelto * no importa el campo
FROM
    pacientes;

-- CUÁNTOS EL NÚMERO DE PACIENTES NACIDOS EN 1980

SELECT 
    COUNT(*) AS NACIDOS_EN_1980
FROM
    pacientes
WHERE
    SUBSTRING(fecha_nacimiento, 1, 4) = '1980';
    

SELECT 
    COUNT(*) AS NACIDOS_EN_1980_2
FROM
    pacientes
WHERE
    YEAR(fecha_nacimiento) = 1980;
    
SET @anio := 1980; -- definino la variabvle anio y le asigno el valor 1980
SELECT 
    COUNT(*) AS NACIDOS_EN_1980_3
FROM
    pacientes
WHERE
    YEAR(fecha_nacimiento) = @anio;
    
-- CUÁNTOS EL NÚMERO DE PACIENTES NACIDOS EN DÉCADA DE LOS 80 (específico de MySQL)

SELECT 
    COUNT(*) AS NACIDOS_EN_LOS_80
FROM
    pacientes
WHERE
    SUBSTRING(fecha_nacimiento, 1, 4) >= '1980'
        AND SUBSTRING(fecha_nacimiento, 1, 4) < '1990';

-- SELECCIONAMOS EL NOMBRE Y APELLIDOS COMO UN ÚNICA COLUMNA de todos los pacientes

SELECT
	CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM pacientes;
    
    
/**
**9.** Mostrar los pacientes cuya altura sea mayor de 1.75.
**10.** Mostrar los pacientes cuya población sea la 7.
*/ 


SELECT * FROM pacientes WHERE altura > 1.75 ORDER BY altura ASC;



SELECT * FROM pacientes WHERE poblacion_id = 7;

