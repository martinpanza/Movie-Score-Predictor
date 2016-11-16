library(stringr)
library(ggplot2)

# Importar
movies <- read.csv("~/Escritorio/Mineria/Proyecto/Datasets/movies.csv")
links <- read.csv("~/Escritorio/Mineria/Proyecto/Datasets/links.csv")
ratings <- read.csv("~/Escritorio/Mineria/Proyecto/Datasets/ratings.csv")
tags <- read.csv("~/Escritorio/Mineria/Proyecto/Datasets/tags.csv")
movie_metadata <- read.csv("~/Escritorio/Mineria/Proyecto/Datasets/movie_metadata.csv")

#Regex - Extraer los links
movie_metadata$movie_imdb_link <- str_extract(movie_metadata$movie_imdb_link,"[[:digit:]]+")
# As Numeric
movie_metadata$movie_imdb_link <- as.numeric(movie_metadata$movie_imdb_link)

# Join 
movie_metadata <- merge(movie_metadata,links,by.x = "movie_imdb_link",by.y = "imdbId")

#Filtrar movies
movies <- merge(movies,movie_metadata[,c(5,11,13,23,26,29)],by.x = "movieId",by.y = "movieId")

#Filtrar Tags
tags <- merge(tags,movie_metadata,by.x = "movieId",by.y = "movieId")
tags <- tags [,1:4]
tags$tag <- tolower(tags$tag)

#Filtrar Ratings
ratings  <- merge(ratings[,c(2,3)],movie_metadata[,c(13,29)],by.x = "movieId",by.y = "movieId")
--------------------------------------------------------------------------

# Ranking vs duración
qplot(movie_metadata$duration,movie_metadata$imdb_score, asp = 0.8) + 
  labs( title = "Ranking vs Duración", x = "Duración", y = "Rating")
# --------------------------------------------------------------------

# Ranking vs categoria
# Uso grepl (regex) para encontrar la categoria dentro de la lista y poder obtener todos los pertenecientes a ella
#limpieza de los datos 

#V2
comedy <- movies[grepl("Comedy",movies$genres.x) | grepl("Comedy",movies$genres.y),]
action <- movies[grepl("Action",movies$genres.x) | grepl("Action",movies$genres.y),]
sci_fi <- movies[grepl("Sci-Fi",movies$genres.x) | grepl("Sci-Fi",movies$genres.y),]
drama <- movies[grepl("Drama",movies$genres.x)|grepl("Drama",movies$genres.y),]
horror <- movies[grepl("Horror",movies$genres.x)|grepl("Horror",movies$genres.y),]
animation <- movies[grepl("Animation",movies$genres.x)|grepl("Animation",movies$genres.y),]
comedy$category <- "Comedy"
action$category <- "Action"
sci_fi$category <- "Sci-Fi"
drama$category <- "Drama"
horror$category <- "Horror"
animation$category <- "Animation"

by_category <- rbind(comedy,action,drama,horror,animation)[,c(1,8,9)]
###Distribucion
ggplot(by_category,aes(x=by_category$imdb_score, colour = by_category$category)) +
  geom_density(size = 0.5,adjust = 0.7) + 
  labs(title = "Densidad de Ratings por Categoría",x = "Ratings",y = "Densidad",colour = "Categorías") + 
  xlim(1,10)
###Histograma
ggplot(by_category,aes(x=by_category$imdb_score, colour = by_category$category)) + 
    geom_bar() +
    labs(title = "Frecuencia de Ratings por Categoría",x = "Ratings",y = "Frecuencia",colour = "Categorías")+
    xlim(0,10)

# -----------------------------------------------------------------------

#Distribucion segun peliculas - Usando la tabla ratings.

# Ranking Dragon Ball -> Pelicula Mala.
dragon_ball <- ratings[ratings$movieId %in% 67867,c(2,3)]
avatar <- ratings[ratings$movieId %in% 72998,c(2,3)]
transformers2 <- ratings[ratings$movieId %in% 69526,c(2,3)]

