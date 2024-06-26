-- *********************************** TRIGGER *******************************

-- Uso de la base de datos
USE trabajo_dia4;

-- Mostrar las tablas creadas
SHOW TABLES;

-- Trigger para actualizar la disponibilidad de vehículos después de insertar un alquiler
DELIMITER //
CREATE TRIGGER after_alquiler_insert
AFTER INSERT ON alquileres
FOR EACH ROW
BEGIN
    UPDATE vehiculos
    SET disponibilidad = FALSE
    WHERE id_vehiculo = NEW.id_vehiculo;
END //
DELIMITER ;

-- Trigger para actualizar la disponibilidad de vehículos después de eliminar un alquiler
DELIMITER //
CREATE TRIGGER after_alquiler_delete
AFTER DELETE ON alquileres
FOR EACH ROW
BEGIN
    UPDATE vehiculos
    SET disponibilidad = TRUE
    WHERE id_vehiculo = OLD.id_vehiculo;
END //
DELIMITER ;

-- Crear una tabla de auditoría para los alquileres
CREATE TABLE IF NOT EXISTS alquileres_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT,
    accion VARCHAR(10),
    id_cliente INT,
    id_vehiculo INT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para auditar la inserción de un alquiler
DELIMITER //
CREATE TRIGGER after_alquiler_insert_audit
AFTER INSERT ON alquileres
FOR EACH ROW
BEGIN
    INSERT INTO alquileres_audit (id_alquiler, accion, id_cliente, id_vehiculo)
    VALUES (NEW.id_alquiler, 'INSERT', NEW.id_cliente, NEW.id_vehiculo);
END //
DELIMITER ;

-- Trigger para auditar la actualización de un alquiler
DELIMITER //
CREATE TRIGGER after_alquiler_update_audit
AFTER UPDATE ON alquileres
FOR EACH ROW
BEGIN
    INSERT INTO alquileres_audit (id_alquiler, accion, id_cliente, id_vehiculo)
    VALUES (OLD.id_alquiler, 'UPDATE', OLD.id_cliente, OLD.id_vehiculo);
END //
DELIMITER ;

-- Evento para realizar un respaldo semanal de la tabla de vehículos
DELIMITER //
CREATE EVENT IF NOT EXISTS weekly_vehiculos_backup
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    CREATE TABLE IF NOT EXISTS vehiculos_backup (
        id_vehiculo INT NOT NULL,
        tipo_vehiculo VARCHAR(50) NOT NULL,
        placa VARCHAR(20) NOT NULL,
        referencia VARCHAR(100) NOT NULL,
        modelo INT NOT NULL,
        puertas INT NOT NULL,
        capacidad INT NOT NULL,
        sunroof BOOLEAN NOT NULL,
        motor VARCHAR(50) NOT NULL,
        color VARCHAR(50) NOT NULL,
        PRIMARY KEY (id_vehiculo)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

    TRUNCATE TABLE vehiculos_backup;
    INSERT INTO vehiculos_backup
    SELECT * FROM vehiculos;
END //
DELIMITER ;

-- ******************************************* Prueba *********************************************

-- Agregar la columna disponibilidad a la tabla vehiculos
ALTER TABLE vehiculos
ADD COLUMN disponibilidad BOOLEAN DEFAULT TRUE;

-- Verificar que la columna se ha agregado correctamente
DESCRIBE vehiculos;

-- Prueba del trigger after_alquiler_insert
-- Insertar un nuevo vehículo
INSERT INTO vehiculos (tipo_vehiculo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color, disponibilidad)
VALUES ('SUV', 'ABC123', 'Toyota RAV4', 2022, 4, 5, TRUE, '2.5L', 'Rojo', TRUE);

-- Insertar un nuevo cliente
INSERT INTO clientes (cedula, nombres, apellidos, direccion, ciudad_residencia, celular, correo_electronico)
VALUES ('1234567890', 'Juan', 'Pérez', 'Calle Falsa 123', 'Ciudad', '0987654321', 'juan.perez@example.com');

-- Insertar un nuevo empleado
INSERT INTO empleados (id_sucursal, cedula, nombres, apellidos, direccion, ciudad_residencia, celular, correo_electronico)
VALUES (1, '9876543210', 'María', 'López', 'Avenida Siempre Viva 456', 'Ciudad', '0912345678', 'maria.lopez@example.com');

-- Insertar un nuevo alquiler
INSERT INTO alquileres (id_vehiculo, id_cliente, id_empleado, id_sucursal_salida, fecha_salida, id_sucursal_llegada, fecha_esperada_llegada, valor_alquiler_semana, valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado)
VALUES (1, 1, 1, 1, '2023-06-01', 1, '2023-06-07', 1000.00, 150.00, 10.00, 900.00, 900.00);

-- Verificar si la disponibilidad del vehículo se actualizó correctamente
SELECT * FROM vehiculos WHERE id_vehiculo = 1;

-- Prueba del trigger after_alquiler_delete
-- Eliminar el alquiler
DELETE FROM alquileres WHERE id_alquiler = 1;

-- Prueba del trigger after_alquiler_insert_audit
-- Insertar un nuevo alquiler
INSERT INTO alquileres (id_vehiculo, id_cliente, id_empleado, id_sucursal_salida, fecha_salida, id_sucursal_llegada, fecha_esperada_llegada, valor_alquiler_semana, valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado)
VALUES (1, 1, 1, 1, '2023-06-01', 1, '2023-06-07', 1000.00, 150.00, 10.00, 900.00, 900.00);

-- Prueba del trigger after_alquiler_update_audit
-- Actualizar el alquiler
UPDATE alquileres SET fecha_llegada = '2023-06-06' WHERE id_alquiler = 2;

-- Verificar si se agregó un registro en la tabla de auditoría
SELECT * FROM alquileres_audit;

