-- ###############################
-- ## DIA 4 - MySQL 2 - Trabajo ##
-- ###############################

create database trabajo_dia4;

use trabajo_dia4;

show tables;

-- drop table sucursales;

-- Creación de todas la tablas
CREATE TABLE sucursales (
    id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono_fijo VARCHAR(20),
    celular VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    id_sucursal INT,
    cedula VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    celular VARCHAR(20),
    correo_electronico VARCHAR(100),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    celular VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE vehiculos (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    tipo_vehiculo VARCHAR(50) NOT NULL,
    placa VARCHAR(20) NOT NULL,
    referencia VARCHAR(100) NOT NULL,
    modelo INT NOT NULL,
    puertas INT NOT NULL,
    capacidad INT NOT NULL,
    sunroof BOOLEAN NOT NULL,
    motor VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL
);

CREATE TABLE alquileres (
    id_alquiler INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT,
    id_cliente INT,
    id_empleado INT,
    id_sucursal_salida INT,
    fecha_salida DATE NOT NULL,
    id_sucursal_llegada INT,
    fecha_llegada DATE,
    fecha_esperada_llegada DATE NOT NULL,
    valor_alquiler_semana DECIMAL(10, 2) NOT NULL,
    valor_alquiler_dia DECIMAL(10, 2) NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) NOT NULL,
    valor_cotizado DECIMAL(10, 2) NOT NULL,
    valor_pagado DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_sucursal_salida) REFERENCES sucursales(id_sucursal),
    FOREIGN KEY (id_sucursal_llegada) REFERENCES sucursales(id_sucursal)
);



-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004