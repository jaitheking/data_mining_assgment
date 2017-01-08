#install.packages("dplyr") for dropping columns
library("dplyr")
#install.packages("arules") for applying Apriori algorithms
library(arules)
#install.packages("arulesViz") for visualizing the rules created
library(arulesViz)

#Load the dataset as a dataframe
bakery <- read.csv(file= "Part_2/1000-out1.csv", header = FALSE)

#Drop first column
bakery <- bakery[,2:7]

#Add headers
#colnames(bakery) <- c("First_Item", "Second_Item", "Third_Item", "Fourth_Item", "Fifth_Item", "Sixth_Item")

# Renaming the values accordingly to the codes for convenience. Can be commented out.
bakery[bakery=="0"]<-"Chocolate_Cake"
bakery[bakery=="1"]<-"Lemon_Cake"
bakery[bakery=="2"]<-"Casino_Cake"
bakery[bakery=="3"]<-"Opera_Cake"
bakery[bakery=="4"]<-"Strawberry_Cake"
bakery[bakery=="5"]<-"Truffle_Cake"
bakery[bakery=="6"]<-"Chocolate_Eclair"
bakery[bakery=="7"]<-"Coffee_Eclair"
bakery[bakery=="8"]<-"Vanilla_Eclair"
bakery[bakery=="9"]<-"Napoleon_Cake"
bakery[bakery=="10"]<-"Almond_Tart"
bakery[bakery=="11"]<-"Apple Pie"
bakery[bakery=="12"]<-"Apple_Tart"
bakery[bakery=="13"]<-"Apricot_Tart"
bakery[bakery=="14"]<-"Berry_Tart"
bakery[bakery=="15"]<-"Blackberry_Tart"
bakery[bakery=="16"]<-"Blueberry_Tart"
bakery[bakery=="17"]<-"Chocolate_Tart"
bakery[bakery=="18"]<-"Cherry_Tart"
bakery[bakery=="19"]<-"Lemon_Tart"
bakery[bakery=="20"]<-"Pecan_Tart"
bakery[bakery=="21"]<-"Ganache_Cookie"
bakery[bakery=="22"]<-"Gongolais_Cookie"
bakery[bakery=="23"]<-"Raspberry_Cookie"
bakery[bakery=="24"]<-"Lemon_Cookie"
bakery[bakery=="25"]<-"Chocolate_Meringue"
bakery[bakery=="26"]<-"Vanilla_Meringue"
bakery[bakery=="27"]<-"Marzipan_Cookie"
bakery[bakery=="28"]<-"Tuile_Cookie"
bakery[bakery=="29"]<-"Walnut_Cookie"
bakery[bakery=="30"]<-"Almond_Croissant"
bakery[bakery=="31"]<-"Apple_Croissant"
bakery[bakery=="32"]<-"Apricot_Croissant"
bakery[bakery=="33"]<-"Cheese_Croissant"
bakery[bakery=="34"]<-"Chocolate_Croissant"
bakery[bakery=="35"]<-"Apricot_Danish"
bakery[bakery=="36"]<-"Apple_Danish"
bakery[bakery=="37"]<-"Almond_Twist"
bakery[bakery=="38"]<-"Almond_Bear_Claw"
bakery[bakery=="39"]<-"Blueberry_Danish"
bakery[bakery=="40"]<-"Lemonade"
bakery[bakery=="41"]<-"Raspberry_Lemonade"
bakery[bakery=="42"]<-"Orange_Juie"
bakery[bakery=="43"]<-"Green_Tea"
bakery[bakery=="44"]<-"Bottled_Water"
bakery[bakery=="45"]<-"Hot_Coffee"
bakery[bakery=="46"]<-"Chocolate_Coffee"
bakery[bakery=="47"]<-"Vanilla_Frappuccino"
bakery[bakery=="48"]<-"Cherry_Soda"
bakery[bakery=="49"]<-"Single_Espresso"

#Convert all of the columns into factor structure type
bakery[] <- lapply(bakery, factor)

#Display the summary of the bakery dataframe
summary(bakery)

# Association Rule Mining
bakery_trans <- as(bakery, "transactions")


# Lower the number of rules
rules <- apriori(bakery_trans, parameter= list(minlen=3, supp=0.01, conf=0.75))

quality(rules) <- round(quality(rules), digits=2)
rules.sorted <- sort(rules,by="confidence")

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
plot(rules.pruned, method="paracoord", control=list(reorder= TRUE))

