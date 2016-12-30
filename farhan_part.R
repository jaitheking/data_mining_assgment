imdb<- read.csv(file='imdb.csv', header=TRUE, stringsAsFactors = FALSE)

# Make a subset of the original dataset and preprocess the next 9 column of the dataset
third_nine <- imdb[,20:28]

# Show summary
summary(third_nine)

# Convert all character columns into factor columns (default of as.data.frame)
third_nine_rev <- as.data.frame(unclass(third_nine))

# Filtering the values
# budget >= 5.000e+05
# title_year >= 1990
# actor_2_facebook_likes <= 50000
# movie_facebook_likes <= 50000
third_nine_sub <- subset(third_nine_rev, budget >= 5.000e+05, title_year >= 1990, actor_2_facebook_likes <= 50000, movie_facebook_likes <= 50000)

# Eliminate rows with missing values
third_nine_clean <- na.omit(third_nine_sub)

# Due to the numbers are having a visible difference, no column will be dropped