# Proyecto : Predicci�n de notas de pel�culas


### Descripci�n del Problema

#### Motivaci�n 
En internet existen diversas alternativas para que las personas expongan sus
opiniones sobre algo. Libros, m�sica, videojuegos, y en particular, pel�culas. P�ginas
web como IMDB y MovieLens registran las opiniones de cientos de usuarios d�a a
d�a, dispuestos a manifestar lo que piensan acerca de una pel�cula que acaban de
ver. De esta forma, pueden darle una "nota" al film y as� cada pel�cula queda
posicionada seg�n el promedio de sus notas. Sabiendo esto, puede llegar a ser
interesante intentar saber en qu� casos una pel�cula se considera buena o no, e
intentar saber si contar con un actor como Robert De Niro en el reparto de una
nueva pel�cula afectar� en el desempe�o de �sta en las calificaciones de los
usuarios.
Esta informaci�n podr�a serles �til a las productoras de pel�culas que tienen que decidir qu� reparto contratar para sus pel�culas con el objetivo de obtener la nota m�s alta posible, y de esta forma asegurar el �xito en sus producciones. 


#### Problema a resolver

El gran problema que debemos resolver entonces, es c�mo utilizar una gran cantidad de metadatos de peliculas (entre los que se encuentran los actores principales, director, g�nero, etc) para as� predecir la calificaci�n o score que los usuarios le dar�an a alguna pel�cula que vaya a ser estrenada. Es decir, utilizando meta-datos conocidos de pel�culas anteriores se asociar�n las calificaciones de alguna manera a sus participantes y de esta forma al probar con diferentes combinaciones para pel�culas nuevas, obtener diferentes notas y as� elegir la mejor.


###Descripci�n de los datos

Utilizaremos dos datasets de metadatos de pel�culas encontrados en la red:

1. IMDb : Originalmente de un contest de la pagina [Kaggle](https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset) que trataba sobre algo similar a lo que queremos realizar, pero utilizando la cantidad de caras en el p�ster de la pel�cula. Este conten�a variados atributos relacionados con cada pel�cula:
	* Nombre de la pel�cula
	* 3 columnas de actores principales
	* Director
	* Duraci�n
	* N�mero de caras en la portada
	* A�o de estreno
	* Presupuesto
	* Ganancias
	* Links a Imbd
	* Facebook likes y otros.
	* Aspect Ratio
	
