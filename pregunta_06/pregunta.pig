/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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

words = FOREACH Datos GENERATE REPLACE(REPLACE(columna3,'\\[',''),'\\]','') AS col3;

letras = FOREACH words GENERATE FLATTEN(TOKENIZE(col3)) AS word;

cadena = FOREACH letras GENERATE SUBSTRING(word,0,3) AS claves;

grouped = GROUP cadena BY claves;

wordcount = FOREACH grouped GENERATE group, COUNT(cadena);

STORE wordcount INTO 'output' USING PigStorage(',')
