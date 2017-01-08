#install.packages("dplyr")
library("dplyr")
#install.packages("arules")
library(arules)
#install.packages("arulesViz")
library(arulesViz)

#Load Extended Bakery dataset (Binary Vector dataset) 
bakery <- read.csv(file = "Part_2/1000-out2.csv", header=FALSE)
# Preprocessing the Dataset

#Add headers 
colnames(bakery) <- c("Transaction_ID", "Chocolate_Cake", "Lemon_Cake", "Casino_Cake", "Opera_Cake", "Strawberry_Cake", "Truffle_Cake", "Chocolate_Eclair", "Coffee_Eclair", "Vanilla_Eclair", "Napoleon_Cake", "Almond_Tart", "Apple_Pie", "Apple_Tart", "Apricot_Tart", "Berry_Tart", "Blackberry_Tart", "Blueberry_Tart", "Chocolate_Tart", "Cherry_Tart", "Lemon_Tart", "Pecan_Tart", "Ganache_Cookie", "Gongolais_Cookie", "Raspberry_Cookie", "Lemon_Cookie", "Chocolate_Meringue", "Vanilla_Meringue", "Marzipan_Cookie", "Tuile_Cookie", "Walnut_Cookie", "Almond_Croissant", "Apple_Croissant", "Apricot_Croissant", "Cheese_Croissant", "Chocolate_Croissant", "Apricot_Danish", "Apple_Danish", "Almond_Twist", "Almond_Bear_Claw", "Blueberry_Danish", "Lemonade", "Raspberry_Lemonade", "Orange_Juice", "Green_Tea", "Bottled_Water", "Hot_Coffee", "Chocolate_Coffee", "Vanilla_Frappuccino", "Cherry_Soda", "Single_Espresso")

#summary 
summary(bakery)

# Drop the number column

bakery_new <- select(bakery, -Transaction_ID, -Almond_Bear_Claw, -Chocolate_Eclair, -Vanilla_Eclair, -Chocolate_Meringue, -Pecan_Tart, -Almond_Tart, -Chocolate_Croissant, -Ganache_Cookie-Vanilla_Meringue, -Almond_Croissant)

# Convert all of the columns to factors
bakery_new[] <- lapply(bakery_new, factor)
summary(bakery_new)
# Association Rule Mining

trans = as(bakery_new, "transactions")
summary(trans)


#Commented out because it have over a million rules
#rules.all <- apriori(trans)
#inspect(rules.all)

# Lower the number of rules
rules <- apriori(trans, parameter= list(minlen=2, supp=0.90, conf=0.9))

quality(rules) <- round(quality(rules), digits=2)
rules.sorted <- sort(rules,by="lift")

#To view the rules, uncomment the line below
#inspect(rules.sorted)

#find redundant rules
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)

#Visualizing the Rules

plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
