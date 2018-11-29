
library(plyr)
library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(tidyr)



source('~/Hockey/DFS/LinesfromDFF.R')

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

rm(DK.csv, DFF.csv, slate.csv, Lines.csv)


#rename the wings to just "W"

DK$Position<-recode(DK$Position, "RW" = "W", "LW"="W")

#Reogranize the data and rename fields to match JuliaCode

colnames(DK)[3] <- "Last Name"
colnames(DK)[8] <- "Team"
colnames(DK)[9] <- "Points"
colnames(DK)[2] <- "Justid"

####  GOALIE CODE GOES HERE ######

#FILTER FOR GOALIE
G <- filter(DK, Position == "G") 

#eXTRACT dk GOALIE DATA
Go<-select(G, c(4,6,8,9,3,2))
Go

#CREATE first name field and fill with John
Go[,"First Name"] <- ""

#Reogranize the data and rename fields to match JuliaCode
Goa <- select(Go,c(7,6,1,2,3,4,5))
Goa
#combine the days gamse to get opponent into the DK data - Also captures the probable starters
goalieslate<- left_join(Goa,slate, by = "Team")
goalieslate

#compares strings to DK and Slate so that only probables can be filtered
goalieslate[,"Starter"] <- as.character(goalieslate$'Last Name') == as.character(goalieslate$Goalie)

#filter for probable goalies       
goalies <-filter(goalieslate, Starter == TRUE)
goalies

#remove projection and put in the betting model
#reorganize to match JuliaCode

example_goalie<-select(goalies, c(1,7,4,5,8,10))
colnames(example_goalie)[6] <- "Projection"
example_goalie


#Write to file for Julia
write.csv(example_goalie, file="C:/Users/cmetz.GTSCPA/AppData/Local/Julia-1.0.1/example_goalies.csv", row.names = FALSE)


str(lines)


####  FORWARD CODE GOES HERE ######

f <- filter(DK,str_detect(Position, "C") | str_detect(Position, "W") | str_detect(Position, "D"))
f

#rename lines to Last Name
colnames(lines)[1] <- "Last Name"



#joing for opponent
fslate<- left_join(f,slate, by = "Team")


fslate[,"First Name"] <- ""                             
fo <- select(fslate, c(13,3,1,6,8,10,9))
flines <-left_join(fo,lines, by.x = "Last Name")

forwards <-select(flines, c(1,2,4,3,5,6,8,9,10))
forwards

#forwards[,"Starter"] <- as.character(forwards$'Line') != as.character("x")
#forwards$Starter<- as.character(forwards$Starter)
#forwards$Projection[forwards$Starter == "FALSE"] <- 0

removalprocess<-forwards
pumpkin <- na.omit(removalprocess)

write.csv(pumpkin, file="C:/Users/cmetz.GTSCPA/AppData/Local/Julia-1.0.1/example_skaters.csv", row.names = FALSE)

