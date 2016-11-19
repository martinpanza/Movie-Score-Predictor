# Archivo ojala final de datos.

library(reshape2)
categorias <- data.frame(definitivocsvpagerank_500actores[,c(1,12:35)])
actores <- data.frame(definitivocsvpagerank_500actores[,c(1,36:535)])
duracion <- movies[,c(1,10)]

notas_aproximadas_imbd <- movies[,c(1,18)]
notas_aproximadas_movielens <- movies[,c(1,19)]
notas_aproximadas_movielens_norm <- movies[,c(1,20)]

# Formato : movie_id + rating + duracion + genero + actores.

#Final Movies con las notas de IMBD:
movies_final <- merge(duracion,categorias,by="movieId")
movies_final <- merge(movies_final,actores,by="movieId")

# Escribir movies_final
write.csv(movies_final[,c(2:527)], file = "movies_final.csv", row.names = FALSE)
# Escribir movies_final sin la fecha.
write.csv(movies_final[,c(3:527)], file = "movies_final_sin_duracion.csv", row.names = FALSE)

#Escribir notas IMDB
write.csv(notas_aproximadas_imbd[,c(2)], file = "imbd.csv", row.names = FALSE)
#Escribir notas Movielens 1-5
write.csv(notas_aproximadas_movielens[,c(2)], file = "movielens.csv", row.names = FALSE)
