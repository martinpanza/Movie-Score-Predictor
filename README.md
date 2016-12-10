# Proyecto : Prediccion de notas de peliculas


### Descripcion del Problema

#### Motivación 
En el año 2015 se estrenaron aproximadamente 160 películas, lo que en promedio significan 24 días continuos de películas. 
Ya que es improbable que tengamos el tiempo para ver todas estas películas, puede ser de utilidad poder predecir qué calificación tendrá una película próxima a estrenar.
Al mismo tiempo, esto es relevante también para las productoras para saber si la combinación de factores de una película es la más adecuada para lograr su éxito. 

#### Problema a resolver

Por lo que el gran problema que debemos resolver es como utilizar una gran cantidad de metadatos de peliculas para así predecir la calificación o score que los usuarios le darían a alguna película que esté por estrenar.


###Descripcion de los datos

Utilizaremos dos datasets de metadatos de películas encontrados en la red :

1. IMDb : Originalmente de un contest de la pagina [Kaggle](https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset) que trataba sobre algo similar a lo que queremos realizar, pero utilizando la cantidad de caras en el folleto de la película. Este contenia variados atributos relacionados con cada pelicula:
	* Nombre de la pelicula
	* 3 columnas de actores principales
	* Director
	* Duración
	* Numero de caras en la portada
	* Año de estreno
	* Presupuesto
	* Ganancias
	* Links a Imbd
	* Facebook likes y otros.
	* Aspect Ratio
	
2. Movielens : Es un dataset masivo original de [Grouplens](http://grouplens.org), el cual al igual que el dataset anterior, contiene una gran coleccion de datos, pero generados por usuarios. Esta contenía 4 archivos, los cuales estaban compuestos por :
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
		
### Limpieza de los datos

#### Exploracion Inicial
En un comienzo, solo exploramos los datos, intentando encontrar relaciones entre los metadatos mostrados en la sección anterior y como pueden estos afectar en las notas de las películas. Todo esto con el fin de armar nuestro primer modelo.
Observación : A lo largo de lo que queda, se usará indistintivamente las palabras scores y duracion.
Algunos ejemplos de la exploracion inicial:

##### Score vs Duracion.
![Scores vs Duracion](Graficos/PeliculaDuracion.png  "Distribución de los ranking/scores de las peliculas según su duración.")
Se puede ver en este grafico que tanto las películas que tienen una duracion mayor que 130 minutos tienden a tener notas sobre 5.5 mientras que las que duran menos de 80 minutos (probablemente cortos) tienden a tener notas superiores a 6.5. Por otro lado, el intervalo entre 80 y 130 minutos no otorga información concluyente por si mismo, ya que es ahi donde se encuentra una gran cantidad de películas con todo tipo de score. 

##### Score vs genero de la película. 
![Score vs Categoria](Graficos/RatingCategoria.png "Densidad de los ratings/scores de las películas segun su genero,")
Se puede ver en este grafico que cada categoría de peliculas tiende a tener una función de distribucion normal, cada una centrada en un promedio distinto. Sobre esta base, podemos suponer que ciertos tipos de categorías determinaran en alguna medida los scores de las películas a las que pertenescan. En este caso tenemos por ejemplo que las peliculas de drama por lo general tienden a tener una mejor evaluacion por parte de los usuarios con respecto a otras películas de distintas categorías.

##### Score vs actores.
![Score vs Actores](Graficos/RatingsActor.png "Algunos ejemplos de la densidad de los ratings/scores de las pelicuas según su/sus actores")
Tal como vimos en el gráfico anterior, tambien se puede inferir que existe una relación entre el actor que esta presente en la película y su escore. Esto se puede ver por ejemplo con actores como Brad Pitt que tiene la mayoría de sus películas mas o menos bien distribuidas en el intervalo 8-9 mientras que la roca tiene practicamente todas sus películas.





