-- ###################
-- ###  Consultas  ###
-- ###################

use dia1;

### 1. Número de pacientes atendidos por cada médico

select medico.id_medico, medico.nombre, count(paciente.id_paciente) as num_pacientes
from medico
left join paciente on medico.id_medico = paciente.id_medico
group by  medico.id_medico, medico.nombre;

### 2. Total de días de vacaciones planificadas y disfrutadas por cada empleado

select empleado.id_empleado, empleado.nombre, 
sum(datediff(vacacion.fecha_fin, vacacion.fecha_inicio) + 1) as total_dias_vacaciones
from empleado
inner join  vacacion on empleado.id_empleado = vacacion.id_empleado
group by empleado.id_empleado, empleado.nombre;

### 3. Médicos con mayor cantidad de horas de consulta en la semana

select medico.id_medico, medico.nombre, sum(timediff(consulta.horario, '00:00:00')) as horas_totales -- Timediff devuelve la diferencia entre dos marcas de tiempo medida en unidades unit 
from medico inner join consulta ON medico.id_medico = consulta.id_medico
group by  medico.id_medico, medico.nombre
order by horas_totales DESC
limit 1;

### 4. Número de sustituciones realizadas por cada médico sustituto

select medico.id_medico, medico.nombre, count(sustitucion.id_sustitucion) AS num_sustituciones
from medico
inner join sustitucion on medico.id_medico = sustitucion.id_medico
group by medico.id_medico, medico.nombre;

### 5. Número de médicos que están actualmente en sustitución

select count(distinct sustitucion.id_medico) as num_medicos_en_sustitucion
from sustitucion
where sustitucion.fecha_baja is null or sustitucion.fecha_alta > sustitucion.fecha_baja;

### 6. Horas totales de consulta por médico por día de la semana

select consulta.id_medico, medico.nombre, consulta.dia_Semana, 
sum(timediff(consulta.horario, '00:00:00')) AS horas_totales
from consulta -- Timediff devuelve la diferencia entre dos marcas de tiempo medida en unidades unit 
inner join medico on consulta.id_medico = medico.id_medico
group by consulta.id_medico, medico.nombre, consulta.dia_Semana;

### 7. Médico con mayor cantidad de pacientes asignados

select medico.id_medico, medico.nombre, 
    count(paciente.id_paciente) as num_pacientes
from medico
inner join paciente on medico.id_medico = paciente.id_medico
group by medico.id_medico, medico.nombre
order by num_pacientes desc
limit 1;

### 8. Empleados con más de 10 días de vacaciones disfrutadas

select empleado.id_empleado, empleado.nombre, 
sum(datediff(vacacion.fecha_fin, vacacion.fecha_inicio) + 1) as total_dias_vacaciones -- Datefiff sirve para determinar cuántos intervalos de tiempo especificados existen entre dos fechas.
from empleado
inner join vacacion on empleado.id_empleado = vacacion.id_empleado
group by empleado.id_empleado, empleado.nombre
having total_dias_vacaciones > 10;

### 9. Médicos que actualmente están realizando una sustitución

select medico.id_medico, medico.nombre
from medico
inner join sustitucion on medico.id_medico = sustitucion.id_medico
where sustitucion.fecha_baja is null or sustitucion.fecha_alta > sustitucion.fecha_baja;

### 10. Promedio de horas de consulta por médico por día de la semana

select consulta.dia_Semana, avg(TIMEDIFF(consulta.horario, '00:00:00')) as promedio_horas
from consulta group by consulta.dia_Semana; -- avg devuelve el promedio de todos los valores de ese campo o expresión.

-- Desarrollado por Juan Felipe Rubio Sanabria / ID.1.146.334.004