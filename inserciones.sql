INSERT INTO `provincias` VALUES (1,'Madrid'),(2,'Barcelona'),(3,'Valencia'),(4,'Sevilla'),(5,'Zaragoza'),(6,'Málaga'),(7,'Bilbao');


INSERT INTO `poblaciones` VALUES (1,'Alcalá de Henares',1),(2,'Hospitalet',2),(3,'Torrent',3),(4,'Dos Hermanas',4),(5,'Móstoles',1),(6,'Badalona',2),(7,'Zaragoza',5),(8,'Rincón de la Victoria',6),(9,'Getxo',7),(10,'Torremolinos',6);


INSERT INTO `doctores` VALUES (1,'Ana','Ramírez','Cardiología'),(2,'Carlos','López','Pediatría'),(3,'Elena','Moreno','Dermatología'),(4,'David','Fernández','Ginecología'),(5,'Lucía','Martín','Neurología'),(6,'Isabel','Nieto','Neumología'),(7,'Fernando','Serrano','Oncología'),(8,'Raquel','Cano','Traumatología'),(9,'Alberto','Muñoz','Psiquiatría'),(10,'Patricia','Herrera','Endocrinología');


INSERT INTO `alergias` VALUES (8,'Cacahuetes'),(3,'Frutos secos'),(5,'Gluten'),(4,'Lácteos'),(6,'Mariscos'),(1,'Penicilina'),(2,'Polen'),(7,'Polvo');



INSERT INTO `pacientes` VALUES (1,'Juan','Pérez','M','1985-06-15',72.5,1.75,1),(2,'María','Gómez','F','1990-03-22',65.0,1.68,2),(3,'Luis','Martínez','M','1978-12-01',80.3,1.80,3),(4,'Laura','Sánchez','F','2000-07-10',55.0,1.60,4),(5,'Pedro','Ruiz','M','1995-04-19',90.0,1.85,5),(6,'Ana','López','F','1982-08-08',62.0,1.70,6),(7,'Jorge','Navarro','M','1980-02-10',84.0,1.78,7),(8,'Carmen','Delgado','F','1975-11-25',58.0,1.62,8),(9,'Andrés','Molina','M','1999-09-01',70.0,1.70,9),(10,'Beatriz','Ortiz','F','2003-03-15',52.0,1.65,10),(11,'Lucas','Gil','M','1992-12-30',76.5,1.79,7),(12,'Sara','Ibáñez','F','1987-04-17',60.0,1.67,9),(13,'Paco','Pil','M','1995-03-02',80.0,2.00,7);


INSERT INTO `paciente_alergia` VALUES (1,1,1),(2,2,2),(3,2,3),(4,3,5),(5,4,4),(6,5,2),(7,6,1),(8,7,6),(9,8,5),(10,9,1),(11,10,8),(12,11,2),(13,12,3),(14,12,7);



INSERT INTO `admisiones` VALUES (1,'2025-05-01 10:00:00','2025-05-03 14:00:00','Gripe común',1,2),(2,'2025-05-04 09:30:00',NULL,'Dolor abdominal',2,4),(3,'2025-05-06 15:20:00','2025-05-08 11:00:00','Infarto leve',3,1),(4,'2025-05-10 08:00:00','2025-05-12 10:30:00','Migraña',4,5),(5,'2025-05-15 14:10:00',NULL,'Alergia alimentaria',5,3),(6,'2025-05-18 12:00:00',NULL,'Bronquitis',6,2),(7,'2025-05-21 11:00:00',NULL,'Asma crónica',7,6),(8,'2025-05-22 09:30:00','2025-05-23 13:00:00','Fractura de brazo',8,8),(9,'2025-05-24 16:00:00',NULL,'Depresión severa',9,9),(10,'2025-05-25 08:30:00',NULL,'Diabetes tipo 2',10,10),(11,'2025-05-26 10:00:00','2025-05-28 10:00:00','Cáncer de piel',11,7),(12,'2025-05-27 14:15:00',NULL,'Migraña aguda',12,5);