-- ###################################
-- ## Consultas - MySQL 2 - Trabajo ##
-- ###################################

use trabajo_dia4;

-- • Consulta de disponibilidad de vehículos para alquiler por tipo de vehículo, rango de
-- precios de alquiler y fechas de disponibilidad.
    
select v.id_vehiculo, v.tipo_vehiculo, v.placa, v.referencia, v.modelo, v.color, a.valor_alquiler_semana, a.valor_alquiler_dia
from vehiculos v
left join alquileres a on v.id_vehiculo = a.id_vehiculo
where (a.fecha_salida is null or a.fecha_llegada < CURDATE())
and v.tipo_vehiculo = 'Sedán'
and a.valor_alquiler_semana between 500 and 1000
and curdate() between '2024-06-01' and '2024-06-30';

-- • Alquiler de vehículos.

select *
from alquileres;

-- • Consulta de historial de alquileres.

select a.id_alquiler, v.tipo_vehiculo, v.placa, c.nombres as nombre_cliente, e.nombres as nombre_empleado, s_salida.ciudad as ciudad_salida, a.fecha_salida, s_llegada.ciudad AS ciudad_llegada, a.fecha_llegada, a.valor_pagado
from alquileres a
inner join vehiculos v on a.id_vehiculo = v.id_vehiculo
inner join clientes c on a.id_cliente = c.id_cliente
inner join empleados e on a.id_empleado = e.id_empleado
inner join sucursales s_salida on a.id_sucursal_salida = s_salida.id_sucursal
inner join sucursales s_llegada on a.id_sucursal_llegada = s_llegada.id_sucursal;


-- ******************************** FUNCIONES ************************************

-- Los valores de alquiler dependen del tipo de vehículo (sedán, compacto, camioneta platón,
-- camioneta lujo, deportivo, etc) y se cobran por días y/o semanas. Por ejemplo, si un alquila
-- un vehículo por 9 días, el valor cotizado será de 1 semana y 2 días.

delimiter //

create function calcular_valor_cotizado(tipo_vehiculo varchar(50), dias int)
returns decimal(10,2)
deterministic
begin
    DECLARE valor_semana DECIMAL(10,2);
    DECLARE valor_dia DECIMAL(10,2);
    DECLARE semanas INT;
    declare dias_extras int;
    declare valor_total decimal(10,2);

    select valor_semana, valor_dia into valor_semana, valor_dia
    from vehiculos v
    join alquileres a on v.id_vehiculo = a.id_vehiculo
    where v.tipo_vehiculo = tipo_vehiculo
    limit 1;

    set semanas = floor(dias / 7);
    set dias_extras = dias % 7;

    set valor_total = (semanas * valor_semana) + (dias_extras * valor_dia);

    return valor_total;
end //

delimiter ;

-- Si un cliente entrega el vehículo pasada la fecha de entrega contratada, se cobrarán los días
-- adicionales con un incremento del 8%.

delimiter //

create function calcular_valor_pagado(fecha_devolucion date, fecha_esperada_llegada date, valor_cotizado decimal(10,2), valor_dia decimal(10,2))
returns decimal(10,2)
deterministic
begin
    declare dias_retraso int;
    declare valor_extra decimal(10,2);

    if fecha_devolucion > fecha_esperada_llegada then
        set dias_retraso = datediff(fecha_devolucion, fecha_esperada_llegada);
        set valor_extra = dias_retraso * valor_dia * 1.08;
        return valor_cotizado + valor_extra;
    else
        return valor_cotizado;
    end if;
end //

delimiter ;

-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004