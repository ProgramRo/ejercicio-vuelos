-- Se crean las tablas
CREATE TABLE pasajeros (rut VARCHAR(10) UNIQUE PRIMARY KEY NOT NULL, nombre VARCHAR (50), apellido VARCHAR (50));
CREATE TABLE vuelos (id SERIAL PRIMARY KEY NOT NULL, cantidad_asientos SMALLINT CHECK(cantidad_asientos >= 0), nombre_ruta VARCHAR(100), horario_despegue TIME, horario_aterrizaje TIME, valor INT);
CREATE TABLE detalle_boletos (id SERIAL PRIMARY KEY NOT NULL, vuelos_fk INT, pasajeros_rut_fk VARCHAR(10), FOREIGN KEY (vuelos_fk) REFERENCES vuelos(id), FOREIGN KEY (pasajeros_rut_fk) REFERENCES pasajeros(rut));

-- Agregar 5 vuelos
INSERT INTO vuelos(cantidad_asientos, nombre_ruta, horario_despegue, horario_aterrizaje, valor) VALUES(200, 'Iquique - Isla de Pascua', '08:30:00', '09:30:00', 100000);
INSERT INTO vuelos(cantidad_asientos, nombre_ruta, horario_despegue, horario_aterrizaje, valor) VALUES(200, 'Isla de Pascua - Iquique', '20:30:00', '21:30:00', 100000);
INSERT INTO vuelos(cantidad_asientos, nombre_ruta, horario_despegue, horario_aterrizaje, valor) VALUES(200, 'Santiago - Puerto Montt', '14:00:00', '15:00:00', 100000);
INSERT INTO vuelos(cantidad_asientos, nombre_ruta, horario_despegue, horario_aterrizaje, valor) VALUES(200, 'San Vicente de Tagua Tagua - Alto Hospicio', '19:30:00', '20:30:00', 100000);
INSERT INTO vuelos(cantidad_asientos, nombre_ruta, horario_despegue, horario_aterrizaje, valor) VALUES(200, 'Alto Hospicio - Miami', '06:30:00', '09:30:00', 100000);

-- Agregar 5 pasajeros
INSERT INTO pasajeros(rut, nombre, apellido) VALUES('5444744-4', 'María Magdalena', 'Del Barrio');
INSERT INTO pasajeros(rut, nombre, apellido) VALUES('17666456-1', 'Benito', 'Bunny');
INSERT INTO pasajeros(rut, nombre, apellido) VALUES('13592333-7', 'Juana María', 'Del Caserío');
INSERT INTO pasajeros(rut, nombre, apellido) VALUES('7987654-0', 'Alicia', 'En el País de las Maravillas');
INSERT INTO pasajeros(rut, nombre, apellido) VALUES('9856542-8', 'Juana', 'Candelaria');

-- Compra con pasajero 1
BEGIN;
INSERT INTO detalle_boletos(vuelos_fk, pasajeros_rut_fk) VALUES(1, '5444744-4');
SELECT cantidad_asientos FROM vuelos WHERE id = 1;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 1;
SELECT cantidad_asientos FROM vuelos WHERE id = 1;
COMMIT;

-- Cambiar a vuelo 3
BEGIN;
UPDATE detalle_boletos SET vuelos_fk = 3 WHERE pasajeros_rut_fk = '5444744-4';
UPDATE vuelos SET cantidad_asientos = cantidad_asientos + 1 WHERE id = 1;
SELECT cantidad_asientos FROM vuelos WHERE id = 1;
SELECT cantidad_asientos FROM vuelos WHERE id = 3;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 3;
SELECT cantidad_asientos FROM vuelos WHERE id = 3;
COMMIT;

-- Compra de 5 vuelos más
BEGIN;
INSERT INTO detalle_boletos(vuelos_fk, pasajeros_rut_fk) VALUES(1, '9856542-8');
SELECT cantidad_asientos FROM vuelos WHERE id = 1;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 1;
SELECT cantidad_asientos FROM vuelos WHERE id = 1;
COMMIT;

BEGIN;
INSERT INTO detalle_boletos(vuelos_fk, pasajeros_rut_fk) VALUES(2, '9856542-8');
SELECT cantidad_asientos FROM vuelos WHERE id = 2;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 2;
SELECT cantidad_asientos FROM vuelos WHERE id = 2;
COMMIT;

BEGIN;
INSERT INTO detalle_boletos(vuelos_fk, pasajeros_rut_fk) VALUES(5, '5444744-4');
SELECT cantidad_asientos FROM vuelos WHERE id = 5;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 5;
SELECT cantidad_asientos FROM vuelos WHERE id = 5;
COMMIT;

BEGIN;
INSERT INTO detalle_boletos(vuelos_fk, pasajeros_rut_fk) VALUES(3, '7987654-0');
SELECT cantidad_asientos FROM vuelos WHERE id = 3;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 3;
SELECT cantidad_asientos FROM vuelos WHERE id = 3;
COMMIT;

BEGIN;
INSERT INTO detalle_boletos(vuelos_fk, pasajeros_rut_fk) VALUES(4, '17666456-1');
SELECT cantidad_asientos FROM vuelos WHERE id = 4;
UPDATE vuelos SET cantidad_asientos = cantidad_asientos - 1 WHERE id = 4;
SELECT cantidad_asientos FROM vuelos WHERE id = 4;
COMMIT;

-- Suma de ganancia total
SELECT SUM(v.valor) AS total_ganancia FROM vuelos v INNER JOIN detalle_boletos db ON v.id = db.vuelos_fk;

-- Consulta qué vuelos tiene más asientos disponibles
SELECT * FROM vuelos WHERE cantidad_asientos = (SELECT MAX(cantidad_asientos) FROM vuelos);

-- Consulta qué vuelos tiene menos asientos disponibles
SELECT * FROM vuelos WHERE cantidad_asientos = (SELECT MIN(cantidad_asientos) FROM vuelos);
