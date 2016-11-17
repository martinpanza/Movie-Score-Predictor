library("igraph")

actors1 <- data.frame(actor=c(as.character(movies$actor_1_name)), score=c(movies$imdb_score))
actors2 <- data.frame(actor=c(as.character(movies$actor_2_name)), score=c(movies$imdb_score))
actors3 <- data.frame(actor=c(as.character(movies$actor_3_name)), score=c(movies$imdb_score))

actors <- rbind(actors1, actors2, actors3)

actors <- aggregate(actors, by=list(actors$actor), FUN=mean)
actors <- actors[,c(1,3)]
colnames(actors) = c("Actor", "weights")
actors <- actors[!actors$Actor=="",]




### Eigen Centrality

#actors1 <- movies$actor_1_name
#actors1 <- as.character(actors1)

#actors2 <- movies$actor_2_name
#actors2 <- as.character(actors2)

#actors3 <- movies$actor_3_name
#actors3 <- as.character(actors3)


#actors <- as.vector(rbind(actors1,
#                          actors2,
#                          actors3))
#actors <- unique(actors)
#actors <- actors[actors!=""]

#relations <- data.frame(from=as.vector(rbind(actors1, actors2, actors3)),
#                        to=as.vector(rbind(actors2, actors3, actors1)),
#                        weights=as.vector(rbind(10 - movies$imdb_score, 10 - movies$imdb_score, 10 - movies$imdb_score)))
#relations <- relations[, c(1,3,5)]
#colnames(relations) = c("from","to","weights")

relations <- data.frame(from=as.vector(rbind(actors1, actors2, actors3)),
                        to=as.vector(rbind(actors2, actors3, actors1)))
relations <- relations[, c(1,3)]
colnames(relations) = c("from","to")
relations <- relations[!relations$from == "" & !relations$to == "",]

g <- graph_from_data_frame(relations, directed=FALSE, vertices=actors$Actor)

print(g, e=TRUE, v=TRUE)

eigen <- eigen_centrality(g, directed = FALSE, scale = TRUE, weights = NULL,
                          options = arpack_defaults)

ec <- data.frame(eigen$vector)
ec3 <- round(ec$eigen.vector, digits = 5)
ec <- cbind(ec, ec3)


pagerank <- page_rank(g, directed = FALSE, weights = NULL,
                options = NULL)

pr <- data.frame(pagerank$vector)
pr2 <- round(pr$pagerank.vector, digits = 7)
pr <- cbind(pr, pr2)

write.csv(ec, file = "Actors2.csv", sep = ";")

library(xlsx)
write.xlsx(ec, file = "eigan.xlsx", sheetName="actors")
write.xlsx(pr, file = "pagerank.xlsx", sheetName="actors")