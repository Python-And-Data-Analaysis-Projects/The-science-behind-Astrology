# The-science-behind-Astrology
This is a statical analysis to study the significance of astrology in determining the physical feature, health and behavior of individuals.

The three questions that I would like to ask are.

1. *Is there a statistically significant difference in the true mean BMI of the Zodiac signs? In other words, does our Zodiac sign affect our physical feature (Body Mass Index)?*

Dataset - prison dataset of 68,000 prisoners from the Illinois department of correction as of October 2018. I used the height and weight of the dataset to create a new column of BMI with some calculation.
Type of test - I will be using anova test here first and if the anova test indicates that there is any significant difference (p<0.05), then I will proceed to run a TukeyHSD test to compare the true mean difference between each Zodiac sign.

Hypothesis test:
Null hypothesis - There is no difference in the mean body mass index of the Zodiac signs or the difference in true mean of BMI of Zodiac signs is zero.
Alternate hypothesis - The true difference in means between Zodiac signs is either positive or negative.


The next questions are maily aimed at investigate the effect of Zodiac signs on human behaviour and dertermination to work(succeed). Based on these I ask two questions.


2. Does the status of a prisoner being Absconder or on parole independent of their Zodaic signs? For the purpose of reference - Absocoder is a person who is on a run to avoid arrest for an unlawful action and parole is the release of a prisoner temporarily or permanently before the completion of a sentence, on the promise of good behavior.

Dataset- prison dataset again. I maily used offender status column for this. This column indicates the status of each prisoner like Temporary resident, Medical furlough, WRIT, parole, absoconder so on. I only selected two of these (parole and absconder) which I thought would indicate the behaviour of the prisoners.

Hypothesis test: Null hypothesis- The prisoners status is independent of their zodiac signs. Alternative hypothesis- There is connection between zodiac signs and prisoner staus (being absconder or parole). In other words, the zodiac signs of the prisoners influences how they behave in prison leading to change in their status.
Type of Test - Chi squared test.


3. Does the zodiac signs of athletes have any connection to the type of medals (Gold, Silver, or Bronze) that athletes won during olympics.
Dataset- athletes dataset from 2016 olympics in Reo de janerio. The dataset contains the list of the athletes and the number of the trophies they won.
Hypothesis test:
Null hypothesis - The ratio of each category of trophies is independent of the respective zodiac signs.
Alternative hypothesis - The amount of success achieved by each athlete is related to their zodiac signs in some way.
Type of Test: Chi squared test
