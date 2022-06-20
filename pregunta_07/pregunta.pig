/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

Datos = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
            columna1:chararray,
            columna2:BAG{},
            columna3:MAP[]
        );


data = FOREACH Datos GENERATE columna1, SIZE(columna2) AS col2, SIZE(columna3) AS col3;

ordered_data = ORDER data BY columna1 ASC, col2 ASC, col3 ASC;

STORE ordered_data INTO 'output' USING PigStorage(',');
