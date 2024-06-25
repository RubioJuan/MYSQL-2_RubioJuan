use trabajo_dia4;

-- **************************************** EMPLEADO ************************************

create user 'empleado'@'%' identified by 'empleado123';

grant select, insert, update on trabajo_dia4.vehiculos to 'empleado'@'%';

grant select, update on trabajo_dia4.alquileres to 'empleado'@'%';

-- **************************************** ADMINISTRADOR ************************************

create user 'administrador'@'%' identified by 'admin123'; 

grant update,select,insert,delete on trabajo_dia4.* to 'administrador'@'%';

-- ****************************************** CLIENTE *****************************************

create user 'cliente'@'%' identified by 'cliente123'; 

grant select on trabajo_dia4.vehiculos to 'cliente'@'%';

grant select on trabajo_dia4.alquileres to 'cliente'@'%';

-- administrador puede hacer todo
-- empleado puede visualizar vehiculos y agregarar vehiculos en la tabla de alquiler
-- cliente visualiza la tabla de vehiculos y aquileres 

-- funciones 
-- el empleado puede editar un alquiler, tambien verlo y puede ver lo vehiculos que hay


-- ******************************** FALTA ************************************

-- Los valores de alquiler dependen del tipo de vehículo (sedán, compacto, camioneta platón,
-- camioneta lujo, deportivo, etc) y se cobran por días y/o semanas. Por ejemplo, si un alquila
-- un vehículo por 9 días, el valor cotizado será de 1 semana y 2 días.

-- Si un cliente entrega el vehículo pasada la fecha de entrega contratada, se cobrarán los días
-- adicionales con un incremento del 8%.