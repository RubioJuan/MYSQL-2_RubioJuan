-- Consultas Avanzadas (Función y procedimiento)

-- 1. Lista el primer apellido de todos los empleados. (función)

delimiter //

create procedure listar_apellido1_empleados()
begin
    select apellido1 from empleado;
end //

delimiter ;

-- Llamado del procedimiento 

call listar_apellido1_empleados();

-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén
-- repetidos.

delimiter // 

create procedure listar_apellido1_unique()
begin 
	select distinct apellido1 from empleado;
end //

delimiter ; 

-- Llamado del procedimiento 

call listar_apellido1_unique();

-- 3. Lista todas las columnas de la tabla empleado.

delimiter //

create procedure listar_all_empleados()
begin 
	select * from empleado;
end //

delimiter ;

-- Llamado del procedimiento 

call listar_all_empleados();

-- 4. Lista el nombre y los apellidos de todos los empleados.

delimiter //

create procedure lista_names_apellidos_employed()
begin 
	select nombre, apellido1, apellido2 from empleado;
end //

delimiter ;

-- Llamado del procedimiento 

call lista_names_apellidos_employed(); 

-- 5. Lista el identificador de los departamentos de los empleados que aparecen
-- en la tabla empleado.

delimiter //

create procedure listar_departamentos_employeds()
begin 
	select distinct id_departamento from empleado where id_departamento is not null;
end //

delimiter ; 

-- Llamado del procedimiento 
call listar_departamentos_employeds();

-- 6. Lista el identificador de los departamentos de los empleados que aparecen
-- en la tabla empleado, eliminando los identificadores que aparecen repetidos.

delimiter //

create procedure listar_departamentos_unicos()
begin
	select distinct id_departamento from empleado where id_departamento is not null;
end //

delimiter ; 

-- Llamado del procedimiento 

call listar_departamentos_unicos();

-- 7. Lista el nombre y apellidos de los empleados en una única columna. 

delimiter //

create procedure listar_nombre_apellidos_onecolumn()
begin 
	select concat(nombre, ' ', apellido1, ' ', ifnull(apellido2, '')) as full_name from empleado;
end //

delimiter ;

-- Llamado del procedimiento 

call listar_nombre_apellidos_onecolumn();

-- 8. Lista el nombre y apellidos de los empleados en una única columna,
-- convirtiendo todos los caracteres en mayúscula.

delimiter //

create procedure listar_nombre_apellidos_mayus()
begin 
	select upper(concat(nombre, ' ', apellido1, ' ', ifnull(apellido2, ''))) as full_name_mayus from empleado;
end //

delimiter ;

drop procedure listar_nombre_apellidos_mayus;

-- Llamado del procedimiento 

call listar_nombre_apellidos_mayus();

-- 9. Lista el nombre y apellidos de los empleados en una única columna,
-- convirtiendo todos los caracteres en minúscula.

delimiter //

create procedure listar_nombre_apellidos_minus()
begin 
	select lower(concat(nombre, ' ', apellido1, ' ', ifnull(apellido2, ''))) as full_name_minus from empleado;
end //

delimiter ;

-- Llamado del procedimiento 

call listar_nombre_apellidos_minus();

-- 10. Lista el identificador de los empleados junto al nif, pero el nif deberá
-- aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la
-- otra la letra.

delimiter //

create procedure listar_id_nif_separado()
begin 
	select id,
			substring(nif, 1, length(nif) - 1)as nif_digit,
            right(nif, 1) as nif_letter
	from empleado;
end // 

delimiter ;

-- Llamado del procedimiento 

call listar_id_nif_separado(); 

-- 11. Lista el nombre de cada departamento y el valor del presupuesto actual del
-- que dispone. Para calcular este dato tendrá que restar al valor del
-- presupuesto inicial (columna presupuesto) los gastos que se han generado
-- (columna gastos). Tenga en cuenta que en algunos casos pueden existir
-- valores negativos. Utilice un alias apropiado para la nueva columna columna
-- que está calculando.

delimiter //

create function calcular_presupuesto_actual(presupuesto double, gastos double)
returns double
deterministic 
begin 
	return presupuesto - gastos;
end // 

delimiter ; 

-- Llamado de la función 

select nombre, 
		calcular_presupuesto_actual(presupuesto, gastos) as presupuesto_actual
from departamento;


-- 12. Lista el nombre de los departamentos y el valor del presupuesto actual
-- ordenado de forma ascendente.

-- Llamado del procedimiento 

select nombre, 
		calcular_presupuesto_actual(presupuesto, gastos) as presupuesto_actual
from departamento
order by presupuesto_actual asc;

-- 13. Lista el nombre de todos los departamentos ordenados de forma
-- ascendente.

delimiter //

create procedure listar_departamentos_asc()
begin 
	select nombre
    from departamento
	order by nombre asc;
end //

delimiter ;

-- Llamado del procedimiento 

call listar_departamentos_asc();

-- 14. Lista el nombre de todos los departamentos ordenados de forma
-- descendente.

delimiter //

create procedure listar_departamentos_desc()
begin 
	select nombre 
	from departamento 
	order by nombre desc;
end //

delimiter ;

-- Llamado del procedimiento 

call listar_departamentos_desc();

-- 15. Lista los apellidos y el nombre de todos los empleados, ordenados de forma
-- alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.

delimiter //

create procedure listas_apelidos_nombres_empleados()
begin
    select apellido1, ' ', apellido2, '', nombre
	from empleado;
end //

delimiter ;

