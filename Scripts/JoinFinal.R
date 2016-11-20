# Archivo ojala final de datos.

library(reshape2)
categorias <- data.frame(definitivocsveigan_500actores500directores[,c(1,12:35)])
actores <- data.frame(definitivocsveigan_500actores500directores[,c(1,36:535)])
directores <- data.frame(definitivocsveigan_500actores500directores[,c(1,536:1043)])
duracion <- movies[,c(1,10)]
notas_aproximadas_imbd <- movies[,c(1,18)]
notas_aproximadas_movielens <- movies[,c(1,19)]
notas_aproximadas_movielens_norm <- movies[,c(1,20)]

# Formato : movie_id + rating + duracion + genero + actores.

#Final Movies con las notas de IMBD:
movies_final <- merge(duracion,categorias,by="movieId")
movies_final <- merge(movies_final,actores,by="movieId")
movies_final <- merge(movies_final,directores,by="movieId")

# Escribir movies_final
write.csv(movies_final[,c(2:1034)], file = "movies_final.csv", row.names = FALSE)
# Escribir movies_final sin la fecha.
write.csv(movies_final[,c(3:527)], file = "movies_final_sin_duracion.csv", row.names = FALSE)

#Escribir notas IMDB
write.csv(notas_aproximadas_imbd[,c(2)], file = "imbd.csv", row.names = FALSE)
#Escribir notas Movielens 1-5
write.csv(notas_aproximadas_movielens[,c(2)], file = "movielens.csv", row.names = FALSE)
