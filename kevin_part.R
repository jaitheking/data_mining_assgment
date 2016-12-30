# Make a subset of the original dataset and preprocess the next 9 column of the dataset

second_nine <- imdb[,11:19]

# Convert plot keywords to characters

second_nine$plot_keywords <- as.character(second_nine$plot_keywords)
words <- second_nine$plot_keywords
words <- na.omit(words)

# Finding max number of string count in each row (seperated by "|")

library(tidyr)
library(stringr)
len <- max(str_count(words, pattern = paste0("[","|","]")))

# Separate mixed string into columns

vec_names <- paste0("plot_keywords",1:(len+1))
second_nine_rev <- second_nine %>%
  separate(col = "plot_keywords", into = vec_names, sep = paste0("[","|","]"), extra = "drop")

# Convert all character columns into factor columns (default of as.data.frame)

second_nine_rev <- as.data.frame(unclass(second_nine_rev))

# num_voted_users >= 10000
# cast_total_facebook_likes >= 1000
# num_user_for_reiews >= 50

# Subset second_nine_rev

second_nine_sub <- subset(second_nine_rev, num_voted_users >= 10000, cast_total_facebook_likes >= 1000, num_users_for_reviews >= 50)


# Eliminate rows with missing values

second_nine_clean <- na.omit(second_nine_sub)

# Drop column:
# 1. movie_title
# 2. facenumber_in_poster
# 3. movie_imdb_link

install.packages("dplyr")
library(dplyr)
second_nine_clean <- select(second_nine_clean, -movie_title, -facenumber_in_poster, -movie_imdb_link)

# Review the summary of the new pre-processed data frame, second_nine_clean
summary(second_nine_clean)
