/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
Datos = LOAD 'data.tsv' USING PigStorage('   ')
        AS (
                letra:chararray,
                eventDate:chararray,
                quantity:int
        );

-- genera una tabla llamada words con una palabra por registro
words = FOREACH Datos GENERATE quantity AS word;

ordered_data = ORDER words BY quantity asc;

resultado = LIMIT ordered_data 5;

STORE resultado INTO 'output' USING PigStorage(',');