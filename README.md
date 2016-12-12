# Proyecto : Predicción de notas de películas


### Descripción del Problema

#### Motivación 
En internet existen diversas alternativas para que las personas expongan sus
opiniones sobre algo. Libros, música, videojuegos, y en particular, películas. Páginas
web como IMDB y MovieLens registran las opiniones de cientos de usuarios día a
día, dispuestos a manifestar lo que piensan acerca de una película que acaban de
ver. De esta forma, pueden darle una "nota" al film y así cada película queda
posicionada según el promedio de sus notas. Sabiendo esto, puede llegar a ser
interesante intentar saber en qué casos una película se considera buena o no, e
intentar saber si contar con un actor como Robert De Niro en el reparto de una
nueva película afectará en el desempeño de ésta en las calificaciones de los
usuarios.
Esta información podría serles útil a las productoras de películas que tienen que decidir qué reparto contratar para sus películas con el objetivo de obtener la nota más alta posible, y de esta forma asegurar el éxito en sus producciones. 


#### Problema a resolver

El gran problema que debemos resolver entonces, es cómo utilizar una gran cantidad de metadatos de peliculas (entre los que se encuentran los actores principales, director, género, etc) para así predecir la calificación o score que los usuarios le darían a alguna película que vaya a ser estrenada. Es decir, utilizando meta-datos conocidos de películas anteriores se asociarán las calificaciones de alguna manera a sus participantes y de esta forma al probar con diferentes combinaciones para películas nuevas, obtener diferentes notas y así elegir la mejor.


###Descripción de los datos

Utilizaremos dos datasets de metadatos de películas encontrados en la red:

1. IMDb : Originalmente de un contest de la pagina [Kaggle](https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset) que trataba sobre algo similar a lo que queremos realizar, pero utilizando la cantidad de caras en el póster de la película. Este contenía variados atributos relacionados con cada película:
	* Nombre de la película
	* 3 columnas de actores principales
	* Director
	* Duración
	* Número de caras en la portada
	* Año de estreno
	* Presupuesto
	* Ganancias
	* Links a Imbd
	* Facebook likes y otros.
	* Aspect Ratio
	
