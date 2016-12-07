movieTags <- merge(tags, movies, by.x = "movieId",by.y = "movieId")

movieTags <- movieTags[c(1: 5000), c(1, 2)]
aggDataSmall <- aggregate(movieTags, by=list(movieTags$movieId, movieTags$tag), FUN=length)
aggDataSmallCut <- aggregate(aggDataSmall$movieId, by=list(aggDataSmall$Group.1), FUN= head)

movieTagsTest <- movieTags[, c(1, 2)]
aggData <- aggregate(movieTagsTest, by=list(movieTagsTest$movieId, movieTagsTest$tag), FUN=length)
aggData <- aggData[aggData$movieId>10, c(2,3)]
aggFinal <- aggregate(aggData, by= list(aggData$Group.2), FUN = length)
aggFinal <- aggFinal[,c(1,2)]

join <- merge(tagsBacanes, movieTags, by.x = "V1", by.y = "tag")
join2 <- merge(tagsBacanes, tags, by.x = "V1", by.y = "tag")
join3 <- unique(join2)
colnames(join3) <- c("tag", "movieId")

write.csv(aggFinal, file = "tagsBacanes", row.names = FALSE)


booleanmatrix <- dcast(data = tags[c(1:5000),], formula = movieId ~ tag)
booleanmatrix <- dcast(data = join3, formula = movieId ~ tag)
booleanmatrix[is.na(booleanmatrix)] <- 0

movies_final_final <- cbind(movies_final_imdb[,1], movies_final)
colnames(movies_final_final)[1] <- c("movieId") 


movie_Final <- merge(movies_final_final, booleanmatrix, by.x = "movieId", by.y = "movieId", all= TRUE)
movie_Final <- movie_Final[,2:2700]
movie_Final[is.na(movie_Final)] <- 0
write.csv(movie_Final, file = "movies_final", row.names = FALSE)