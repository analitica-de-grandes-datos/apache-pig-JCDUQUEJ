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

specific_column = FOREACH Datos GENERATE columna2;

letras = FOREACH specific_column GENERATE FLATTEN(TOKENIZE(specific_column)) AS word;



DUMP letras;