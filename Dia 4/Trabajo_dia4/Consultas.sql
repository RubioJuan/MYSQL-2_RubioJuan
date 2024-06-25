-- ###################################
-- ## Consultas - MySQL 2 - Trabajo ##
-- ###################################

use trabajo_dia4;

-- • Consulta de disponibilidad de vehículos para alquiler por tipo de vehículo, rango de
-- precios de alquiler y fechas de disponibilidad.

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

-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004