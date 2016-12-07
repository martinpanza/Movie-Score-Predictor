# Eliminar duplicados
clean <- join[!duplicated(join[,1]),]

# Filtrar las columnas que importan
data <- clean[, c(3, 5, 8, 12, 16, 20, 21, 22, 24, 26)]

#Solo los datos numericos
data2 <- data[, c(2, 9, 10)]
data2 <- data2[complete.cases(data2),]

#Duracion y Año
data_numeric <- data2[, c(1,2)]

#Puntuacion
target <- data2[, 3]

#Exportar a csv
write.csv(data_numeric, file = "Data.csv", row.names=FALSE)
write.csv(target, file = "Target.csv", row.names=FALSE, col.names = FALSE)