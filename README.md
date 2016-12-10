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

#### Datos originales
Primero que nada, realizamos un analisis exhaustivo de los datos 




