# The-science-behind-Astrology
This is a statical analysis to study the significance of astrology in determining the physical feature, health and success of individuals.

The three questions that I would like to ask are.

1. *Is there a statistically significant difference in the true mean BMI of the Zodiac signs? In other words, does our Zodiac sign affect our physical feature (Body Mass Index)?*

Dataset - prison dataset of 68,000 prisoners from the Illinois department of correction as of October 2018. I used the height and weight of the dataset to create a new column of BMI with some calculation.
Type of test - I will be using anova test here first and if the anova test indicates that there is any significant difference (p<0.05), then I will proceed to run a TukeyHSD test to compare the true mean difference between each Zodiac sign.

Hypothesis test:
Null hypothesis - There is no difference in the mean body mass index of the Zodiac signs or the difference in true mean of BMI of Zodiac signs is zero.
Alternate hypothesis - The true difference in means between Zodiac signs is either positive or negative.


The next questions are maily aimed at investigate the effect of Zodiac signs on human behaviour and dertermination to work(succeed). Based on these I ask two questions.


2. *Does the status of a prisoner being Absconder or on parole independent of their Zodaic signs? For the purpose of reference - Absocoder is a person who is on a run to avoid arrest for an unlawful action and parole is the release of a prisoner temporarily or permanently before the completion of a sentence, on the promise of good behavior.*

Dataset- prison dataset again. I maily used offender status column for this. This column indicates the status of each prisoner like Temporary resident, Medical furlough, WRIT, parole, absoconder so on. I only selected two of these (parole and absconder) which I thought would indicate the behaviour of the prisoners.

Hypothesis test: Null hypothesis- The prisoners status is independent of their zodiac signs. Alternative hypothesis- There is connection between zodiac signs and prisoner staus (being absconder or parole). In other words, the zodiac signs of the prisoners influences how they behave in prison leading to change in their status.
Type of Test - Chi squared test.


3. *Does the zodiac signs of athletes have any connection to the type of medals (Gold, Silver, or Bronze) that athletes won during olympics.
Dataset- athletes dataset from 2016 olympics in Reo de janerio. The dataset contains the list of the athletes and the number of the trophies they won.*
Hypothesis test:
Null hypothesis - The ratio of each category of trophies is independent of the respective zodiac signs.
Alternative hypothesis - The amount of success achieved by each athlete is related to their zodiac signs in some way.
Type of Test: Chi squared test

## Data clean up

For the first and second question on prison data I did the following data clean up:
*I created a new column of BMI from the height and column of the rows using the BMI formula mass/height^2 (lb/inches^2)
*I changed the date format (birhtdate column) and extract the year out of it so that I can use people of the same age group.
*for the second question I filtered only those rows with offender statues of parole and absconder.
*I removed all the weight less than 97.5lbs because 1. IQR test labled it as an outlier and 2. I assume that people who go to prison are maily adults; hence I believe their weight should be at least greater than 97.5 pounds (which is too small for an adult). I also removed the height less than 53.5 inches for the same reason. ## try removing some more stuff here (BMI>50)

Data clean up for athletics dataset:
*I removed those whose birthdates are after 2003. The youngest athlete to take part in Rio olympics is Gaurika Singh (13 years old) who was born in November 2002. Hence, the rows with birthdates after 2003 are invalid.

# Conclusion-1
According to the boxplot, it looks like there is variation among the range of Body mass index of the zodiac signs. However, in order to reject the null hypothesis and accept the alternate hypothesis, we need to get a p-value of less than 0.05. From the anova test and Tukey HSD test, we got a p-values of 0.55 (>0.05) which indicate that there is no statistically significant differece in mean BMI of the Zodiac signs. Hence, we fail to reject the null hypohtesis.


# Conclusion-2
From the chi squared test we got a p-value of 0.37(>0.05). Hence, we fail to reject the null hypothesis which states that the prisoners status is independent of their zodiac signs.

# Conclussion -3
The chi squared test on Zodiac signs vs type of Trophies table showed a p-value of 0.7338 (again >0.05). Therefore, eventhough it looks like there is some variation among the number of medals won by people born in different times, it is not statistically significant for us to come to conclussion. Again, we fail to reject the null hypothesis.

In general, we do not have evidence to prove that there is any connection between Zodiac signs and physical appearance, behaviour and success (determination to work).


![Astrology poster](https://user-images.githubusercontent.com/62855279/139428457-2c0fe8de-55d7-4730-9bc7-1a4202cceaf0.jpg)

Find a good quality pdf here - [Astrology.pdf](https://github.com/Tesfa-eth/The-science-behind-Astrology/files/7441622/Astrology.pdf)
