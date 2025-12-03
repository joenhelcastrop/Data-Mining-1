#Install and Load required packages
install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

#Load the built-in Groceries dataset
data("Groceries")
summary(Groceries)

#Find frequent itemsets using Apriori
itemsets <- apriori(Groceries, parameter = list(supp = 0.01, target = "frequent itemsets"))
inspect(head(itemsets, 5))

#Generate association rules
rules <- apriori(Groceries, parameter = list(supp = 0.01, conf = 0.5))
inspect(head(rules, 5))

#Visualize rules with scatterplot
plot(rules, method = "scatterplot", measure = c("support", "confidence"), shading = "lift")

#Visualize rules with graph view
plot(rules, method = "graph", engine = "htmlwidget")

