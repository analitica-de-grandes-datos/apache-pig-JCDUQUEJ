/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
Datos = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
            columna1:chararray,
            columna2:chararray,
            columna3:chararray
        );

words = FOREACH Datos GENERATE REPLACE(REPLACE(columna2,'\\}',''),'\\{','') as col2;

letras = FOREACH words GENERATE FLATTEN(TOKENIZE(col2)) AS word;

grouped = GROUP letras BY word;

wordcount = FOREACH grouped GENERATE group, COUNT(letras);

STORE wordcount INTO 'output' USING PigStorage(',');