#Assignment No.2
nums <- c(2,4,5,8)
if(all(nums%%2==0)){
  print("All numbers are even")
} else{
  print("At least 1 number is even")
}

#Assignment No.3
scores <- c(75,82,60,95,40)
if(all(scores>=60)){
  print("All students are passed")
} else{
  print("At least 1 student failed")
}

#Assigment No.3
temp <- c(32,35,29,40,38)
if(all(temp>=30)){
  print("All days were hot.")
} else{
  print("Any day was below 30.")
}

#Activities
#No.1
color <- "green"
result <- switch(color,
                 "red"="Stop",
                 "yellow"="Ready",
                 "green"="Go",
                 "Invalid signal")
print(result)

#No.2
grade <- toupper(readline("Enter your grade (A-F): "))

result <- switch(grade,
                 "A" = "Excellent",
                 "B" = "Good",
                 "C" = "Fair",
                 "D" = "Needs Improvement",
                 "F" = "Fail",
                 "Invalid grade")

print(result)

#No.3
a <- as.numeric(readline("Enter first number: "))
b <- as.numeric(readline("Enter second number: "))

cat("Choose operation:\n1. Add\n2. Subtract\n3. Multiply\n4. Divide\n")
choice <- readline("Enter your choice (1-4): ")

result <- switch(choice,
                 "1" = a+b,
                 "2" = a-b,
                 "3" = a*b,
                 "4" = if (b!=0) a/b else "Cannot divide by zero",
                 "Invalid choice")

print(result)
