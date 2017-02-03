d1=read.table("student-mat.csv",sep=";",header=TRUE)
#d2=read.table("student-por.csv",sep=";",header=TRUE)

#d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu"
#,"Fedu","Mjob","Fjob","reason","nursery","internet"))
#print(nrow(d3)) # 382 students

str(d1)
summary(d1)

install.packages("dplyr")
library(dplyr)
student_pre <- select(d1, -school,-address, -famsize, -Pstatus, -Medu, -Fedu, -Mjob, -Fjob, -reason,-guardian, -traveltime, -nursery, -higher)

#marak's part
#install.packages("ISLR")
#install.packages("tree")
library(ISLR)
library(tree)

attach(student_pre)

#setting data
range(G3)
High = ifelse(G3 >=10, "Yes", "No")
student_pre = data.frame(student_pre, High)
student_pre <- select(student_pre, -G1, -G2, -G3)

#splitting data
train = sample(1:nrow(student_pre), nrow(student_pre)/2)
test = -train
training_data = student_pre[train,]
testing_data = student_pre[test,]
testing_High = High[test]

#plotting tree
tree_model = tree(High~., training_data)
plot(tree_model)
text(tree_model, pretty = 0)

#cross validation
cv_tree = cv.tree(tree_model, FUN = prune.misclass)
plot(cv_tree$size, cv_tree$dev, type = "b")

#prune tree
pruned_model = prune.misclass(tree_model, best = 9)
plot(pruned_model)
text(pruned_model, pretty = 0)

#checking
tree_pred = predict(pruned_model, testing_data, type = "class")
mean(tree_pred != testing_High)