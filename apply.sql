-- APPLY SIRVE PARA CUANDO CON CADA FILA DE UNA TABLA, TÚ NECESITAS EJECUTAR UNA CONSULTA RELACIONADA PARA ESA FILA

-- cross APPLY (sql server) =aprox INNER JOIN (mysql) 
-- outer APPLY (sql server) =aprox LEFT JOIN (mysql) 


-- EJ:  PACIENTES SIN ADMISIONES

 -- “Recorro pacientes, y para cada paciente intento traer su última admisión. Y SI NO TIENE, TE QUEDAS CON EL PACIENTE IGUALMENTE”
 
 -- 1 SACAMOS LA ÚLITMA FECHA DE ADMISIÓN UN PACIENTE
 
 SELECT p.paciente_id, p.nombre, p.apellido, x.ultima_fecha
 FROM pacientes p 
 LEFT JOIN (
	SELECT paciente_id, MAX(fecha_admision) AS ultima_fecha
    FROM admisiones
	GROUP BY paciente_id
    ) x ON p.paciente_id = x.paciente_id;
    
-- versión SQL SERVER CON OUTER APPLY. DEJAMOS EN COMENTARIOS ESTO PORQUE NO EXISTE / NO ESTÁ SOPORTADO EN MYSQL
--
-- SELECT p.paciente_id, p.nombre, p.apellido, a.fecha_ingreso
-- FROM pacientes p
-- OUTER APPLY (
--     SELECT TOP 1 ad.fecha_ingreso
--    FROM admisiones ad
--     WHERE ad.paciente_id = p.paciente_id
--     ORDER BY ad.fecha_ingreso DESC
-- ) a;