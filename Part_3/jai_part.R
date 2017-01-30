d1=read.table("student-mat.csv",sep=";",header=TRUE)
#d2=read.table("student-por.csv",sep=";",header=TRUE)

#d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu"
#,"Fedu","Mjob","Fjob","reason","nursery","internet"))
#print(nrow(d3)) # 382 students


str(d1)
summary(d1)

install.packages("dplyr")
library(dplyr)
student_pre <- select(d1, -school, -address, -famsize, -Pstatus, -Medu, -Fedu, -Mjob, -Fjob, -reason, -guardian, -traveltime, -nursery, -higher)

#ANN 
install.packages("neuralnet")
library(neuralnet)
names(student_pre)

# Convert factors to integers
str(student_pre)

student_pre$schoolsup <- as.character(student_pre$schoolsup)
student_pre$famsup <- as.character(student_pre$famsup)
student_pre$paid<- as.character(student_pre$paid)
student_pre$activities <- as.character(student_pre$activities)
student_pre$internet <- as.character(student_pre$internet)
student_pre$romantic <- as.character(student_pre$romantic)

student_pre[student_pre=="no"]<-0
student_pre[student_pre=="yes"]<-1

student_pre$sex <- as.integer(student_pre$sex)
student_pre$schoolsup <- as.integer(student_pre$schoolsup)
student_pre$famsup <- as.integer(student_pre$famsup)
student_pre$paid<- as.integer(student_pre$paid)
student_pre$activities <- as.integer(student_pre$activities)
student_pre$internet <- as.integer(student_pre$internet)
student_pre$romantic <- as.integer(student_pre$romantic)


str(student_pre)

#Split the dataset
set.seed(500)
install.packages("MASS")
library(MASS)

index <- sample(1:nrow(student_pre),round(0.75*nrow(student_pre)))

train<-student_pre[index,]
test<-student_pre[-index,]
lm.fit <- glm(G3~., data=train)
pr.lm <- predict(lm.fit,test)
MSE.lm <- sum((pr.lm - test$medv)^2)/nrow(test)

#Normalize data
maxs <- apply(student_pre, 2, max)
mins <- apply(student_pre, 2, min)
scaled <- as.data.frame(scale(student_pre, center = mins, scale = maxs - mins))
train_ <-scaled[index,]
test_ <-scaled[-index,]



#Train Neural Net
library(neuralnet)

n <- names(train_)
f <- as.formula(paste("G3 ~", paste(n[!n %in% "G3"], collapse = " + ")))
nn <- neuralnet(f,data=train_,hidden=c(5,3),linear.output=F)

plot(nn)

#predict G3
head(nn)
pr.nn <- compute(nn,test_[,c("sex", "age", "studytime", "failures", "schoolsup", "famsup", "paid", "activities", "internet", "romantic", "famrel", "freetime", "goout", "Dalc", "Walc", "health", "absences", "G1",    "G2" )])



pr.nn_ <- pr.nn$net.result*(max(student_pre$G3)-min(student_pre$G3))+min(student_pre$G3)
test.r <- (student_pre$G3data$medv)

MSE.nn <- sum((test.r - pr.nn_)^2)/nrow(test_)


#Confusion Matrix
table(test_$G3)
sort(pr.nn$net.result,decreasing = T)[914]
pr.nn.level <- ifelse(pr.nn$net.result >0.5,1,0)

table(pr.nn.level)


