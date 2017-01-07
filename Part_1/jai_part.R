# Data Preprocessing
# Initializating the dataset into R Studio
# Load table as imdb and view the dataset
imdb<- read.csv(file='imdb-5000-movie-dataset/movie_metadata.csv', header=TRUE, stringsAsFactors = FALSE)
# Uncomment below if you want to view the dataset
#View(imdb) 

# Check the structure of the variables and summary
# If structure of a variable unsuitable, 
# use imdb$<column> <- as.numeric(imdb$<column>) to change the structure

str(imdb)
# Make a subset of the original dataset and preprocess the first 10 column of the dataset,

first_ten <- imdb[, 1:10]

# Change the observation of the color Variable to LOWERCASE and convert column structure into factor type.

first_ten$color<- tolower(first_ten$color)
first_ten$color<-as.factor(first_ten$color)
first_ten$color<-droplevels(first_ten$color)

# We attempt to make an intuitive decision to subset the data frame by filtering out observations will not contributing our data mining process later on. So we will set our own conditions such as:
# director_facebook_likes >= 500
# actor_1_facebook_likes >= 500
# actor_3_facebook_likes >= 500
# duration >= 30
# gross >= 1000000

#Subset the first_ten_complete  

first_ten_sub <- subset(first_ten, director_facebook_likes >= 500 & actor_1_facebook_likes >= 500 & actor_3_facebook_likes >=500 & duration >=30 & gross >= 1000000 )

# Eliminate rows with missing values
first_ten_clean <- na.omit(first_ten_sub)

summary(first_ten_clean)

# Drop unnecessary columns
install.packages("dplyr")
library(dplyr)
first_ten_clean <- select(first_ten_clean, -genres, -director_name, -num_critic_for_reviews, -actor_2_name)

# Review the summary of the new pre-processed data frame, first_ten_clean
summary(first_ten_clean)
