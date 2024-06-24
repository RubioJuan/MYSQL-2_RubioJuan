-- ##############################
-- ###### DIA 4 - MySQL 2  ######
-- ##############################

create database mysql2_dia4;
use mysql2_dia4;

-- Creación de usuario camper con acceso desde cualquier parte 
create user 'camper'@'%' identified by 'campus2023';

-- Revisar permisos de x usuario
show grants for 'camper'@'%';

-- Crear una tabla de personas 
create table persona (id int primary key, nombre varchar(255),apellido varchar (255));
insert into persona (id,nombre,apellido) values (1,'Juan','Perez');
insert into persona (id,nombre,apellido) values (2,'Andres','Pastrana');
insert into persona (id,nombre,apellido) values (3,'Pedro','Gómez');
insert into persona (id,nombre,apellido) values (4,'Camilo','Gonzalez');
insert into persona (id,nombre,apellido) values (5,'Stiven','Maldonado');
insert into persona (id,nombre,apellido) values (6,'Ardila','Perez');
insert into persona (id,nombre,apellido) values (7,'Ruben','Gómez');
insert into persona (id,nombre,apellido) values (8,'Andres','Portilla');
insert into persona (id,nombre,apellido) values (9,'Miguel','Carvajal');
insert into persona (id,nombre,apellido) values (10,'Andrea','Gómez');

-- Asignar permisos a x usuario para que accedaa la tabla persona de la base de datos
grant select on mysql2_dia4.persona to 'camper'@'%'; 

-- Refrescar permisos de la BBDD
flush privileges;

-- Añadir permisos para hacer un crud
grant update, insert, delete on mysql2_dia4.persona to 'camper'@'%';

-- Crear un limite para que solamente se hagan x consultas por hora
alter user 'camper'@'%' with max_queries_per_hour 5;

flush privileges; -- Este codigo sirve es para actualizar el sistema

-- Revisar los limites o permisos que tiene un usuario a nivel de motor
select * from mysql.user where host='%';

-- Revocar todos los permisos de camper
revoke all on *.* from 'camper' @'%';

-- Solo poner permisos para que consulte una x base de datos,
-- una y tabla Y una Z columna
grant select(nombre) on mysql2_dia4.persona to 'camper'@'%';

-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004