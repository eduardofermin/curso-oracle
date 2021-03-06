set serveroutput on;

create table trabajador(seguro_social integer, nombre varchar2(25), edad integer, constraint pk_trabajador primary key (seguro_social));

--creacion de la segunda tabla
create table nomina(id_nomina integer, seguro_social integer, sueldo_base float, horas_laboradas integer, fecha_pago date, constraint pk_id_nomina primary key(id_nomina), constraint 
fk1_seguro_social foreign key (seguro_social) references trabajador(seguro_social));

--creacion de secuencia para la nomina
create sequence sec_nomina
start with 1
increment by 1
nomaxvalue;

--creacion del procedimiento de nomina
create or replace procedure guardar_nomina(my_id_nomina out integer, my_seguro_social in integer, my_sueldo_base in float)
as
begin
select sec_nomina.nextval into my_id_nomina from dual;
insert into nomina (id_nomina, seguro_social, sueldo_base) values (my_id_nomina, my_seguro_social, my_sueldo_base);
end;
/

--creacion del procedimiento para trabajador 
create or replace procedure generar_trabajador(my_seguro_social in integer, my_nombre in varchar2, my_edad in integer, my_id_nomina out integer, my_sueldo_base in float)
as
begin
insert into trabajador values(my_seguro_social, my_nombre, my_edad);
guardar_nomina(my_id_nomina, my_seguro_social, my_sueldo_base);
end;
/

--insertar datos en las tablas
declare
valor integer;
begin
generar_trabajador(1,'ana',28,valor,6000);
generar_trabajador(2,'pedro',40,valor,7000);
generar_trabajador(3,'karla',28,valor,8000);
generar_trabajador(4,'juan',28,valor,10000);
end;
/

--estructura de cursor basico
declare 
cursor cur1 is select * from trabajador;
cursor cur2 is select * from nomina;
begin
for rec in cur1 loop
for rec2 in cur2 loop
if rec2.seguro_social=rec.seguro_social then
dbms_output.put_line('nombre: '||rec.nombre||' edad: '||rec.edad || ' sueldo base' || rec2.sueldo_base);
end if;
end loop;
end loop;
end;
/

--cursores con update(para cambios masivos)
--los cursores tambine hacen cambios masios
declare
cursor cur3 is select *from nomina for update;
begin 
for i in cur3 loop
update nomina set horas_laboradas=40 where current of cur3;
end loop;
end;
/

--esto no va

update nomina set horas_laboradas=40 where id_nomna=1 and id_nomna=2 and id_nomna=3 and id_nomna=4;

select * from nomina;

select trabajador.nombre, trabajador.edad, nomina.sueldo_base from trabajador inner join nomina on trabajador.seguro_social=nomina.seguro_social;