by_numberofRatings <- rbind(dragon_ball,avatar,transformers2)
by_numberofRatings <- merge(by_numberofRatings,movies)

###Densidad de las evaluaciones de las peliculas

ggplot(by_numberofRatings,aes(x=by_numberofRatings$rating, colour = by_numberofRatings$title)) +
  geom_density(size = 0.5,adjust = 1.5) + 
  labs(title = "Densidad de Ratings por película",x = "Ratings",y = "Densidad",colour = "Categorías") 

ggplot(by_numberofRatings,aes(x=by_numberofRatings$rating, colour = by_numberofRatings$title)) +
  geom_bar(size = 0.5, position = "dodge") + 
  labs(title = "Densidad de Ratings por película",x = "Ratings",y = "Densidad",colour = "Categorías") 


### Histograma de las evaluaciones de las peliculas
ggplot(by_numberofRatings,aes(x=by_numberofRatings$rating, colour = by_numberofRatings$title)) + 
  geom_histogram(binwidth=.5, alpha=.2, position="identity") +
  labs(title = "Frecuencia de Ratings segun pelicula",x = "Ratings",y = "Frecuencia",colour = "Categorías")+
  xlim(0,5)

# -------------------------------------------------

##Presupuesto vs Rating -> en proceso....

action2 <- joined_tags[joined_tags$tag %in% "action",c(1,3)]
comedy2 <- joined_tags[joined_tags$tag %in% "comedy",c(1,3)]
drama2 <- joined_tags[joined_tags$tag %in% "drama",c(1,3)]
action2 <- merge(joined_ratings[,c(1,2)],action2,by.x = "movieId",by.y = "movieId")

#------------------------------------------------------

#ActoresVSRatings
de_niro <- movie_metadata[grepl("Robert De Niro",movie_metadata$actor_1_name)|grepl("Robert De Niro",movie_metadata$actor_2_name)|grepl("Robert De Niro",movie_metadata$actor_3_name),]
nicolas_cage <- movie_metadata[grepl("Nicolas Cage",movie_metadata$actor_1_name)|grepl("Nicolas Cage",movie_metadata$actor_2_name)|grepl("Nicolas Cage",movie_metadata$actor_3_name),]
brad_pitt <- movie_metadata[grepl("Brad Pitt",movie_metadata$actor_1_name)|grepl("Brad Pitt",movie_metadata$actor_2_name)|grepl("Brad Pitt",movie_metadata$actor_3_name),]
meryl_streep <- movie_metadata[grepl("Meryl",movie_metadata$actor_1_name)|grepl("Meryl",movie_metadata$actor_2_name)|grepl("Meryl",movie_metadata$actor_3_name),]
la_roca <- movie_metadata[grepl("Dwayne Johnson",movie_metadata$actor_1_name)|grepl("Dwayne Johnson", movie_metadata$actor_2_name)|grepl("Dwayne Johnson",movie_metadata$actor_3_name),]
gary_oldman <- movie_metadata[grepl("Gary Oldman",movie_metadata$actor_1_name),]

de_niro$actor <- "Robert de Niro"
nicolas_cage$actor <- "Nicolas Cage"
brad_pitt$actor <- "Brad Pitt"
meryl_streep$actor <- "Meryl Streep"
la_roca$actor <- "La Roca"
gary_oldman$actor <- "Gary Oldman"

by_actor <- rbind(de_niro,nicolas_cage,brad_pitt,meryl_streep,la_roca,gary_oldman)[,c(16,13,26,31)]

ggplot(by_actor,aes(x=by_actor$imdb_score, colour = by_actor$actor)) +
  geom_density(size = 0.8,adjust = 1) + 
  labs(title = "Densidad de Ratings por Actor",x = "Ratings",y = "Densidad",colour = "Actores") +
  xlim(0,10)

#------- Ratings por Tags

summary(tags[tags$movieId %in% 72998,])
summary(tags[tags$movieId %in% 69526,])
summary(tags[tags$movieId %in% 67867,])

