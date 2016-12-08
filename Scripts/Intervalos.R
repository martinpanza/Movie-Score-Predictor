intervalos <- cbind(movies_final_imdb[, c(1,2)], movies_final)

ceroacuatro <- intervalos[intervalos$aprox_imdb_score <= 4,]
ceroacuatroScores <- ceroacuatro[,2]
ceroacuatro <- ceroacuatro[,3:2701]

ceroacinco <- intervalos[intervalos$aprox_imdb_score <= 5 & intervalos$aprox_imdb_score > 0,]
ceroacincoScores <- ceroacinco[,2]
ceroacinco <- ceroacinco[,3:2701]

seisasiete <- intervalos[intervalos$aprox_imdb_score <= 7 & intervalos$aprox_imdb_score > 5,]
seisasieteScores <- seisasiete[,2]
seisasiete <- seisasiete[,3:2701]

seisanueve <- intervalos[intervalos$aprox_imdb_score <= 9 & intervalos$aprox_imdb_score > 5,]
seisanueveScores <- seisanueve[,2]
seisanueve <- seisanueve[,3:2701]

ochoadiez <- intervalos[intervalos$aprox_imdb_score <= 10 & intervalos$aprox_imdb_score > 7,]
ochoadiezScores <- ochoadiez[,2]
ochoadiez <- ochoadiez[,3:2701]

ceroadiez <- intervalos[intervalos$aprox_imdb_score <= 10 & intervalos$aprox_imdb_score > 0,]
ceroadiezScores <- ceroadiez[,2]
ceroadiez <- ceroadiez[,3:2701]

write.csv(ceroacuatro, file = "movies_0to4.csv", row.names = FALSE)
write.csv(ceroacinco, file = "movies_0to5.csv", row.names = FALSE)
write.csv(seisasiete, file = "movies_6to7.csv", row.names = FALSE)
write.csv(seisanueve, file = "movies_6to9.csv", row.names = FALSE)
write.csv(ochoadiez, file = "movies_8to10.csv", row.names = FALSE)
write.csv(ceroadiez, file = "movies_0to10.csv", row.names = FALSE)

write.csv(ceroacuatroScores, file = "scores_0to4.csv", row.names = FALSE)
write.csv(ceroacincoScores, file = "scores_0to5.csv", row.names = FALSE)
write.csv(seisasieteScores, file = "scores_6to7.csv", row.names = FALSE)
write.csv(seisanueveScores, file = "scores_6to9.csv", row.names = FALSE)
write.csv(ochoadiezScores, file = "scores_8to10.csv", row.names = FALSE)
write.csv(ceroadiezScores, file = "scores_0to10.csv", row.names = FALSE)