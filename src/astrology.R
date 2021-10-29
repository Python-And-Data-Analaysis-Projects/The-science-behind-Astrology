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

#' The two questions that I would like to ask are.
#' 
#' 
#' 1. Is there a statistically significant difference in the true mean BMI of the Zodiac signs? In other words, does our Zodiac sign affect our physical feature (Body Mass Index)?
#' 
#' Dataset - prison dataset of 68,000 prisoners from the Illinois department of correction as of October 2018. I used the height and weight of the dataset to create a new column of BMI with some calculation.
#' Type of test - I will be using anova test here first and if the anova test indicates that there is any significant difference (p<0.05), then I will proceed to run a TukeyHSD test to compare the true mean difference between each Zodiac sign.
#' 
#' Hypothesis test:
#' Null hypothesis - There is no difference in the mean body mass index of the Zodiac signs or the difference in true mean of BMI of Zodiac signs is zero.
#' Alternate hypothesis - The true difference in means between Zodiac signs is either positive or negative.
#' 
#' 
#' The next questions are maily aimed at investigate the effect of Zodiac signs on human behaviour and dertermination to work(succeed). Based on these I ask two questions.
#' 
#' 
#' 2. Does the status of a prisoner being Absconder or on parole independent of their Zodaic signs? For the purpose of reference - Absocoder is a person who is on a run to avoid arrest for an unlawful action and parole is the release of a prisoner temporarily or permanently before the completion of a sentence, on the promise of good behavior.
#' 
#' Dataset- prison dataset again. I maily used offender status column for this. This column indicates the status of each prisoner like Temporary resident, Medical furlough, WRIT, parole, absoconder so on. I only selected two of these (parole and absconder) which I thought would indicate the behaviour of the prisoners.
#' 
#' Hypothesis test: Null hypothesis- The prisoners status is independent of their zodiac signs. Alternative hypothesis- There is connection between zodiac signs and prisoner staus (being absconder or parole). In other words, the zodiac signs of the prisoners influences how they behave in prison leading to change in their status.
#' Type of Test - Chi squared test.
#' 
#' 
#' 3. Does the zodiac signs of athletes have any connection to the type of medals (Gold, Silver, or Bronze) that athletes won during olympics.
#' Dataset- athletes dataset from 2016 olympics in Reo de janerio. The dataset contains the list of the athletes and the number of the trophies they won.
#' Hypothesis test:
#' Null hypothesis - The ratio of each category of trophies is independent of the respective zodiac signs.
#' Alternative hypothesis - The amount of success achieved by each athlete is related to their zodiac signs in some way.
#' Type of Test: Chi squared test
#' 
#' ## Data clean up
#' 
#' For the first and second question on prison data I did the following data clean up:
#' *I created a new column of BMI from the height and column of the rows using the BMI formula mass/height^2 (lb/inches^2)
#' *I changed the date format (birhtdate column) and extract the year out of it so that I can use people of the same age group.
#' *for the second question I filtered only those rows with offender statues of parole and absconder.
#' *I removed all the weight less than 97.5lbs because 1. IQR test labled it as an outlier and 2. I assume that people who go to prison are maily adults; hence I believe their weight should be at least greater than 97.5 pounds (which is too small for an adult). I also removed the height less than 53.5 inches for the same reason. ## try removing some more stuff here (BMI>50)
#' 
#' Data clean up for athletics dataset:
#' *I removed those whose birthdates are after 2003. The youngest athlete to take part in Rio olympics is Gaurika Singh (13 years old) who was born in November 2002. Hence, the rows with birthdates after 2003 are invalid.
#' 
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

#' 
#' # Conclusion-1
#' According to the boxplot, it looks like there is variation among the range of Body mass index of the zodiac signs. However, in order to reject the null hypothesis and accept the alternate hypothesis, we need to get a p-value of less than 0.05. From the anova test and Tukey HSD test, we got a p-values of 0.55 (>0.05) which indicate that there is no statistically significant differece in mean BMI of the Zodiac signs. Hence, we fail to reject the null hypohtesis.
#' 
#' 
#' # Conclusion-2
#' From the chi squared test we got a p-value of 0.37(>0.05). Hence, we fail to reject the null hypothesis which states that the prisoners status is independent of their zodiac signs.
#' 
#' # Conclussion -3
#' The chi squared test on Zodiac signs vs type of Trophies table showed a p-value of 0.7338 (again >0.05). Therefore, eventhough it looks like there is some variation among the number of medals won by people born in different times, it is not statistically significant for us to come to conclussion. Again, we fail to reject the null hypothesis.
#' 
#' In general, we do not have evidence to prove that there is any connection between Zodiac signs and physical appearance, behaviour and success (determination to work).