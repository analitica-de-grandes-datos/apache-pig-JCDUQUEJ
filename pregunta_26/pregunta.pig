/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

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
            fecha:chararray,
            color:chararray,
            numero:int
        );

specific_columns = FOREACH Datos GENERATE nombre;

filtrado = FILTER specific_columns BY SUBSTRING(nombre,1,0) >= '.*M.*';

STORE filtrado INTO 'output';
