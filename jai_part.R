# Data Preprocessing
# Initializating the dataset into R Studio
# Load table as imdb and view the dataset
imdb<- read.csv(file='imdb-5000-movie-dataset/movie_metadata.csv', header=TRUE)
View(imdb)

# Check the structure of the variables and summary
# If structure of a variable unsuitable, 
# use imdb$<column> <- as.numeric(imdb$<column>) to change the structure

str(imdb)
summary(imdb)
hist
# Make a subset of the original dataset and preprocess the first 10 column of the dataset,

first_ten <- imdb[1:500, 1:10]
View(first_ten)

# Eliminate rows with missing values
first_ten_complete <- na.omit(first_ten)

