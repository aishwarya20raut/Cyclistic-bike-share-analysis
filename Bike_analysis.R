##install required packages
install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")

##load these packages using libaray function
library(tidyverse)
library(lubridate)
library(ggplot2)

##set path
getwd()
setwd("C:/Users/hp/Documents/Capstone Project/bike_analysis_using_R")

##collect data, read file and create new data frame
sept_2023<-read.csv("sept_2023_bike_tripdata.csv")
oct_2023<-read.csv("oct_2023_bike_tripdata.csv")
nov_2023<-read.csv("nov_2023_bike_tripdata.csv")

colnames(sept_2023)
colnames(oct_2023)
colnames(nov_2023)

str(sept_2023)
str(oct_2023)
str(nov_2023)

sept_2023<-mutate(sept_2023,ride_id=as.character(ride_id),
                          rideable_type=as.character(rideable_type))
oct_2023<-mutate(oct_2023,ride_id=as.character(ride_id),
                 rideable_type=as.character(rideable_type))
nov_2023<-mutate(nov_2023,ride_id=as.character(ride_id),
                 rideable_type=as.character(rideable_type))

##combine all three data frames into one 
all_trips<-bind_rows(sept_2023,oct_2023,nov_2023)

save(all_trips)

View(all_trips)
colnames(all_trips)
nrow(all_trips)
dim(all_trips)
head(all_trips)
str(all_trips)
summary(all_trips)

table(all_trips$member_casual)

#create a new column to calculate ride length

all_trips$ride_length<-difftime(all_trips$ended_at,all_trips$started_at)

# separate date into day, month , year and day_of_week
all_trips$date<-as.Date((all_trips$started_at))
all_trips$month<-format(as.Date(all_trips$date),"%m")
all_trips$day<-format(as.Date(all_trips$date),"%d")
all_trips$year<-format(as.Date(all_trips$date),"%Y")
all_trips$day_of_week<-format(as.Date(all_trips$date),"%A")


## Data cleaning ##

#remove rows with NULL values
all_trips_v1<-na.omit(all_trips) 

#remove duplicate row
all_trips_v2<-distinct(all_trips_v1) 

#remove where ride_length is 0 or negative
all_trips_v2<- all_trips_v2[!(all_trips_v2$ride_length <=0),] 

all_trips_v2<-all_trips_v2[!(is.na(all_trips_v2$start_station_name)|all_trips_v2$start_station_name==""),]
all_trips_v2<-all_trips_v2[!(is.na(all_trips_v2$end_station_name)|all_trips_v2$end_station_name==""),]


#remove empty values from ride length and member casual
all_trips_v2<-all_trips_v2[!(is.na(all_trips_v2$ride_length)|all_trips_v2$ride_length==""),]
all_trips_v2<-all_trips_v2[!(is.na(all_trips_v2$member_casual)|all_trips_v2$member_casual==""),]

View(all_trips_v2)
nrow(all_trips_v2)
colnames(all_trips_v2)

#Descriptive analysis on ride_length 

#mean,median,max,min
mean(all_trips_v2$ride_length) 
median(all_trips_v2$ride_length)
max(all_trips_v2$ride_length)
min(all_trips_v2$ride_length)


#compare member and casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual+all_trips_v2$day_of_week, FUN = mean)

all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

#Average ride length per weekday
all_trips_v2 %>% 
  mutate(weekday = wday(started_at,label = TRUE)) %>% 
  group_by(member_casual,weekday) %>% 
  summarise(number_of_rides=n(),
            average_duration=mean(ride_length)) %>% 
  arrange(member_casual,weekday)

#total ride by member type
all_trips_v2 %>% 
  group_by(member_casual) %>% 
  count(member_casual)

#total ride by member type and rideable type
all_trips_v2 %>% 
  group_by(member_casual,rideable_type) %>% 
  count(rideable_type)

#total ride of day of week by rideable and member type
all_trips_v2 %>% 
  group_by(rideable_type,member_casual) %>% 
  count(day_of_week) %>% 
  print(n=28)

# total ride per week of day
all_trips_v2 %>% 
  count(day_of_week)

#average ride length by member type and month
all_trips_v2 %>% 
  group_by(member_casual,month) %>% 
  summarise(avg_ride_length=mean(ride_length))

#most popular start station
all_trips_v2 %>% 
  group_by(start_station_name) %>% 
  summarise(n_station=length(ride_id)) %>% 
  top_n(10) %>% 
  arrange(desc(n_station))

