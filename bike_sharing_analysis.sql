use bike_analysis

SELECT * FROM dbo.oct_2023_bike_tripdata;
SELECT * FROM dbo.nov_2023_bike_tripdata;
SELECT * FROM dbo.dec_2023_bike_tripdata;
-----------------------------------------------------
--combine all the table into one--

SELECT * INTO trip_data FROM
(SELECT * FROM dbo.oct_2023_bike_tripdata 
UNION ALL
SELECT * FROM dbo.nov_2023_bike_tripdata
UNION ALL
SELECT * FROM dbo.dec_2023_bike_tripdata)a;

SELECT * FROM trip_data;
------------------------------------------------------------------
--total number oF ROWS 
SELECT COUNT(*) AS Total_records
from trip_data;

------------------------------------------------------
--cleaning data , removing null values 

--checking null values from table
SELECT * FROM trip_data
WHERE ride_id IS  NULL AND
end_station_name IS  NULL;

--removing null values

SELECT * FROM trip_data;

DELETE  FROM trip_data
WHERE ride_id IS  NULL 
OR end_station_name IS  NULL
OR rideable_type IS NULL
OR started_at IS NULL
OR ended_at IS NULL 
OR start_station_name IS NULL
OR start_station_id IS NULL
OR end_station_id IS NULL
OR start_lat IS NULL
OR start_lng IS NULL
OR end_lat IS NULL
OR start_lng IS NULL
OR end_lng IS NULL
OR member_casual IS NULL;
---------------------------------------------
--remove empty values 
DELETE  FROM trip_data
WHERE ride_id =' '
OR end_station_name =' '
OR rideable_type = ' ';
----------------------------------------------------------
SELECT * FROM trip_data;
--checking  duplicate rows  

SELECT ride_id,
COUNT(*) AS TOTAL
FROM trip_data 
GROUP BY ride_id
HAVING COUNT(*) > 1;
----------------------------------------------------------------------------------

--create new table with new column
-- adding new column ride_length 
SELECT * INTO all_trips FROM
(SELECT *,  DATEDIFF (second, started_at , ended_at) AS ride_length
FROM trip_data) a;
 --------------------------------------------------------------------------

 --- adding new col day_of_week
SELECT * INTO all_trip_data FROM
(SELECT *,CASE DATEPART(WEEKDAY,started_at)
		WHEN 1 THEN 'Sunday'
		WHEN 2 THEN 'Monday'
		WHEN 3 THEN 'Tuesday'
		WHEN 4 THEN 'Wednesday'
		WHEN 5 THEN 'Thursday'
		WHEN 6 THEN 'Friday'
		WHEN 7 THEN 'Saturday'
		END AS day_of_week
FROM all_trips)a;

SELECT * FROM all_trip_data;
---------------------------------------------------------
----adding new column month
SELECT * INTO combined_data FROM
(SELECT *,CASE FORMAT(started_at, 'MM') 
		 WHEN 1 THEN 'Jan'
		 WHEN 2 THEN 'Feb'
		 WHEN 3 THEN 'Mar'
		 WHEN 4 THEN 'Apr'
		 WHEN 5 THEN 'May'
		 WHEN 6 THEN 'Jun'
		 WHEN 7 THEN 'Jul'
		 WHEN 8 THEN 'Aug'
		 WHEN 9 THEN 'Sep'
		 WHEN 10 THEN 'Oct'
		 WHEN 11 THEN 'Nov'
		 WHEN 12 THEN 'Dec'
		 END AS month
FROM all_trip_data ) a;

SELECT * FROM combined_data;
---------------------------------------------------------------------------
SELECT COUNT(*) AS TOTAL
FROM trip_data

-- No. of trips per member type
SELECT member_casual,
COUNT(*)AS total
FROM combined_data
GROUP BY member_casual
ORDER BY member_casual

--no of rides per rideable type and member type
SELECT member_casual, rideable_type ,COUNT(*) AS no_trips
FROM combined_data
GROUP BY member_casual, rideable_type
ORDER BY member_casual, no_trips

--average ride length per member type and rideable type
SELECT member_casual , rideable_type ,avg(ride_length) AS avg_ride
FROM combined_data
GROUP BY member_casual, rideable_type
ORDER BY member_casual

--maximun ride length per member casual and rideable type
SELECT member_casual, rideable_type ,MAX(ride_length) AS max_ride_length
FROM combined_data
GROUP BY member_casual, rideable_type
ORDER BY member_casual, max_ride_length

SELECT * FROM combined_data

--no of rides per day of week 
SELECT day_of_week, member_casual , COUNT(*) AS total
FROM combined_data
GROUP BY member_casual, day_of_week
ORDER BY day_of_week, member_casual, total;

--maximun ride length in min per  month and member type
SELECT member_casual,month, ROUND(MAX(ride_length/60),2) AS max_ride_length
FROM combined_data
group by member_casual,month;

--maximum ride length in min per rideable type, month and member type
SELECT member_casual,rideable_type,month,
		MAX(ride_length/60) AS max_ride_length_min
FROM combined_data
GROUP BY member_casual ,rideable_type,month
ORDER BY member_casual ,rideable_type,month;

--maximun ride length per member type
SELECT member_casual, MAX(ride_length) AS max_ride_length
FROM combined_data
GROUP BY member_casual;

SELECT * FROM combined_data;

--CTE function , average ride per hour and member type
WITH total_cte AS 
( SELECT *, FORMAT(started_at, 'HH') AS hour FROM combined_data 
)
SELECT  member_casual,hour ,AVG(ride_length) AS avg_ride_length
FROM  total_cte
GROUP BY member_casual, hour
ORDER BY member_casual, hour;

--most popular start station per rideable type
SELECT * FROM combined_data;

SELECT member_casual, start_station_name,
		AVG(start_lat) AS start_lat,
		AVG(start_lat) AS start_lng,
		COUNT(*) num_of_trips
FROM combined_data
GROUP BY member_casual, start_station_name
ORDER BY member_casual, num_of_trips desc

--most popular end station

SELECT member_casual, end_station_name,
		AVG(start_lat) AS start_lat,
		AVG(start_lat) AS start_lng,
		COUNT(*) num_of_trips
FROM combined_data
GROUP BY member_casual, end_station_name
ORDER BY member_casual, num_of_trips desc;

SELECT * FROM combined_data;

SELECT CAST(day_of_week AS varchar(25))
FROM combined_data

SELECT * FROM combined_data;