2. Movielens : Es un dataset masivo original de [Grouplens](http://grouplens.org), el que al igual que el dataset anterior, contiene una gran colecci�n de datos pero generados por usuarios. �ste conten�a 4 archivos, los que estaban compuestos por:
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
		
Ambos datasets contienen datos sobre variadas pel�culas que datan del 1916 o incluso cortometrajes del siglo XIX, hasta pel�culas de la actualidad (2016). El primer dataset de Kaggle cuenta con 5043 registros de pel�culas almacenados en un archivo con 28 atributos. El otro set de datos perteneciente a MovieLens contiene 34208 registros de
pel�culas. Cada pel�cula tiene asociada un id propio del dataset junto a su id en
IMDB e id en the movie database. Adem�s cada pel�cula
puede tener asociados varios g�neros, tags y ratings. Tanto tags como ratings son
registrados por usuarios, por lo que a su vez contienen el id del usuario y el tiempo
en que se hizo el registro. El n�mero de registros es 586994 para tags y 22884377
para ratings. El dataset de Kaggle posee atributos con algunos datos faltantes (NA). Sin
embargo, para cada atributo, este n�mero no sobrepasa los 50 registros. A
excepci�n de los atributos que tienen que ver con temas monetarios; es decir,
presupuesto y recaudaci�n, que alcanzan 800 NA's. A su vez, MovieLens solo posee
datos faltantes en el id de the movie database (296).
		
### Limpieza de los datos

#### Exploracion Inicial Preliminar
En un comienzo, solo exploramos los datos, intentando encontrar relaciones entre los metadatos mostrados en la secci�n anterior y c�mo pueden estos afectar en las notas de las pel�culas. Todo esto con el fin de armar nuestro primer modelo.
Los archivos se encuentran en formato .csv por lo que fue directo
importarlos a RStudio, herramienta con la que se realiz� la exploraci�n inicial. Ya
que en ambos datasets se tienen atributos propios importantes, en gran parte de la
exploraci�n inicial se trabaj� con la intersecci�n de ambas. Es decir, se utiliz� un
join entre ambas para tener la m�xima cantidad de atributos para cada pel�cula.
Para llevar a cabo esta operaci�n se requiri� de un atributo en com�n. El dataset
de MovieLens posee un atributo Id en Imdb, que sin embargo, Kaggle no tiene. No
obstante, Kaggle tiene el link de la p�gina web de cada pel�cula en Imdb, que a su
vez contiene el id dentro. A partir de la expresi�n regular [0-9]* se obtuvieron los
d�gitos incluidos en el link, que corresponden al valor buscado. Haciendo posible la
intersecci�n. Sin embargo, se perdieron ciertos registros que redujeron el total a
4566. Por �ltimo, se encontraron datos repetidos, por lo que fue necesario filtrar
para dejar s�lo datos �nicos seg�n la llave 'id de imdb', resultando en 4452
registros efectivos para la intersecci�n. Por otro lado, en MovieLens, el a�o se
encontraba dentro del string del t�tulo de la pel�cula. Ejemplo: Toy Story (1995); por
lo que tambi�n debi� extraerse mediante expresiones regulares para utilizarlo
como un atributo.


Observaci�n: A lo largo de lo que queda, se usar� indistintivamente las palabras scores y duracion.
Algunos ejemplos de la exploracion inicial:

#### Cantidad Total de Pel�culas para cada calificaci�n en IMDB
![Puntuaci�n vs Cantidad de Pel�culas](Graficos/DistTotales.png  "Cantidad de pel�culas para cada puntuaci�n en IMDB")
La primera pregunta que se plante� fue c�mo se distribu�an las calificaciones
de las pel�culas en el dataset, por lo que se realiz� una agrupaci�n por cada
evaluaci�n diferente y se grafic� la cantidad de pel�culas para cada una de ellas
utilizando barras. La distribuci�n se comporta como uno esperar�a que lo hiciera, aproxim�ndose a una normal.

#### Score vs Duracion
![Scores vs Duracion](Graficos/PeliculaDuracion.png  "Distribuci�n de los ranking/scores de las peliculas seg�n su duraci�n")
Se puede ver en este grafico que tanto las pel�culas que tienen una duracion mayor que 130 minutos tienden a tener notas sobre 5.5 mientras que las que duran menos de 80 minutos (probablemente cortos) tienden a tener notas superiores a 6.5. Por otro lado, el intervalo entre 80 y 130 minutos no otorga informaci�n concluyente por si mismo, ya que es ahi donde se encuentra una gran cantidad de pel�culas con todo tipo de score. 

#### Score vs genero de la pel�cula
![Score vs Categoria](Graficos/RatingCategoria.png "Densidad de los ratings/scores de las pel�culas seg�n su g�nero")
Se puede ver en este grafico que cada categor�a de peliculas tiende a tener una funci�n de distribucion normal, cada una centrada en un promedio distinto. Sobre esta base, podemos suponer que ciertos tipos de categor�as determinaran en alguna medida los scores de las pel�culas a las que pertenescan. En este caso tenemos por ejemplo que las peliculas de drama por lo general tienden a tener una mejor evaluacion por parte de los usuarios con respecto a otras pel�culas de distintas categor�as.

#### Score vs actores
![Score vs Actores](Graficos/RatingsActor.png "Algunos ejemplos de la densidad de los ratings/scores de las pelicuas seg�n su/sus actores")
Tal como vimos en el gr�fico anterior, tambien se puede inferir que existe una relaci�n entre el actor que esta presente en la pel�cula y su score. Esto se puede ver por ejemplo con actores como Brad Pitt que tiene la mayor�a de sus pel�culas m�s o menos bien distribuidas en el intervalo 8-9 mientras que "La Roca" tiene practicamente todas sus pel�culas en el 6.

#### Limpieza

Luego de haber realizado la exploraci�n inicial de los datos, se tom� la
decisi�n de eliminar algunos atributos por diversos motivos. Algunos fueron
removidos debido a que no concordaban con el objetivo del proyecto. La
recaudaci�n por ejemplo, est� fuera de nuestros intereses pues es informaci�n
posterior a la evaluaci�n de la pel�cula que nosotros buscamos conocer
previamente. En este mismo sentido tambi�n eliminamos el n�mero de ratings y
reviews. Tambi�n el n�mero de likes en facebook de directores, actores y la
pel�cula considerando adem�s que requieren de una actualizaci�n constante para
poder utilizarlos correctamente. Por otro lado, el atributo rating de contenido
conten�a demasiados datos faltantes por lo que se debi� remover. Finalmente el
atributo color que indicaba si la pel�cula se encontraba en blanco y negro pose�a
datos err�neos que se pod�an notar con facilidad y tampoco fue considerada.
As�, los atributos que se consideraron para el clasificador finalmente fueron:
g�nero, director, actores, duraci�n, puntuaci�n.
Algunos atributos m�ltiples como g�nero, se encontraban en una sola
columna con un delimitador (g�nero: Acci�n | Drama | Comedia). Por lo que se
separ� en columnas de acuerdo a los requerimientos mencionados en la secci�n de
"Pre-Procesamiento de Datos."
Por �ltimo, los requerimientos mencionados tambi�n en aquella secci�n,
indicaron que la dimensi�n que resultar�a de la cantidad de actores (alrededor de
10000), junto con la cantidad de directores (alrededor de 5000) ser�a muy alta. Por
lo que se debi� hacer una reducci�n de la dimensionalidad para estos dos
atributos. Respecto a los actores, bajo la consideraci�n de que son m�s relevantes
para el an�lisis aquellos que se encuentran en m�s pel�culas y trabajan con otros
actores, se construy� un grafo en el cual cada nodo corresponde a un actor
diferente y cada enlace entre dos actores consideraba que hubiesen trabajado
juntos en alguna pel�cula. De esta forma, se pudo probar dos algoritmos que
asignaran una importancia a cada actor de acuerdo a sus enlaces: el algoritmo
Eigenvector Centrality y una variante similar de �ste, PageRank de Google. Ambos
algoritmos arrojaron una lista con la importancia de cada nodo en el grafo. As�, fue
f�cil determinar con cu�ntos actores se trabajar�a y cortar la lista de forma de
reducir la cantidad de actores seg�n su importancia. Con los directores no era
posible encontrar el mismo grafo dado que s�lo hab�a uno por cada pel�cula. Por lo
tanto, utilizando el mismo criterio que para los actores, se filtraron a todos los
directores que hubiesen trabajado en menos de una cantidad determinada de
pel�culas. Finalmente, se dejaron aproximadamente 500 actores y 500 directores
que corresponden a los m�s "influyentes" (esto se traduce a que tuvieron m�s
participaciones) y se us� el m�todo de Eigan para el grafo.

### Procesamiento de Datos

#### Pre-Procesamiento (Prueba Preliminar)

Para cumplir con el objetivo del proyecto, se determin� que un clasificador
ser�a nuestra herramienta a utilizar. As�, se estudi� el clasificador proporcionado
por la librer�a Scikit-Learn. Esto nos indic� los cambios que requer�an los datos para
poder utilizarlo de forma correcta.
En primer lugar, el clasificador no recibe ninguna clase de null/NA, por lo
que fue necesario eliminar las filas que los contuviesen en alguna de sus columnas.
De todas formas, no eran tantos NA por lo que se podr�a hacer una b�squeda para
rellenar esos campos que faltaron, si es necesario.
En segundo lugar, el clasificador s�lo recibe atributos num�ricos. Siendo que
la mayor�a de nuestros atributos consisten de Strings (Director, Actor, G�nero,
etc.), fue necesario transformarlos para ser recibidos por el clasificador. Esto se
llev� a cabo a�adiendo columnas de acuerdo a cada String diferente en un
atributo. Es decir, haciendo una matriz booleana (0 y 1) indicando si el registro (id
de la pel�cula) pose�a el string indicado en la columna o no. Por ejemplo, una
pel�cula que tuviese g�nero horror y drama, marcar�a un 1 en las columnas "terror"
y "drama" y un 0 en los dem�s g�neros. Es por esta raz�n que debi� realizarse una
reducci�n de dimensionalidad para actores y directores mencionada en la secci�n
anterior. Este trabajo tom� mucho tiempo y concentr� muchos de los esfuerzos del trabajo en general.

#### Re-Procesamiento




### Resultados

#### Preliminares
En la prueba preliminar, el clasificador que obtuvo mejores resultados fue Support Vector Machine, obteniendo un Accuracy de 0.61. Este resultado no se considera aceptable de acuerdo al objetivo, por lo que se propuso mejorar el clasificador para obtener mejores resultados. Tambi�n se concluy� en esta prueba que el clasificador falla en algunos casos de pel�culas con pocos datos de respaldo, como por ejemplo "Justin Bieber: Never Say Never", en la que err� por mucho la nota.

#### Finales
En la prueba final, luego de corregir los errores de la prueba preliminar, se obtuvieron mejores resultados. 




