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
create procedure listas_apellidos_nombres_empleados()
begin
    select concat(apellido1, ' ', apellido2, ', ', nombre) as nombre_completo
    from empleado
    order by apellido1, apellido2, nombre;
end //
delimiter ;

drop procedure listas_apellidos_nombres_empleados;

-- Llamado del procedimiento 

call listas_apellidos_nombres_empleados;

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

-- Llamado del procedimiento 

call lista_nombre_y_presupuesto ;

-- 17. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
-- que tienen menor presupuesto.

delimiter //
create procedure lista_nombre_y_presupuesto_menor()
begin
	select nombre, presupuesto
    from departamento
    order by presupuesto asc 
    limit 3;
end //
delimiter ;

-- Llamado del procedimiento

call lista_nombre_y_presupuesto_menor;

-- 18. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.

delimiter //
create procedure listar_nombre_gasto_2_mayor()
begin
	select nombre, gastos
    from departamento
    order by gastos desc
    limit 2;
end //
delimiter ;

drop procedure listar_nombre_gasto_2_mayor;

-- Llamado del procedimiento

call listar_nombre_gasto_2_mayor;

-- 19. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.

delimiter //
create procedure listar_nombre_gasto_2_menor()
begin
	select nombre, gastos
    from departamento
    order by gastos asc
    limit 2;
end //
delimiter ;

-- Llamado del procedimiento

call listar_nombre_gasto_2_menor;

-- 20. Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
-- tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las
-- columnas de la tabla empleado.

delimiter //
create procedure lista_cinco_filas()
begin
	select *
    from empleado
    limit 5 offset 2;
end //
delimiter ;

-- Llamado del procedimiento

call lista_cinco_filas;

-- 21. Devuelve una lista con el nombre de los departamentos y el presupuesto, de
-- aquellos que tienen un presupuesto mayor o igual a 150000 euros.

delimiter //
create procedure nombre_dep_pres_mayor_o_igual()
begin
	select nombre, presupuesto
    from departamento
    where presupuesto >= 150000;
end //
delimiter ;

-- Llamado del procedimiento

call nombre_dep_pres_mayor_o_igual;

-- 22. Devuelve una lista con el nombre de los departamentos y el gasto, de
-- aquellos que tienen menos de 5000 euros de gastos. 

delimiter //
create procedure nombre_dep_gas_menor_o_igual()
begin
	select nombre, gastos
    from departamento
    where gastos < 5000;
end //
delimiter ;

drop procedure nombre_dep_gas_menor_o_igual;

-- Llamado del procedimiento

call nombre_dep_gas_menor_o_igual;

-- 23. Devuelve una lista con el nombre de los departamentos y el presupuesto, de
-- aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin
-- utilizar el operador BETWEEN.

delimiter //
create procedure nombre_departamentos_presupuestos()
begin
	select nombre, presupuesto
    from departamento 
    where presupuesto >= 100000 and presupuesto <= 200000;
end //
delimiter ;

-- Llamado del procedimiento

call nombre_departamentos_presupuestos;

-- 24. Devuelve una lista con el nombre de los departamentos que no tienen un
-- presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.

delimiter //
create procedure nombre_departamentos_presupuestos_no()
begin 
	select nombre, presupuesto
    from departamento 
    where presupuesto < 100000 or presupuesto > 200000;
end //
delimiter ;

-- Llamado del procedimiento

call nombre_departamentos_presupuestos_no;


-- 25.Devuelve una lista con el nombre de los departamentos que tienen un
-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.

delimiter //
create procedure nombre_departamentos_presupuestos_between()
begin 
	select nombre, presupuesto
    from departamento 
    where presupuesto between 100000 and 200000;
end //
delimiter ;

-- Llamado del procedimiento

call nombre_departamentos_presupuestos_between;

-- 26.Devuelve una lista con el nombre de los departamentos que no tienen un
-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.

delimiter //
create procedure nombre_departamentos_presupuestos_between_no()
begin 
	select nombre, presupuesto
    from departamento 
    where presupuesto not between 100000 and 200000;
end //
delimiter ;

-- Llamado del procedimiento

call nombre_departamentos_presupuestos_between_no;

-- 27. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean mayores
-- que el presupuesto del que disponen.

delimiter //
create procedure gastos_mayores()
begin
	select nombre, gastos, presupuesto
    from departamento
    where gastos > presupuesto;
end //
delimiter ;

-- Llamado del procedimiento

call gastos_mayores;

-- 28. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean menores
-- que el presupuesto del que disponen.

delimiter //
create procedure gastos_menores()
begin
	select nombre, gastos, presupuesto
    from departamento
    where gastos < presupuesto;
end //
delimiter ;

-- Llamado del procedimiento

call gastos_menores;

-- 29. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean iguales al
-- presupuesto del que disponen.

delimiter //
create procedure gastos_iguales()
begin
	select nombre, gastos, presupuesto
    from departamento
    where gastos = presupuesto;
end //
delimiter ;

-- Llamado del procedimiento

call gastos_iguales;

-- 30. Lista todos los datos de los empleados cuyo segundo apellido sea NULL.

delimiter //
create procedure apellido_2_null()
begin
	select *
    from empleado
    where apellido2 is null;
end //
delimiter ;

-- Llamado del procedimiento

call apellido_2_null;

-- 31. Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.

delimiter //
create procedure apellido_2_not_null()
begin
	select *
    from empleado
    where apellido2 is not null;
end //
delimiter ;

-- Llamado del procedimiento

call apellido_2_not_null;

-- 32. Lista todos los datos de los empleados cuyo segundo apellido sea López.

delimiter //
create procedure apellido_2_lopez()
begin
	select *
    from empleado
    where apellido2 = 'lópez';
end //
delimiter ;

-- Llamado del procedimiento

call apellido_2_lopez;

-- 33. Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Sin utilizar el operador IN.

delimiter //
create procedure apellido_2_diaz_moreno()
begin
	select *
    from empleado
    where (apellido2 = 'Díaz') or (apellido2 = 'Moreno');
end //
delimiter ;

drop procedure apellido_2_diaz_moreno;
-- Llamado del procedimiento

call apellido_2_diaz_moreno;

-- 34. Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Utilizando el operador IN.

delimiter //
create procedure apellido_2_diaz_moreno_in()
begin
	select *
    from empleado
    where apellido2 in ('Díaz', 'Moreno');
end //
delimiter ;

-- Llamado del procedimiento

call apellido_2_diaz_moreno_in;


-- 35. Lista los nombres, apellidos y nif de los empleados que trabajan en el
-- departamento 3.

-- 35. Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.

delimiter //
create procedure empleados_departamento_3()
begin
    select nombre, apellido1, apellido2, nif
    from empleado
    where id_departamento = 3;
end //
delimiter ;

-- Llamado del procedimiento

call empleados_departamento_3;

-- 36. Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.

delimiter //
create procedure empleados_departamentos_2_4_5()
begin
    select nombre, apellido1, apellido2, nif
    from empleado
    where id_departamento IN (2, 4, 5);
end //
delimiter ;

-- Llamado del procedimiento

call empleados_departamentos_2_4_5;

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