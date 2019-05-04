
#install.packages("devtools")
library(devtools)
install_github("onnokleen/alfred")
library(alfred)

# Download fixed residential investment  releases from Jan 2017 to June 2018.

df <- get_alfred_series("FPI","fpi",  
                      observation_start = "1959-01-01", 
                      realtime_start = "1965-08-01",
                      realtime_end = "2018-08-04")
library(tidyr)

tmp <-spread(df, realtime_period, fpi)


#install.packages("xlsx")
library(xlsx)
write.xlsx(tmp, "fpi_rt.xlsx")

