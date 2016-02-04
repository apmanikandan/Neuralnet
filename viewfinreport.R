############################################################
## Using quantmod to view financial report  
##
## manikandan a.p.
############################################################

library(quantmod)
# set a new environment for upcoming data
new.environment <- new.env()
# fetch a NSE stock exchange stock INFY from google
getSymbols("INFY", env = new.environment, src="google",from="2013-10-01", to = "2016-02-02")
# list all data under the new environment.
ls(envir=new.environment)
# print the stock data
get("INFY",envir = new.environment)
# fetch a NYSE stock exchange stock Wipro from google
getSymbols("WIT", env = new.environment, scr="google",from="2012-10-01", to = "2016-02-02")
# set a new value wipro to store the data.
wipro <- get("WIT",envir = new.environment)
# explore the wipro data
head(wipro)
# rename wipro's column names
names(wipro) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
# getting financial reports
getFinancials("WIT")
# it does not work to get the financial report of wipro
viewFinancials(WIT.f)
# it works on APPLE.
getFinancials("AAPL")
viewFinancials(AAPL.f)
