d1=read.table("student-mat.csv",sep=";",header=TRUE)
#d2=read.table("student-por.csv",sep=";",header=TRUE)

#d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu"
#,"Fedu","Mjob","Fjob","reason","nursery","internet"))
#print(nrow(d3)) # 382 students

str(d1)
summary(d1)

#install.packages("dplyr")
library(dplyr)
student_pre <- select(d1, -school,-address, -famsize, -Pstatus, -Medu, -Fedu, -Mjob, -Fjob, -reason,-guardian, -traveltime, -nursery, -higher)


#Kevin's part
install.packages("e1071")
library(e1071)
attach(student_pre)

#setting data
range(G3)
High = ifelse(G3 >=10, "Yes", "No")
student_pre = data.frame(student_pre, High)

#Remove all integer columns
student_pre <- student_pre[, sapply(student_pre, class) != "integer"]

#splitting data
train = sample(1:nrow(student_pre), nrow(student_pre)/2)
test = -train
training_data = student_pre[train,]
testing_data = student_pre[test,]
testing_High = High[test]

#Estimating Naive Bayes model
classifier <- naiveBayes(High~., training_data)
classifier

