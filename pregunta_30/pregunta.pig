/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Datos = LOAD 'data.csv' USING PigStorage(',')
        AS (
            posicion:int,
            nombre:chararray,
            apellido:chararray,
            fecha:datetime,
            color:chararray,
            numero:int
        );

selected_data = FOREACH Datos GENERATE ToString(fecha,'yyyy-MM-dd') AS fecha, ToString(fecha,'dd') AS dia1, GetDay(fecha) AS dia2, LOWER(ToString(fecha,'EEE')) AS dia3, LOWER(ToString(fecha,'EEEE')) AS dia4;
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'mon','lun'), REPLACE(dia4,'monday','lunes');
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'tue','mar'), REPLACE(dia4,'tuesday','martes');
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'wed','mie'), REPLACE(dia4,'wednesday','miercoles');
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'thu','jue'), REPLACE(dia4,'thursday','jueves');
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'fri','vie'), REPLACE(dia4,'friday','viernes');
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'sat','sab'), REPLACE(dia4,'saturday','sabado');
selected_data = FOREACH selected_data GENERATE fecha, dia1, dia2, REPLACE(dia3,'sun','dom'), REPLACE(dia4,'sunday','domingo');

STORE selected_data INTO 'output' USING PigStorage(',');