drop procedure listas_apelidos_nombres_empleados;

-- Llamado del procedimiento 

call listas_apelidos_nombres_empleados;

-- 16. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.

delimiter //
create procedure lista_nombre_y_presupuesto()
begin
	select nombre, presupuesto
    from departamento
    order by presupuesto desc 
    limit 3;
end //
delimiter ;

 drop procedure lista_nombre_y_presupuesto;

call lista_nombre_y_presupuesto ;


-- ####################################################
-- ###  Consultas multitabla (Composición interna)  ###
-- ####################################################

-- 1. Devuelve un listado con todos los empleados junto con los datos de los
-- departamentos donde trabajan. Este listado también debe incluir los
-- empleados que no tienen ningún departamento asociado.

delimiter //

create procedure listar_empleados_departamentos()
begin
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    left join departamento d on e.id_departamento = d.id;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_departamentos
call listar_empleados_departamentos();

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no
-- tienen ningún departamento asociado.

delimiter //

create procedure listar_empleados_sin_departamento()
begin
    select e.*
    from empleado e
    left join departamento d on e.id_departamento = d.id
    where d.id is null;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_sin_departamento
call listar_empleados_sin_departamento();

-- 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no
-- tienen ningún empleado asociado.

delimiter //

create procedure listar_departamentos_sin_empleados()
begin
    select d.*
    from departamento d
    left join empleado e on d.id = e.id_departamento
    where e.id is null;
end //

delimiter ;

-- Llamado al procedimiento listar_departamentos_sin_empleados
call listar_departamentos_sin_empleados();

-- 4. Devuelve un listado con todos los empleados junto con los datos de los
-- departamentos donde trabajan. El listado debe incluir los empleados que no
-- tienen ningún departamento asociado y los departamentos que no tienen
-- ningún empleado asociado. Ordene el listado alfabéticamente por el
-- nombre del departamento.

delimiter //

create procedure listar_empleados_departamentos_completo()
begin
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    left join departamento d on e.id_departamento = d.id
    
    union
    
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    right join departamento d on e.id_departamento = d.id
    order by nombre_departamento;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_departamentos_completo
call listar_empleados_departamentos_completo();

-- 5. Devuelve un listado con los empleados que no tienen ningún departamento
-- asociado y los departamentos que no tienen ningún empleado asociado.
-- Ordene el listado alfabéticamente por el nombre del departamento.

delimiter //

create procedure listar_empleados_departamentos_no_asociados()
begin
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    left join departamento d on e.id_departamento = d.id
    where d.id is null
    
    union
    
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    right join departamento d on e.id_departamento = d.id
    where e.id is null
    order by nombre_departamento;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_departamentos_no_asociados
call listar_empleados_departamentos_no_asociados();

-- 6. Devuelve el nombre del departamento donde trabaja el empleado 
-- Pepe Ruiz Santana.

delimiter //

create function obtener_departamento_pepe_ruiz_santana()
returns varchar(100) deterministic
begin
    declare depto_nombre varchar(100);
    select d.nombre into depto_nombre
    from empleado e
	join departamento d on e.id_departamento = d.id
    where e.nombre = 'Pepe' and e.apellido1 = 'Ruiz' and e.apellido2 = 'Santana';
    return depto_nombre;
end //

delimiter ;

drop function obtener_departamento_pepe_ruiz_santana;

-- Llamado a la función obtener_departamento_pepe_ruiz_santana
select obtener_departamento_pepe_ruiz_santana() as departamento_pepe_ruiz_santana;

-- 7. Devuelve un listado con los datos de los empleados que trabajan en el
-- departamento de I+D. Ordena el resultado alfabéticamente.

delimiter //

create procedure listar_empleados_id()
begin
    select e.*
    from empleado e
    join departamento d on e.id_departamento = d.id
    where d.nombre = 'I+D'
    order by e.nombre, e.apellido1, e.apellido2;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_id
call listar_empleados_id();

-- 8. Devuelve un listado con los datos de los empleados que trabajan en el
-- departamento de Sistemas, Contabilidad o I+D. Ordena el resultado
-- alfabéticamente.

delimiter //

create procedure listar_empleados_departamentos_especificos()
begin
    select e.*
    from empleado e
    join departamento d on e.id_departamento = d.id
    where d.nombre in ('Sistemas', 'Contabilidad', 'I+D')
    order by e.nombre, e.apellido1, e.apellido2;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_departamentos_especificos
call listar_empleados_departamentos_especificos();

-- 9. Devuelve una lista con el nombre de los empleados que tienen los
-- departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

delimiter //

create procedure listar_empleados_departamentos_presupuesto_no_rango()
begin
    select e.nombre, e.apellido1, e.apellido2
    from empleado e
    join departamento d on e.id_departamento = d.id
    where d.presupuesto not between 100000 and 200000;
end //

delimiter ;

-- Llamado al procedimiento listar_empleados_departamentos_presupuesto_no_rango
call listar_empleados_departamentos_presupuesto_no_rango();

-- 10. Devuelve un listado con el nombre de los departamentos donde existe
-- algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no
-- debe mostrar nombres de departamentos que estén repetidos.

delimiter //

create PROCEDURE listar_departamentos_empleados_sin_apellido2()
begin
    select distinct d.nombre
    from departamento d
    join empleado e on d.id = e.id_departamento
    where e.apellido2 is null;
end //

delimiter ;

-- Llamado al procedimiento listar_departamentos_empleados_sin_apellido2
call listar_departamentos_empleados_sin_apellido2();
