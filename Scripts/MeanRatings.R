#Tratamiento de datos : Scores/Ratings

#Cambiar esto!
setwd("~/Escritorio/Mineria/Movie-Score-Predictor/Datasets")
ratings <- read.csv("~/Escritorio/Mineria/Proyecto/Desafio2/Filtrados/ratings.csv")
movies <- read.csv("~/Escritorio/Mineria/Movie-Score-Predictor/Datasets/movies.csv")

library(reshape2)

#Agregacion
mean_ratings <- dcast(ratings, movieId ~ .,mean)
colnames(mean_ratings)[2] = "movielens_score"
#Normalizacion
mean_ratings <- mean_ratings[!duplicated(mean_ratings[,1]),]
mean_ratings$movielens_score_normalized <- mean_ratings$movielens_score*2 
#Join
movies <- merge(x = movies, y = mean_ratings, by = "movieId", all = TRUE)

movies <- movies[,c(1,2,3,5,6,7,8,9,10,11,12,13,14,15,4,16,17)]

#Aproximate

aprox_imdb_score <- movies[,c(15)]
aprox_movielens_score <- movies[,c(16)]
aprox_movielens_normalized_score <- movies[,c(17)]

aprox_imdb_score <- round(aprox_imdb_score)
aprox_movielens_score <- round(aprox_movielens_score)
aprox_movielens_normalized_score<- round(aprox_movielens_normalized_score)

movies$aprox_imdb_score <- aprox_imdb_score
movies$aprox_movielens_score <- round(aprox_movielens_score)
movies$aprox_movielens_normalized_score <- round(aprox_movielens_normalized_score)

write.csv(movies, file = "movies.csv", row.names = FALSE)


