# SVM-Monte-Carlo
Simulation to evaluate (by Monte Carlo) the expected misclassification error rate in SVM

A simple model to evaluate the expected test error rate in SVM. Y is equally divided between classes 0 and 1, and X (in R^10) is normally distributed. I fit SVM to a sample of 50 random training points each from classes 1 and 0. I do Monte Carlo simulation of data simulation and R package "e1071" with a default radial kernel. Then I calculate an expected test error rate.
