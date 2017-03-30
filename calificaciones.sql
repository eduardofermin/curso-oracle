create table alumno(num_cuenta integer, nombre varchar2(25), paterno varchar2(25), constraint pk_num_cuenta primary key(num_cuenta));

create table materia (id_materia integer, nombre varchar2(120), constraint pk_id_materia primary key(id_materia));

create table evaluacion (num_cuenta integer, id_materia integer, calificacion float, estatus char, constraint fk1_num_cuenta foreign key (num_cuenta) references alumno(num_cuenta),
constraint fk2_id_materia foreign key (id_materia) references materia(id_materia));

create sequence sec_materia
start with 1
increment by 1
nomaxvalue;

create or replace procedure guardar_materia(my_id_materia out integer, my_nombre in varchar2)
as
begin
select sec_materia.nextval into my_id_materia from dual;
insert into materia values (my_id_materia, my_nombre);
end;
/

insert into alumno values (123,'juan','torres');
insert into alumno values (456,'daniela','meza');
insert into alumno values (789,'armando','cardenas');

declare
valor integer;
begin
guardar_materia(valor,'base de datos II');
guardar_materia(valor,'negocios electronicos');
guardar_materia(valor,'metodologia estructurada');
end;
/

create or replace trigger disp_evaluacion before insert on evaluacion for each row
begin

if :new.estatus!='a' or :new.estatus!=r then
RAISE_APPLICATION_ERROR(-20000, 'el estatus no es el correcto');
else
insert into evaluacion values (:new.calificacion, :new.estatus); 
end if;

if :new.calificacion>6 and :new.calificacion <10 then
insert into evaluacion values (:new.calificacion, :new.estatus); 
else 
RAISE_APPLICATION_ERROR(-20000, 'la calificacion es incorrecta');
end if;
end;
/
