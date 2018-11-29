#Create Slate

library(plyr)
library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(tidyr)




slate1 <- data.frame(DFF$team, DFF$opp)


cheese<- unique(slate1[, 1:2])
cheese

cheesecorsica<-merge(cheese, name, by.x = "DFF.opp", by.y = "dff", all.x=TRUE)
cheesecorsica



corsicanames<-select(cheesecorsica, c(2,3))
corsicanames

readyplayer<-merge(cheese,name, by.x = "DFF.team", by.y = "dff", all.x = TRUE)

readyplayer

colnames(team)

bare <- select(team, c(Team,GP,GF,GA,SF,SA))

bone<- mutate(bare,
              gf = GF/GP,
              ga = GA/GP,
              sf = SF/GP,
              sa = SA/GP)

bones<- select(bone, c(Team, gf,ga,sf,sa))
bonesreverse<-bones


colnames(bonesreverse)[3] <- "opp.ga"
colnames(bonesreverse)[4] <- "opp.sf"
colnames(bonesreverse)[5] <- "opp.sa"
bonesreverse
cheesecorsica

bon<-merge(bonesreverse, cheesecorsica, by.x = "Team", by.y = "Corsica" )

equalize<- merge(bones,readyplayer, by.x = "Team", by.y = "Corsica" , all.x = TRUE)
equalize


closer<- filter(equalize,DFF.opp != is.na(DFF.opp))
closer

bon

jane <- merge(closer, bon, by = "DFF.opp", all.x = TRUE)
jane

FY<-select(jane, c(15,8,3:6,10:13))
FY

colnames(FY)[1] <- "Team"
colnames(FY)[2] <- "Opponent"
FY

#kak <- mutate(FY,
 #             expG = (gf.x + opp.ga) / 2,
  #            expSF = (sf.y + opp.sa) /2)
kak<-FY

#ka <- select(kak, c(1,2,11,12))
ka <- select(kak, c(1,2))
ka

mark <-  filter(DFF, reg_line == 1, position == "G") 
mark
brick <- select(mark, c(Name, ppg_projection, team))

brick

wall <- merge(brick, cheesecorsica, by.x = "team", by.y = "DFF.team", all.x = TRUE)
wall

brickwall<- select(wall, c(Name,ppg_projection, DraftKing))

brickwall

dayne <- merge(ka, brickwall, by.x = "Team", by.y = "DraftKing", all.x = TRUE )
dayne
wayne <- select(dayne, 2,1,3,4)
wayne
colnames(wayne)[1] <- "Team"
colnames(wayne)[2] <- "Opponent"
colnames(wayne)[3] <- "Goalie"
colnames(wayne)[4] <- "Points"
wayne
write.csv(wayne, file="C:/Users/cmetz.GTSCPA/Desktop/MIT/slate.csv", row.names = FALSE)
