/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta en SQL.

   SELECT
       color
   FROM 
       u 
   WHERE 
       color 
   LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */

Datos = LOAD 'data.csv' USING PigStorage(',')
        AS (
            posicion:int,
            nombre:chararray,
            apellido:chararray,
            fecha:chararray,
            color:chararray,
            numero:int
        );

select_color = FOREACH Datos GENERATE color;

color_b = FILTER select_color BY ($0 MATCHES '.*b.*');

STORE color_b INTO 'output';