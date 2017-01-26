set serveroutput on;

--recapitulando lo que es un bloque PL SQL

DECLARE
nombre varchar2(20):='Eduardo Fermin';
begin
dbms_output.put_line('Buenas noches '|| nombre);
end;
/

declare 
edad integer:=21;
dias integer:=365;
res integer;
estatus varchar2(12);

begin

res:=edad*dias;

if dias > 10000
  then
    estatus:='Viejo';
  else
    estatus:='Joven';
end if;
dbms_output.put_line('Tu edad en dias es '|| res
|| ' Estatus: ' || estatus);
end;
/

--veremos nuestro primer PROCEDIMIENTO ALMACENADO

create or replace  procedure saludar (mensaje in varchar2)
as 
begin
dbms_output.put_line('Hola buenas noches '|| mensaje);
end;
/

--ejecutar el procedimiento

exec saludar (' Eduardo Fermin');

--creacion de una secuencia

create sequence  sec_persona
start with 1
increment by 1
nomaxvalue;

--generar la tabla con la secuencia

create table persona(id_persona integer, nombre varchar2(20), edad integer, constraint pk_id_persona primary key (id_persona));
