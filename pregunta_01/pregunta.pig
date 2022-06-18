/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        

        >>> Escriba su respuesta a partir de este punto <<<

        Datos = LOAD 'data.tsv'
                AS (
                        letra:chararray,
                        eventDate:chararray,
                        quantity:int
                );

        -- genera una tabla llamada words con una palabra por registro
        words = FOREACH Datos GENERATE FLATTEN(TOKENIZE(letra)) AS word;

        -- agrupa los registros que tienen la misma palabra
        grouped = GROUP words BY word;

        -- genera una variable que cuenta las ocurrencias por cada grupo
        wordcount = FOREACH grouped GENERATE group, COUNT(words);

        STORE wordcount INTO 'output/';
*/