2. Movielens : Es un dataset masivo original de [Grouplens](http://grouplens.org), el que al igual que el dataset anterior, contiene una gran colección de datos pero generados por usuarios. Éste contenía 4 archivos, los que estaban compuestos por:
	* Movies.csv :
		* MovieId
		* Nombre de la pelicula
		* Generos (entre 1 a 3 generos escritos en un mismo string)
	* Links.csv:
		* Movieid
		* Link a IMBD
		* Link a !DONDE???
	* Tags.csv :
		* MovieId
		* Tag
	* Rating : 
		* MovieId
		* Rating
		
Ambos datasets contienen datos sobre variadas películas que datan del 1916 o incluso cortometrajes del siglo XIX, hasta películas de la actualidad (2016). El primer dataset de Kaggle cuenta con 5043 registros de películas almacenados en un archivo con 28 atributos. El otro set de datos perteneciente a MovieLens contiene 34208 registros de
películas. Cada película tiene asociada un id propio del dataset junto a su id en
IMDB e id en the movie database. Además cada película
puede tener asociados varios géneros, tags y ratings. Tanto tags como ratings son
registrados por usuarios, por lo que a su vez contienen el id del usuario y el tiempo
en que se hizo el registro. El número de registros es 586994 para tags y 22884377
para ratings. El dataset de Kaggle posee atributos con algunos datos faltantes (NA). Sin
embargo, para cada atributo, este número no sobrepasa los 50 registros. A
excepción de los atributos que tienen que ver con temas monetarios; es decir,
presupuesto y recaudación, que alcanzan 800 NA's. A su vez, MovieLens solo posee
datos faltantes en el id de the movie database (296).
		
### Limpieza de los datos

#### Exploracion Inicial Preliminar
En un comienzo, solo exploramos los datos, intentando encontrar relaciones entre los metadatos mostrados en la sección anterior y cómo pueden estos afectar en las notas de las películas. Todo esto con el fin de armar nuestro primer modelo.
Los archivos se encuentran en formato .csv por lo que fue directo
importarlos a RStudio, herramienta con la que se realizó la exploración inicial. Ya
que en ambos datasets se tienen atributos propios importantes, en gran parte de la
exploración inicial se trabajó con la intersección de ambas. Es decir, se utilizó un
join entre ambas para tener la máxima cantidad de atributos para cada película.
Para llevar a cabo esta operación se requirió de un atributo en común. El dataset
de MovieLens posee un atributo Id en Imdb, que sin embargo, Kaggle no tiene. No
obstante, Kaggle tiene el link de la página web de cada película en Imdb, que a su
vez contiene el id dentro. A partir de la expresión regular [0-9]* se obtuvieron los
dígitos incluidos en el link, que corresponden al valor buscado. Haciendo posible la
intersección. Sin embargo, se perdieron ciertos registros que redujeron el total a
4566. Por último, se encontraron datos repetidos, por lo que fue necesario filtrar
para dejar sólo datos únicos según la llave 'id de imdb', resultando en 4452
registros efectivos para la intersección. Por otro lado, en MovieLens, el año se
encontraba dentro del string del título de la película. Ejemplo: Toy Story (1995); por
lo que también debió extraerse mediante expresiones regulares para utilizarlo
como un atributo.


Observación: A lo largo de lo que queda, se usará indistintivamente las palabras scores y duracion.
Algunos ejemplos de la exploracion inicial:

#### Cantidad Total de Películas para cada calificación en IMDB
![Puntuación vs Cantidad de Películas](Graficos/DistTotales.png  "Cantidad de películas para cada puntuación en IMDB")
La primera pregunta que se planteó fue cómo se distribuían las calificaciones
de las películas en el dataset, por lo que se realizó una agrupación por cada
evaluación diferente y se graficó la cantidad de películas para cada una de ellas
utilizando barras. La distribución se comporta como uno esperaría que lo hiciera, aproximándose a una normal.

#### Score vs Duracion
![Scores vs Duracion](Graficos/PeliculaDuracion.png  "Distribución de los ranking/scores de las peliculas según su duración")
Se puede ver en este grafico que tanto las películas que tienen una duracion mayor que 130 minutos tienden a tener notas sobre 5.5 mientras que las que duran menos de 80 minutos (probablemente cortos) tienden a tener notas superiores a 6.5. Por otro lado, el intervalo entre 80 y 130 minutos no otorga información concluyente por si mismo, ya que es ahi donde se encuentra una gran cantidad de películas con todo tipo de score. 

#### Score vs genero de la película
![Score vs Categoria](Graficos/RatingCategoria.png "Densidad de los ratings/scores de las películas según su género")
Se puede ver en este grafico que cada categoría de peliculas tiende a tener una función de distribucion normal, cada una centrada en un promedio distinto. Sobre esta base, podemos suponer que ciertos tipos de categorías determinaran en alguna medida los scores de las películas a las que pertenescan. En este caso tenemos por ejemplo que las peliculas de drama por lo general tienden a tener una mejor evaluacion por parte de los usuarios con respecto a otras películas de distintas categorías.

#### Score vs actores
![Score vs Actores](Graficos/RatingsActor.png "Algunos ejemplos de la densidad de los ratings/scores de las pelicuas según su/sus actores")
Tal como vimos en el gráfico anterior, tambien se puede inferir que existe una relación entre el actor que esta presente en la película y su score. Esto se puede ver por ejemplo con actores como Brad Pitt que tiene la mayoría de sus películas más o menos bien distribuidas en el intervalo 8-9 mientras que "La Roca" tiene practicamente todas sus películas en el 6.

#### Limpieza

Luego de haber realizado la exploración inicial de los datos, se tomó la
decisión de eliminar algunos atributos por diversos motivos. Algunos fueron
removidos debido a que no concordaban con el objetivo del proyecto. La
recaudación por ejemplo, está fuera de nuestros intereses pues es información
posterior a la evaluación de la película que nosotros buscamos conocer
previamente. En este mismo sentido también eliminamos el número de ratings y
reviews. También el número de likes en facebook de directores, actores y la
película considerando además que requieren de una actualización constante para
poder utilizarlos correctamente. Por otro lado, el atributo rating de contenido
contenía demasiados datos faltantes por lo que se debió remover. Finalmente el
atributo color que indicaba si la película se encontraba en blanco y negro poseía
datos erróneos que se podían notar con facilidad y tampoco fue considerada.
Así, los atributos que se consideraron para el clasificador finalmente fueron:
género, director, actores, duración, puntuación.
Algunos atributos múltiples como género, se encontraban en una sola
columna con un delimitador (género: Acción | Drama | Comedia). Por lo que se
separó en columnas de acuerdo a los requerimientos mencionados en la sección de
"Pre-Procesamiento de Datos."
Por último, los requerimientos mencionados también en aquella sección,
indicaron que la dimensión que resultaría de la cantidad de actores (alrededor de
10000), junto con la cantidad de directores (alrededor de 5000) sería muy alta. Por
lo que se debió hacer una reducción de la dimensionalidad para estos dos
atributos. Respecto a los actores, bajo la consideración de que son más relevantes
para el análisis aquellos que se encuentran en más películas y trabajan con otros
actores, se construyó un grafo en el cual cada nodo corresponde a un actor
diferente y cada enlace entre dos actores consideraba que hubiesen trabajado
juntos en alguna película. De esta forma, se pudo probar dos algoritmos que
asignaran una importancia a cada actor de acuerdo a sus enlaces: el algoritmo
Eigenvector Centrality y una variante similar de éste, PageRank de Google. Ambos
algoritmos arrojaron una lista con la importancia de cada nodo en el grafo. Así, fue
fácil determinar con cuántos actores se trabajaría y cortar la lista de forma de
reducir la cantidad de actores según su importancia. Con los directores no era
posible encontrar el mismo grafo dado que sólo había uno por cada película. Por lo
tanto, utilizando el mismo criterio que para los actores, se filtraron a todos los
directores que hubiesen trabajado en menos de una cantidad determinada de
películas. Finalmente, se dejaron aproximadamente 500 actores y 500 directores
que corresponden a los más "influyentes" (esto se traduce a que tuvieron más
participaciones) y se usó el método de Eigan para el grafo.

### Procesamiento de Datos

#### Pre-Procesamiento (Prueba Preliminar)

Para cumplir con el objetivo del proyecto, se determinó que un clasificador
sería nuestra herramienta a utilizar. Así, se estudió el clasificador proporcionado
por la librería Scikit-Learn. Esto nos indicó los cambios que requerían los datos para
poder utilizarlo de forma correcta.
En primer lugar, el clasificador no recibe ninguna clase de null/NA, por lo
que fue necesario eliminar las filas que los contuviesen en alguna de sus columnas.
De todas formas, no eran tantos NA por lo que se podría hacer una búsqueda para
rellenar esos campos que faltaron, si es necesario.
En segundo lugar, el clasificador sólo recibe atributos numéricos. Siendo que
la mayoría de nuestros atributos consisten de Strings (Director, Actor, Género,
etc.), fue necesario transformarlos para ser recibidos por el clasificador. Esto se
llevó a cabo añadiendo columnas de acuerdo a cada String diferente en un
atributo. Es decir, haciendo una matriz booleana (0 y 1) indicando si el registro (id
de la película) poseía el string indicado en la columna o no. Por ejemplo, una
película que tuviese género horror y drama, marcaría un 1 en las columnas "terror"
y "drama" y un 0 en los demás géneros. Es por esta razón que debió realizarse una
reducción de dimensionalidad para actores y directores mencionada en la sección
anterior. Este trabajo tomó mucho tiempo y concentró muchos de los esfuerzos del trabajo en general.

#### Re-Procesamiento




### Resultados

#### Preliminares
En la prueba preliminar, el clasificador que obtuvo mejores resultados fue Support Vector Machine, obteniendo un Accuracy de 0.61. Este resultado no se considera aceptable de acuerdo al objetivo, por lo que se propuso mejorar el clasificador para obtener mejores resultados. También se concluyó en esta prueba que el clasificador falla en algunos casos de películas con pocos datos de respaldo, como por ejemplo "Justin Bieber: Never Say Never", en la que erró por mucho la nota.

#### Finales
En la prueba final, luego de corregir los errores de la prueba preliminar, se obtuvieron mejores resultados. 