?top_n()

#most popular end station
all_trips_v2 %>%
  group_by(end_station_name,member_casual) %>% 
  summarise(n_station=n()) %>% 
  #top_n(10)%>%
  arrange(desc(n_station))

# Visualization with ggplot
#Total ride by rider type
all_trips_v2 %>% 
  group_by(member_casual,) %>% 
  summarise(no_ride=n())%>%
  ggplot(aes(x="",y=no_ride,fill=member_casual))+geom_bar(stat="identity",width=1,
                                                          color="white")+
  geom_text(aes(label=no_ride),position=position_stack(vjust=0.5))+
  coord_polar("y")+theme_void()+labs(title="Total ride by member and casual",caption="figure 1")

# Average ride length by rider type
all_trips_v2%>%
  group_by(member_casual)%>%
  summarise(avg_ride=mean(ride_length))%>%
  ggplot(aes(x=member_casual,y=avg_ride,fill=member_casual))+geom_col(position="dodge")+
  geom_text(aes(label=avg_ride),position=position_dodge(0.9),vjust=0)+
  labs(title="Average ride length by rider type",
       caption="figure 2",x="Rider type", y="Average ride length in second")

#Visualization for number of rides by rider type
all_trips_v2 %>% 
  mutate(weekday = wday(started_at,label = TRUE)) %>% 
  group_by(member_casual,weekday) %>% 
  summarise(number_of_rides=n(),
            average_duration=mean(ride_length)) %>% 
  arrange(member_casual,weekday) %>% 
  ggplot(aes(x=weekday,y=number_of_rides,fill=member_casual))+geom_col(position ="dodge")

#visualization for average duration of ride length
all_trips_v2 %>% 
  mutate(weekday = wday(started_at,label = TRUE)) %>% 
  group_by(member_casual,weekday) %>% 
  summarise(number_of_rides=n(),
            average_duration=mean(ride_length)) %>% 
  arrange(member_casual,weekday) %>% 
  ggplot(aes(x=weekday,y=average_duration,fill=member_casual))+geom_col(position ="dodge")+
  labs(title ="Average duration per day for rider type",
       caption = "figure 4",x="day of the week",y="average number of trips")

#Total ride per hour
all_trips_v2%>%
  mutate(datetime=ymd_hms(started_at),
         hour=hour(datetime))%>%
  group_by(member_casual, hour)%>%
  summarise(count=length(ride_id))%>%
  ggplot(aes(x=hour,y=count,fill=member_casual))+geom_col(position="dodge")+
  labs(title="Total rides per hour",caption="figure 5",y= "number of rides")

#Total rides per hour  (line graph)
all_trips_v2%>%
  mutate(datetime=ymd_hms(started_at),
         hour=hour(datetime))%>%
  group_by(member_casual, hour)%>%
  summarise(count=length(ride_id))%>%
  ggplot(aes(x=hour,y=count,color=member_casual))+geom_line(size=1.5)+
  labs(title="Total rides per hour", caption="figure 6", x="hours", y="Total rides")+
  ggsave("line_graph.png")

#total ride by rideable type
all_trips_v2 %>% 
  group_by(rideable_type,member_casual) %>% 
  summarise(n_rideble_type=n()) %>% 
  ggplot(aes(x=rideable_type,y=n_rideble_type,fill=member_casual))+geom_col(position = "dodge")

#total ride per month by rider type
all_trips_v2 %>% 
  group_by(member_casual,month) %>% 
  summarise(no_rides=n()) %>%
  ggplot(aes(x=month,y=no_rides,fill=member_casual))+geom_col(position = "dodge")

#Average ride length per month
all_trips_v2 %>% 
  group_by(member_casual,month) %>% 
  summarise(avg_ride=mean(ride_length)) %>% 
  ggplot(aes(x=month,y=avg_ride,fill=member_casual))+geom_col(position = "dodge")+
  facet_wrap(~month)

#Average ride length per day
all_trips_v2 %>% 
  group_by(member_casual,day) %>% 
  summarise(avg_duration_day=mean(ride_length),
            no_trip_per_day=n(),
            total_duration_day=sum(ride_length)) %>% 
  ggplot(aes(x=day,y=avg_duration_day,fill=member_casual))+geom_col(position = "dodge")


#export file to csv
nrow(all_trips_v2)
write.csv(all_trips_v2,"all_data_from_R.csv")




