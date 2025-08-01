# install.packages('ggplot2') 
library(ggplot2)
ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()

x <- c(10, 20, 30)
y <-  c('e', 'f', 'g')
z <-  c(FALSE, TRUE, FALSE, TRUE)
x
y
z

value05 <- rep(8, times = 4)
value05
value08 <- rep(c('a','b','c'), each = 3)
value08

attendance <- c(10, 7, 9,8,5)
attendance

names(attendance)
names(attendance) <-  c("mon", 'tue')
attendance

salary <- c(340, 220, 380, 140)
names(salary) <-  c('may', 'june', 'july', 'august')
salary
salary[1]
salary['june']
salary[c('may', 'august')]

value01 <- c(1, 10, 7, 8, 9)
value01
value01[2] <- 3
value01
value01[c(1, 5)] <- c(100, 200) 
value01
value01 <- c(100, 200, 300)
value01


x <-  c(1,2 )
y <- 4*x+1
y
x <- c(1,2,3,4,5)
y <- sum(x)
y
a <- c(1,10,7,2,3)
sort(a)
sort(a, decreasing = TRUE)

sort(x=a, decreasing = FALSE)
sort(a, FALSE)

num <- c(4,2,3,1,10,6,9,8,7,5)
length(num)
sum(num)
sum(2*num)
max(num)
min(num)
mean(num[1:5])
sort(num)
sort(num, decreasing = FALSE)
sort(num, decreasing = TRUE)

value01 <- median(num)
value01
value02 <- sum(num)/length(num)
value02
num <- 10:20
num >= 15
num[num>15]
sum(num>15) # 15보다 큰 값의 개수를 출력 

sum(num[num>15])
hobby.list <- c('board game', 'wathc a movi', 'reading books')

info <- list(name='jun', age=21, student=FALSE, hobby=hobby.list)
info
info[1]
info$name
info[[4]]

mat <- matrix(1:25, nrow=5, ncol=5)
mat

mat2 <- matrix(1:25, nrow=5, ncol=5, byrow = T)
mat2
v1 <- 4:9
v2 <- 10:15
mat1 <- cbind(v1, v2)
mat1
mat2 <- rbind(v1, v2)
mat2
mat3 <- rbind(mat2, v1)
mat3
mat <- matrix(1:36, nrow = 6, ncol = 6)
mat4 <- cbind(mat, v1)
mat4
mat <- matrix(1:36, nrow=6, ncol= 6)
mat[1,4]
mat[2,]
