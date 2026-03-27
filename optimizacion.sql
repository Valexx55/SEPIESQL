-- RESUMEN TEORÍA


-- 1) ÍNDICES (lo más crítico)

-- 	WHERE, JOIN, ORDER BY, GROUP BY

--  2) MODELO DE DATOS

-- 	DATOS CALCULADOS, TABLAS PARTIDAS, AUXILIARES

-- 3) QUERY

-- 	NAVEGAR DE TABLA MÁS FILTRADA A MENOS
-- 	FUNCIONES EN COLUMNAS CARO
-- 	ORDER BY ES CARO SOBRE TODO SIN ÍNDICE
-- 	GROUP BY GRANDE (TABLA TEMPORAL= CARO)
-- 	DISTINCT

-- 4) REDUCIR VOLUMEN

-- 	FILTRAR WHERE
-- 	LIMIT
-- 	NO USAR SELECT *

-- 5) LEER EL PLAN DE EJECUCIÓN

-- 6) CONOCER NEGOCIO ( Y OpERACIONES DESDE LA CAPA DE APP), RELACIÓN ENTRE DATOS

-- 7) OPTIMIAZACIONES DESDE LA CAPA DEL SERVICIO (TRANSACCIONES DE SÓLO LECTURA, CACHÉS)


-- admisiones de 2025 pacientes

SELECT p.nombre, p.apellido, a.fecha_admision
FROM pacientes p
JOIN admisiones a
    ON p.paciente_id = a.paciente_id
WHERE YEAR(a.fecha_admision) = 2025;

EXPLAIN
SELECT p.nombre, p.apellido, a.fecha_admision
FROM pacientes p
JOIN admisiones a
    ON p.paciente_id = a.paciente_id
WHERE YEAR(a.fecha_admision) = 2025;

-- # id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- 1, SIMPLE, a, , ALL, fkpacientead_idx, , , , 12, 100.00, Using where
-- 1, SIMPLE, p, , eq_ref, PRIMARY, PRIMARY, 4, hospital.a.paciente_id, 1, 100.00,


EXPLAIN ANALYZE
SELECT p.nombre, p.apellido, a.fecha_admision
FROM pacientes p
JOIN admisiones a
    ON p.paciente_id = a.paciente_id
WHERE YEAR(a.fecha_admision) = 2025; 

-- -> Nested loop inner join  (cost=5.65 rows=12) (actual time=0.0605..0.265 rows=12 loops=1)
--    -> Filter: ((year(a.fecha_admision) = 2025) and (a.paciente_id is not null))  (cost=1.45 rows=12) (actual time=0.0404..0.0986 rows=12 loops=1)
--        -> Table scan on a  (cost=1.45 rows=12) (actual time=0.0367..0.0474 rows=12 loops=1)
--    -> Single-row index lookup on p using PRIMARY (paciente_id=a.paciente_id)  (cost=0.258 rows=1) (actual time=0.013..0.0131 rows=1 loops=12)



-- ganancia 1 : mejorar el filtrado ELIMINAMOS LA LLAMADA A UNA FUNCIÓN

SELECT p.nombre, p.apellido, a.fecha_admision
FROM pacientes p
JOIN admisiones a
    ON p.paciente_id = a.paciente_id
WHERE a.fecha_admision >= '2025-01-01' AND a.fecha_admision < '2026-01-01';

-- ganacia 2: creamos un índice para fecha de admsión, puesto que filtramos por ese dato

CREATE INDEX idx_admisiones_fecha ON admisiones(fecha_admision);

-- esta alternativa, de indice compuesto, mejora más aún, puesto que se usan los dos campos para filtrar/comprar en nuestra consulta
CREATE INDEX idx_admisiones_fecha_paciente
ON admisiones(fecha_admision, paciente_id);

-- orden de navegación: empezar por la tabla que filtra más, me hace ganar

SELECT 
    p.nombre, p.apellido, a.fecha_admision
FROM
    admisiones a
        JOIN
    pacientes p ON p.paciente_id = a.paciente_id
WHERE
    a.fecha_admision >= '2025-01-01' AND a.fecha_admision < '2026-01-01';
   
EXPLAIN
SELECT 
    p.nombre, p.apellido, a.fecha_admision
FROM
    admisiones a
        JOIN
    pacientes p ON p.paciente_id = a.paciente_id
WHERE
    a.fecha_admision >= '2025-01-01' AND a.fecha_admision < '2026-01-01';


-- # id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- 1, SIMPLE, a, , index, fkpacientead_idx,idx_admisiones_fecha,idx_admisiones_fecha_paciente, idx_admisiones_fecha_paciente, 11, , 12, 100.00, Using where; Using index
-- 1, SIMPLE, p, , eq_ref, PRIMARY, PRIMARY, 4, hospital.a.paciente_id, 1, 100.00, 



EXPLAIN ANALYZE
SELECT 
    p.nombre, p.apellido, a.fecha_admision
FROM
    admisiones a
        JOIN
    pacientes p ON p.paciente_id = a.paciente_id
WHERE
    a.fecha_admision >= '2025-01-01' AND a.fecha_admision < '2026-01-01';


-- -> Nested loop inner join  (cost=5.65 rows=12) (actual time=0.0495..0.0745 rows=12 loops=1)
--    -> Filter: ((a.fecha_admision >= TIMESTAMP'2025-01-01 00:00:00') and (a.fecha_admision < TIMESTAMP'2026-01-01 00:00:00') and (a.paciente_id is not null))  (cost=1.45 rows=12) (actual time=0.0303..0.039 rows=12 loops=1)
--        -> Covering index scan on a using idx_admisiones_fecha_paciente  (cost=1.45 rows=12) (actual time=0.028..0.0348 rows=12 loops=1)
--    -> Single-row index lookup on p using PRIMARY (paciente_id=a.paciente_id)  (cost=0.258 rows=1) (actual time=0.00259..0.00261 rows=1 loops=12)




-- -> Nested loop inner join  (cost=5.65 rows=12) (actual time=0.0605..0.265 rows=12 loops=1)
--    -> Filter: ((year(a.fecha_admision) = 2025) and (a.paciente_id is not null))  (cost=1.45 rows=12) (actual time=0.0404..0.0986 rows=12 loops=1)
--        -> Table scan on a  (cost=1.45 rows=12) (actual time=0.0367..0.0474 rows=12 loops=1)
--    -> Single-row index lookup on p using PRIMARY (paciente_id=a.paciente_id)  (cost=0.258 rows=1) (actual time=0.013..0.0131 rows=1 loops=12)

