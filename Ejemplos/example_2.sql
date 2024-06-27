-- ********************************
-- ****   EJEMPLO DE TRIGGER  *****
-- ********************************

create database empresa;

use empresa;

create table empleados(
	id int auto_increment primary key,
    nombre varchar(100),
    puesto varchar(100),
    salario decimal(10,2)
);

create table log_empleados(
	id int auto_increment primary key, 
    empleado_id int,
    accion varchar(50),
    fecha timestamp default current_timestamp,
	foreign key (empleado_id) references empleados(id)
);

drop table log_empleados;

-- Trigger de insertar
-- Supongamos que tienes una tabla llamada empleados y quieres crear un trigger que se active 
-- después de una inserción para registrar el evento en una tabla log_empleados.
delimiter //
create trigger after_empleados_insert
after insert on empleados
for each row
begin
	insert into log_empleados (empleado_id, accion)
    values (new.id,'INSERT');
end //
delimiter ;

-- Trigger de actualizar
-- Este trigger se activará después de una actualización en la tabla empleados y registrará el cambio en log_empleados.
delimiter //
create trigger after_empleados_update
after update on empleados
for each row
begin
	insert into log_empleados (empleado_id, accion)
    values (new.id,'UPDATE');
end //
delimiter ;

-- Trigger de eliminar
-- Este trigger se activará antes de una eliminación en la tabla empleados y registrará el evento en log_empleados.
delimiter //
create trigger before_empleados_delete
before delete on empleados
for each row
begin
	insert into log_empleados (empleado_id, accion)
    values (old.id,'DELETE');
end //
delimiter ;

-- Explicación de los componentes:

-- DELIMITER: Cambia el delimitador para que MySQL no interprete el ; dentro del cuerpo del trigger como el final de la instrucción.

-- CREATE TRIGGER: Define un nuevo trigger con un nombre (after_empleados_insert, after_empleados_update, before_empleados_delete).

-- AFTER INSERT, AFTER UPDATE, BEFORE DELETE: Especifica cuándo se debe ejecutar el trigger.

-- FOR EACH ROW: Indica que el trigger se ejecuta para cada fila afectada.

-- BEGIN ... END: Delimita el cuerpo del trigger.

-- NEW: Hace referencia a los valores nuevos en una operación INSERT o UPDATE.

-- OLD: Hace referencia a los valores antiguos en una operación DELETE.
