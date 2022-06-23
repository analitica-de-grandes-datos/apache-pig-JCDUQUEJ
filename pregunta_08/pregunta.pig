/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

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

lineas = FOREACH Datos GENERATE REPLACE(REPLACE(columna2,'\\}',''),'\\{','') AS col2,REPLACE(REPLACE(columna3,'\\]',''),'\\[','') AS col3;

subtuplas = FOREACH lineas GENERATE FLATTEN(TOKENIZE(col2)) AS word1, col3;

subtuplas2 = FOREACH subtuplas GENERATE word1, FLATTEN(TOKENIZE(col3)) AS word2;

tuplas = FOREACH subtuplas2 GENERATE (word1, SUBSTRING(word2,0,3)) AS clave;

grouped = GROUP tuplas BY clave;

wordcount = FOREACH grouped GENERATE group, COUNT(tuplas);

STORE wordcount INTO 'output' USING PigStorage(',');
