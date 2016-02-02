rm(list = ls())

library (tseries)
library (xts)
library (zoo)
library (quantmod)
library (neuralnet)

symbol <- readline("Choose the Stock you want to predict: ")
