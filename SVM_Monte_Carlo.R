rm(list=ls())
library(MASS)
library(e1071)

N <- 50
y0 <- rep(0, N)
y1 <- rep(1, N)

mu0 <- rep(0, 10)
mu1 <- c(1,1,1,1,1,0,0,0,0,0)
sigma <- diag(10)

test_data <- function(fit){
  N_test <- 50000
  x0 <- mvrnorm(N_test, mu0, sigma)
  x1 <- mvrnorm(N_test, mu1, sigma)
  X <- data.frame(rbind(x0,x1))
  y0 <- rep(0, N_test)
  y1 <- rep(1, N_test)
  Y <- rbind(as.matrix(y0),as.matrix(y1))
  Y_pred0 <- predict(fit, X)
  Y_pred <- (Y_pred0 >= 0.5)
  error <- abs(Y - Y_pred)
  test_error <- sum(error)/(N_test*2)
  return(test_error)
}

one_run <- function() {
  x0 <- mvrnorm(N, mu0, sigma)
  x1 <- mvrnorm(N, mu1, sigma)
  
  Y <- rbind(as.matrix(y0),as.matrix(y1))
  X <- data.frame(rbind(x0,x1))
  
  fit <- svm(Y ~ ., data = X)
  Y_pred0 <- predict(fit, X)
  Y_pred <- (Y_pred0 >= 0.5)
  error <- abs(Y - Y_pred)
  tr_error <- sum(error)
  
  return(test_data(fit))
}

te <- rep(0,100)
for (i in 1:100){
  te[i] <- one_run()
  print(i)
}

mte <- mean(te)
