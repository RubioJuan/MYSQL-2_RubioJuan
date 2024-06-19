-- #####################
-- ###   DÍA  # 1    ###
-- #####################

create database dia1;

use dia1;

create table medico(
	id_medico INT primary key,
    nombre VARCHAR(255) not null,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    poblacion VARCHAR(100),
    provincia VARCHAR(100),
    codigo_postal VARCHAR(10),
    nif VARCHAR(20) unique not null,
    num_seguridad_social VARCHAR(20) unique not null,
    num_colegiado VARCHAR(20) unique not null,
    tipo ENUM('Titular','Interino','Sustituto') not null
);
-- ALTER TABLE medico RENAME COLUMN problacion TO poblacion;
-- select * from medico;


create table empleado(
	id_empleado INT primary key,
    nombre VARCHAR(255) not null,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    poblacion VARCHAR(100),
    provincia VARCHAR(100),
    codigo_postal VARCHAR(10),
    nif VARCHAR(20) unique not null,
    num_seguridad_social VARCHAR(20) unique not null,
    tipo ENUM('ATS','ATS de zona','Auxiliar de enfermeria','Celador','Administrativo') not null
);

create table paciente(
	id_paciente INT primary key,
    nombre VARCHAR(255) not null,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    codigo_postal VARCHAR(10),
    nif VARCHAR(20) unique not null,
    num_seguridad_social VARCHAR(20) unique not null,
    id_medico INT,
    foreign key (id_medico)references medico(id_medico)
);

create table consulta(
	id_consulta INT primary key,
    id_medico INT,
    dia_Semana ENUM('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo') not null,
    horario TIME not null,
    foreign key(id_medico)references medico(id_medico)
);

create table sustitucion(
	id_sustitucion INT primary key,
    id_medico INT,
    fecha_alta DATE not null,
    fecha_baja DATE,
    foreign key (id_medico)references medico(id_medico)
);

create table vacacion(
	id_vacacion INT primary key,
    id_empleado INT,
	id_medico INT,
    fecha_inicio DATE not null,
    fecha_fin DATE not null,
    foreign key(id_empleado)references empleado(id_empleado),
    foreign key(id_medico)references medico(id_medico)
);

show tables;

-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004