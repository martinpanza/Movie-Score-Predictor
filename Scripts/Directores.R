# Seleccionar directores con mas apariciones :

#Contamos cuantos directores hay y lo guardamos en count.
directores <- aggregate(cbind(count = director_name) ~ director_name, 
          data = movies, 
          FUN = function(x){NROW(x)})
# Ordenamos los directores de forma descendente y filtramos los mas connotados.
directores <- directores[order(-directores$count),]
directores_connotados <- directores[directores$count > 2,]
directores_connotados2 <- directores[directores$count > 3,]

write.csv(directores_connotados[,c(1)], file = "directores.csv", row.names = FALSE)
write.csv(directores_connotados2[,c(1)], file = "directores2.csv", row.names = FALSE)