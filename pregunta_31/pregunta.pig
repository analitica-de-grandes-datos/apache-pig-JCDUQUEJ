/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

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

years = FOREACH Datos GENERATE FLATTEN(TOKENIZE(SUBSTRING(fecha,0,4))) AS year1;

grouped = GROUP years BY year1;

wordcount = FOREACH grouped GENERATE group, COUNT(years);

wordcount_ordered = ORDER wordcount BY group;

STORE wordcount_ordered INTO 'output' USING PigStorage(',');