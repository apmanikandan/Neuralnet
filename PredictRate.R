library(neuralnet)
library(NeuralNetTools)
set.seed(12345);
#start with recent data -post dividend
start_date = "2015-09-01"
end_date = as.character(Sys.Date())

#get the historical data 
NIFTY_data <- as.data.frame(get.hist.quote(instrument ="INFY.NS", start = start_date, end = end_date,
                                          quote = c("Open","High", "Low","Close","Volume","AdjClose")))
#write.table(NIFTY_data,file = "STOCKDATA.csv",sep="," ,row.names =TRUE)

date_range <- as.data.frame(row.names(NIFTY_data))

Open_data <- (NIFTY_data$Open)
Close_data <- (NIFTY_data$Close)
High_data <- (NIFTY_data$High)
Low_data <- (NIFTY_data$Low)
Volume_data <- (NIFTY_data$Volume)
AdjClose_data <- (NIFTY_data$AdjClose)

#set the dataframe with relevabt columns together
NIFTY_df <- cbind(Open_data,High_data,Low_data,Close_data,Volume_data,AdjClose_data)

# exclude adjusted close
NIFTY_Actual <- data.frame(NIFTY_df[,-6])

#training data set for the model
train_stock <- (NIFTY_Actual[-(nrow(NIFTY_Actual)),])
trainingoutput_stock <- as.data.frame(NIFTY_Actual[-1,4])


#Column bind the data into one variable
trainingdata_stock <- as.data.frame(cbind(train_stock,trainingoutput_stock))

# train the model with training data set
net_stock <- neuralnet(NIFTY_Actual[-1,4]~(NIFTY_Actual$Open[-(nrow(NIFTY_Actual))] + NIFTY_Actual$High[-(nrow(NIFTY_Actual))] + NIFTY_Actual$Low[-(nrow(NIFTY_Actual))] + NIFTY_Actual$Close[-(nrow(NIFTY_Actual))] + NIFTY_Actual$Volume[-(nrow(NIFTY_Actual))]),
                       trainingdata_stock,err.fct = "sse", hidden=18, threshold=0.001)

#visualise the neuralnetwork - neural interpretation diagram
par(mar = numeric(4), family = 'serif')
plotnet(mod, alpha = 0.6)

testdata <- as.data.frame(NIFTY_Actual[nrow(NIFTY_Actual),])

#Computes the outputs of all neurons for specific arbitrary covariate vectors given a trained neural network
net.results <- compute(net_stock, testdata)
Predicted_Close_Rate<- net.results$net.result
Close_rate<- Predicted_Close_Rate[1,1]

#Close_rate

#library(RSNNS)
# Next steps TBD   
# a ) Relative importance of input variables
# b ) Conduct a sensitivity analysis of model responses
