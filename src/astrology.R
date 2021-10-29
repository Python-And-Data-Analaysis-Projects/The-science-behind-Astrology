#' ---
#' title: "The Science behind Astrology"
#' author: "Tesfatsion Shiferaw"
#' date: "4/24/2020"
#' output: html_document
#' ---
#' 
## ----loadthings, echo=FALSE, message=FALSE---------------------------------
library(mosaic)
library(ggplot2)
library(gplots)
library(dplyr)
library(ggpubr)
library(RColorBrewer)
#library(fivethirtyeight)
#library(plyr)

#' 
## ----import----------------------------------------------------------------
#DO NOT FORGET FEB.29
patients_data <- read.csv("C:/Users/tesfa/Desktop/Creationof_Stats/Final project/patients_data.csv")
prison_data <- read.csv("C:/Users/tesfa/Desktop/Creationof_Stats/Final project/prisoners_data.csv")
athletics_data <- read.csv("C:/Users/tesfa/Desktop/Creationof_Stats/Final project/athletes_data.csv")

## ----data check, filter and clean up---------------------------------------
prison_data['BMI'] <- 703*(prison_data$weight/(prison_data$height*prison_data$height)) #formula of BMI for lb/inches^2
#mean(prison_data$BMI, na.rm=TRUE)
pr_bd <- as.Date(prison_data$date_of_birth, format="%Y-%m-%d") #convert the date format and extract the year.
year = format(pr_bd, "%Y")
year = as.numeric(year)

iqr = IQR(prison_data$weight, na.rm = TRUE)
#summary(prison_data$weight)
#210+1.5*iqr
#165-1.5*iqr

iqr = IQR(prison_data$height, na.rm = TRUE)
#summary(prison_data$height, na.rm = TRUE)
#61-1.5*iqr
#72+1.5*iqr

prison <- prison_data %>% 
  filter(year >=1995 & year <1997) %>%
  filter(weight > 97.5) %>%
  filter(height > 53.5) 

#unique(prison_data$offender_status)
par_abs <- prison_data %>%
  filter(prison_data$offender_status == "PAROLE" | prison_data$offender_status == "ABSCONDER")


at_bd <- as.Date(athletics_data$dob, format="%Y-%m-%d")
year = format(at_bd, "%Y")
year = as.numeric(year)

athletics <- athletics_data %>%
  filter(year < 2003)

#' 
#' ## r.tests
## ----r.tests---------------------------------------------------------------
weight_av = aov(lm(prison$BMI~prison$Zodaic_sign))
summary(weight_av)
#TukeyHSD(weight_av)

pr_table = table(droplevels(par_abs$offender_status),droplevels(par_abs$Zodaic_sign))
chisq.test(pr_table, correct = FALSE)

gold_zod<-aggregate(athletics$gold, by=list(Category=athletics$Zodaic_sign), FUN=sum)
names(gold_zod)[2] <- "Gold"
silver_zod<-aggregate(athletics$silver, by=list(Category=athletics$Zodaic_sign), FUN=sum)
names(silver_zod)[2] <- "Silver"
bronze<- aggregate(athletics$bronze, by=list(Category=athletics$Zodaic_sign), FUN=sum)
names(bronze)[2] <- "bronze"

gold_silv <- merge(gold_zod,silver_zod, by=c("Category"))
Trophies <- merge(gold_silv, bronze, by = c("Category"))
names(Trophies)[1] <- 'Zodiac Signs'
chisq.test(as.matrix(Trophies[,-1]), correct = FALSE)

#' 
#' ## r tables and graphs
## ----tables and graphs-----------------------------------------------------

ggplot(prison, aes(x=prison$Zodaic_sign, y=prison$BMI, fill=prison$Zodaic_sign))+
  geom_boxplot()+ coord_flip() + ggtitle("Zodiac signs Vs BMI") +
  xlab("Zodiac signs") + ylab("Body Mass Index(lb/inches^2)")+labs(fill = "Zodiac signs")

for_matrix = athletics %>% select(Zodaic_sign, gold, silver, bronze)
df = as.data.frame(for_matrix)
mt <- as.matrix(Trophies[,-1])
rownames(mt) <- c("Aquaries", "Aries", "Cancer", "Capriconr", "Germini", "Leo", "Libra", "Pisces", "Saggittarius","Scorpio", "Taurus", "Virgo")
ggballoonplot(mt,  fill = "value", main= "Zodiac signs and Trophies")+
  gradient_fill(c("black", "yellow", color = "#0073C2FF"))

pr_table
