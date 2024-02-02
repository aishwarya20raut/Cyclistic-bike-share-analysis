# Cyclistic-bike-share-analysis

## Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## About Company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are
geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to
any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One
approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and
annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who
purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing
flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to
future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good
chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have
chosen Cyclistic for their mobility needs

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do
that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual
riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in
analyzing the Cyclistic historical bike trip data to identify trends.

### 🔗 Links
- [**Kaggle Notebook**](https://www.kaggle.com/code/aishwaryaraut20/cyclistic-bike-share-analysis)
- [**Tableau dashboard**](https://public.tableau.com/app/profile/aishwarya.raut7514/viz/bike_share_17044542128940/Dashboard1)

## Phase 1: Ask
## Key Objectives
### 1.Identify the business task:
*  Analyze cyclistic trip data to understand how casual riders and annual members use bikes differently.Customers who purchase single-ride or full-day passes are referred to as casual riders and Customers who purchase annual memberships are Cyclistic members.Insights gained from this analysis will help the marketing team develop their strategies for the campaign
### 2.Consider key stakeholders: We make sure we fully understand the stakeholders expectations.
* Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
* Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
* Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.
### 3.The business task - To Find and Identify how members and casual riders use Cyclistic Bike differently

## Phase 2: Prepare
* The data has been made available by Motivate International Inc. [data](https://divvy-tripdata.s3.amazonaws.com/index.html) is available here under this [license](https://divvybikes.com/data-license-agreement) And separated by month.
* I utilized Cyclistic's historical trip data from the 9th to the 11th month of 2023 for analysis.
* In Prepare phase, we’ll verifiy our data source integrity, credibility and reliability.
* Downloaded that file in excel Then collect and store the data for use in my analysis. stored all files in folder and save it for further analysis
* All 3 files containing data on all rides for each month have the same structure of 13 columns. Save the excel file as csv file for further analysis.

## Phase 3: Process
Here, we do more cleaning. Combining datasets and transforming it to make our information more useful for analysis. This includes removing inconsistencies, outliers, typos etc that could skew our analysis.

**Excel**

* The data cleaning process was initiated by opening each .csv file in Excel and performing the following actions.
  1. Remove duplicates
  2. Added two columns 'ride_length' and 'day_of_week' to calculate length of each ride by substracting the column 'started_at' from 'ended_at'and formatted as HH:MM:SS
  3. day of week that each ride started using the 'WEEKDAY' function and formatted as general to represent day as integer
  4. Remove null values and extra spaces
  5. Remove ride length where length is 0 or negative

for further analysis I choose R the reason I moved to R from excel mainly is because we need to combine three file into one and they won’t fit in excel . excel has a 
maximum capacity of about 1 million rows   
For libraries and functions I used in R, you can view my [R-script](https://github.com/aishwarya20raut/Cyclistic-bike-share-analysis/blob/main/Bike_analysis.R)

Because of the size of each .csv file I perform some queries in SQL for cleaning and analysis in a more efficient way.All SQL queries can be found [here](https://github.com/aishwarya20raut/Cyclistic-bike-share-analysis/blob/main/bike_sharing_analysis.sql)

## Phase 4: Analyze 
In the Analyze phase, basically we try to make sense of our processed data. We transform and organize it into useful information. So that we can draw conclusions, make predictions and drive informed decision making

* 1.Identify trends and relationships:
  * We have now a complete data frame with all the info we need to identify the differences in behaviour between the casual and the member users.

## Phase 5: Share
I choose Tableau
* With Tableau, You explore, play with, filter, mix, match and generate visuals from the data to make complex concepts and numbers easier to see and understand.
* In the share phase, we’ll interpret the results of our analysis and share our key findings and recommendations to help stakeholders make data-driven decisions.
  
 You can find the dashboard I created for this project on Tableau [here](https://public.tableau.com/app/profile/aishwarya.raut7514/viz/bike_share_17044542128940/Dashboard1)


![Dashboard 1](https://github.com/aishwarya20raut/Cyclistic-bike-share-analysis/assets/101623635/a54f16ed-5dc0-4f38-ad84-2abe963bd5d3)

 

## Phase 6: Act
This is the final phase in Data Analysis. Here, we take all of the insights we’ve got from our data and put them to work to solve the original business case: To show how Annual Members and Casual Riders use Cyclistic bikes differently so that our stakeholders can create marketing strategies to convert casual riders to annual members for the company to earn more money. 

I came up with the following key findings and recommendations based on my analysis, which I believe will help the marketing team create an effective campaign to convert casual riders into members.

**Key Findings** 
 * Classic Bikes are the most popular bike among Casual riders and members
 * The Weekends have the longest Average ride length for casual while
 * Members have a relatively consistent average ride length throughout the week
 * The Busiest day of the week is saturday for both member and casual
 * Afternoon is the Busiest time with members having more rides
 * 5AM is the busiest hour for member and casual ,and 8 AM is also busiest time for member
 * September has the most of the rides compared to the other two month for both member and casual
 * Member riders use bike equally thougthout the week for daily commuting
 * Saturday and Sunday have the most rides for casual and on Wednesday member have the most rides

**Recommondation**
* Explore Weekend Discounts-
   Offer exclusive discounts on weekends and extended rides, aiming to convert casual riders into members who can benefit from significant cost savings.
* Waterfront Wonder Promotion: Promote the campaign at the bike station located by the waterfront, a favorite among casual riders, highlighting the advantages of 
  membership.
* Adverties to casuals the benefits of using cyclistic long term as a mode of transport for everyday activities and not as a leisure activity.
Keep track of casuals who are renewing trips for multiple days and adverties to them the cost saving of having an anuual plan for longer trips
