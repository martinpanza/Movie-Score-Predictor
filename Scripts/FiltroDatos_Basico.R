#Filtro Datos.

library(stringr)

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
#movies <- merge(movies,movie_metadata[,c(5,11,13,23,26,29)],by.x = "movieId",by.y = "movieId")
movies <- merge(movies,movie_metadata,by.x = "movieId",by.y = "movieId")

#Filtrar Tags
tags <- merge(tags,movie_metadata,by.x = "movieId",by.y = "movieId")
tags <- tags [,1:4]
tags$tag <- tolower(tags$tag)

#Filtrar Ratings
ratings  <- merge(ratings[,c(2,3)],movie_metadata[,c(13,29)],by.x = "movieId",by.y = "movieId")
#--------------------------------------------------------------------------
  
# Filtro Columnas Movies_Metadata
movies_metadata_toSave <- movies[,c(1,16,27,29,3,14,6,15,11,19,8,21,23,24,20)]

#------------- Guardar -----------------------

write.csv(movies_metadata_toSave, file = "movies.csv", row.names = FALSE)
write.csv(ratings, file = "ratings.csv", row.names = FALSE)
write.csv(tags, file = "tags.csv", row.names = FALSE)