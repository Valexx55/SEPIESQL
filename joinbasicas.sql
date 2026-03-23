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
   