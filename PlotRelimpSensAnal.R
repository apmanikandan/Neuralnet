# install, load package
install.packages(NeuralNetTools)
library(NeuralNetTools)

# create model
#plotnet: Plot a neural interpretation diagram for a neural network object

library(neuralnet)
AND <- c(rep(0, 7), 1)
OR <- c(0, rep(1, 7))

binary_data <- data.frame(expand.grid(c(0, 1), c(0, 1), c(0, 1)), AND, OR)

mod <- neuralnet(AND + OR ~ Var1 + Var2 + Var3, binary_data,
                 hidden = c(6, 12, 8), rep = 10, err.fct = 'ce', linear.output = FALSE)


# plotnet
par(mar = numeric(4), family = 'serif')
plotnet(mod, alpha = 0.6)


#garson: Relative importance of input variables in neural networks using Garson’s algorithm
# create model
library(RSNNS)
data(neuraldat)
x <- neuraldat[, c('X1', 'X2', 'X3')]
y <- neuraldat[, 'Y1']
mod <- mlp(x, y, size = 5)

# garson
garson(mod, 'Y1')


#lekprofile: Conduct a sensitivity analysis of model responses in a neural network 
# to input variables using Lek’s profile method

# create model
library(nnet)
data(neuraldat)
mod <- nnet(Y1 ~ X1 + X2 + X3, data = neuraldat, size = 5)

# lekprofile
lekprofile(mod)
