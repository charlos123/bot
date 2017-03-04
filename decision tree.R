
# Classification Tree with rpart
library(rpart)

mydata = read.csv("./Downloads/ProM-DataSet-week1/food-poisoning.csv")

formula = as.formula(paste("class ~ ", paste(head(colnames(mydata), -1), collapse= "+")))




# grow tree 
fit <- rpart(
  formula,
  control=rpart.control(cp=0.0001),
  method="class", 
  data=mydata)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# plot tree 
plot(fit, uniform=TRUE, 
     main="Classification Tree for Kyphosis")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# create attractive postscript plot of tree 
post(fit, file = "tree.ps", 
     title = "Classification Tree for Kyphosis")

