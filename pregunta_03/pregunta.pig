/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
Datos = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letra:chararray,
                eventDate:chararray,
                quantity:int
        );

ordered_data = ORDER Datos BY quantity asc;

resultado = LIMIT ordered_data 5;

specific_columns = FOREACH resultado GENERATE quantity;

STORE specific_columns INTO 'output' USING PigStorage(',');