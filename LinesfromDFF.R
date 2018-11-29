
library(plyr)
library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(tidyr)

update.packages(ask = FALSE, checkBuilt = TRUE)

#### SET FOLDER TO MATCH DESKTOP DESTINATION
# path to folder that holds multiple .csv files

folder <- "/Users/cmetz.GTSCPA/Desktop/MIT/"     
file_list <- list.files(path=folder, pattern="*.csv") # create list of all .csv files in folder
file_list

# read in each .csv file in file_list and create a data frame with the same name as the .csv file
for (i in 1:length(file_list)){
  assign(file_list[i], 
         read.csv(paste(folder, file_list[i], sep=''))
  )}


#rename and then remove the .csv
DK <-DK.csv
slate<-slate.csv
lines<-Lines.csv
DFF<-DFF.csv
team<-team.csv
name<-name.csv
rm(DK.csv, DFF.csv, slate.csv, Lines.csv, team.csv, name.csv)




DFF
lines

DFF$Name <- paste(DFF$first_name, DFF$last_name, sep=' ') 

WTF<- merge(lines,DFF, by = "Name", all.x = TRUE)

WTF

dick<- select(WTF, c(1,8,9,18))
dick

please <- c(dick$ppg_projection)
please[is.na(please)] <- "0" 
please

stop<- data.frame(please, dick)
stop

stop[is.na(stop)] <- "x" 

lick<- select(stop, c(2,3,4,1))

colnames(lick)[1] <- "Name"
colnames(lick)[2] <- "Line"
colnames(lick)[3] <- "Power_Play"
colnames(lick)[4] <- "Projection"
lick

write.csv(lick, file="C:/Users/cmetz.GTSCPA/Desktop/MIT/Lines.csv", row.names = FALSE)
