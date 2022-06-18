/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/
Datos = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letra:chararray,
                eventDate:chararray,
                quantity:int
        );


ordered_data = ORDER datos BY (letra, quantity);

STORE wordcount INTO 'output' USING PigStorage(',');