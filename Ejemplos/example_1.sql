-- ********************************
-- ****   EJEMPLO DE TRIGGER  *****
-- ********************************

create database chuzo;

use chuzo;

create table producto(
	id int primary key not null auto_increment,
    nombre varchar(20)not null,
    costo float not null default (0.0),
    precio float not null default (0.0)
);

insert into producto (nombre, costo, precio) values 
('Papa loca', 50, 100),('Hamburguesa',30,50),('Carne asada',25,60);

select * from producto;

delimiter //
create trigger update_precio
before update on producto
for each row
begin 
	if new.costo <> old.costo
		then
        set new.precio = new.costo * 2;
	end if ;
end//
delimiter ;

update producto set costo = 80 where id =1;

select * from producto;