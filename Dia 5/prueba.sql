-- ###############################
-- ## DIA 5 - MySQL 2 - Trabajo ##
-- ###############################

use `world`;

select * from country;
select * from city;

-- Trigger para insertar o actualizar una ciudad en un país con la nueva población
delimiter //
create trigger after_city_insert_update
after insert on city
for each row 
begin 
	update country
    set Population = Population + new.Population
    where code = new.countryCode;
end // 
delimiter ;

-- Test
insert into city (Name,CountryCode,District,Population)
values ("Artemis","AFG","Piso 6",1250000);

-- Trigger para eliminar una ciudad en un país con la nueva población
delimiter //
create trigger after_city_insert_update
after delete on city
for each row 
begin 
	update country
    set Population = Population - old.Population
    where code = old.countryCode;
end // 
delimiter ;

select * from city where Name = "Artemis";
delete from city where ID=4080;

-- Crea una tabla para auditoria de ciudad
create table if not exists city_audit(
	audit_id int auto_increment primary key,
    city_id int,
    action varchar(10),
    old_population int,
    new_population int,
    change_time timestamp default current_timestamp
);

-- Trigger para auditoria de ciudades cuando se inserta
delimiter //
create trigger after_city_insert_audit
after insert on city
for each row
begin
	insert into city_audit(city_id, action, new_population)
    values (new.ID,'INSERT',new.Population);
end //
delimiter ;

-- Test
select * from city_audit;
insert into city (Name,CountryCode,District,Population)
values ("Artemis","AFG","Piso 6",1250000);

-- Trigger para auditoria de ciudades cuando se inserta
delimiter //
create trigger after_city_insert_audit
after update on city
for each row
begin
	insert into city_audit(city_id,action,old_population,new_population)
    values (old.ID,'UPDATE',old.Population,new.Population);
end //
delimiter ;

-- Test
update city set Population = 1550000 where ID=4081;
select * from city_audit;

-- Eventos
-- Creación de la tabla para BK de ciudades
create table if not exists city_backup(
	ID int not null,
    Name char(35) not null,
    CountryCode char(3) not null,
    District char(20) not null,
    Population int not null,
    primary key (ID)
) engine=InnoDB default charset=utf8mb4;

create event if not exists weekly_city_backup
on schedule every 1 week
Do
begin
    truncate table city_backup;
    insert into city_backup(ID,Name,CountryCode,District,Population)
    select ID,Name,CountryCode,District,Population from city;
end //
delimiter ;

-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004