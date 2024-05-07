SELECT * FROM corona_virus;

-- Write a code to check NULL values

SELECT *
FROM corona_virus
WHERE 
	Province IS NULL OR
    `Country/Region` IS NULL OR
    Latitude IS NULL OR
    Longitude IS NULL OR
    Date IS NULL OR
    Confirmed IS NULL OR
    Deaths IS NULL OR
    Recovered IS NULL;

-- If NULL values are present, update them with zeros for all columns. 

UPDATE corona_virus
SET 
	Province = COALESCE(Province, 0),
    `Country/Region` = COALESCE(`Country/Region`, 0),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
    Date = COALESCE(Date, 0),
    Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0);
        
-- check total number of rows

SELECT COUNT(*) FROM corona_virus;

-- Check what is start_date and end_date

SELECT 
	MIN(Date) AS start_date ,
	MAX(Date) AS end_date
FROM corona_virus;

-- Number of month present in dataset

SELECT 
	YEAR(Date) as Year,
	COUNT(DISTINCT MONTH(Date)) AS num_months 
FROM corona_virus 
GROUP BY Year;

-- Find monthly average for confirmed, deaths, recovered

SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    AVG(Confirmed) AS Avg_confirmed,
    AVG(Deaths) AS Avg_deaths,
    AVG(Recovered) AS Avg_recovered
FROM corona_virus
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

-- Find most frequent value for confirmed, deaths, recovered each month 

SELECT
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(Confirmed) AS Value_confirmed,
    COUNT(Deaths) AS Value_deaths,
    COUNT(Recovered) AS Value_recovered
FROM corona_virus
GROUP BY Year , Month
ORDER BY value_confirmed DESC;
    
-- Find minimum values for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS Year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM corona_virus
GROUP BY YEAR(Date)
ORDER BY Year;

-- Find maximum values for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS Year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM corona_virus
GROUP BY YEAR(Date)
ORDER BY Year;

-- The total number of case of confirmed, deaths, recovered each month

SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM corona_virus
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

-- Check how corona virus spread out with respect to confirmed case
				-- Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Confirmed)  AS total_confirmed_cases,
    ROUND(AVG(Confirmed),2)  AS average_confirmed_cases,
    ROUND(VARIANCE(Confirmed),2) AS variance_confirmed_cases,
    ROUND(STDDEV(Confirmed),2)  AS std_confirmed_cases
FROM corona_virus 
GROUP BY Year, Month 
ORDER BY Year, Month;


-- Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Deaths)  AS total_death_cases,
    ROUND(AVG(Deaths),2)  AS average_death_cases,
    ROUND(VARIANCE(Deaths),2) AS variance_death_cases,
    ROUND(STDDEV(Deaths),2)  AS std_death_cases
FROM corona_virus 
GROUP BY Year, Month 
ORDER BY Year, Month;

-- Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
	YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Recovered)  AS total_recovered_cases,
    ROUND(AVG(Recovered),2)  AS average_recovered_cases,
    ROUND(VARIANCE(Recovered),2) AS variance_recovered_cases,
    ROUND(STDDEV(Recovered),2)  AS std_recovered_cases
FROM corona_virus 
GROUP BY Year, Month 
ORDER BY Year, Month;

-- Find Country having highest number of the Confirmed case

SELECT 
    `Country/Region` AS Country,
    SUM(Confirmed) AS total_confirmed_cases
FROM corona_virus
GROUP BY `Country/Region`
ORDER BY total_confirmed_cases DESC
LIMIT 1;

-- Find Country having lowest number of the death case

SELECT 
    `Country/Region` AS Country,
    SUM(Deaths) AS total_death_cases
FROM corona_virus
GROUP BY `Country/Region`
ORDER BY total_death_cases ASC
LIMIT 4;

-- Find top 5 countries having highest recovered case

SELECT 
    `Country/Region` AS country,
    SUM(Recovered) AS total_recovered_cases
FROM corona_virus
GROUP BY `Country/Region`
ORDER BY total_recovered_cases DESC
LIMIT 5;
