-- Databricks notebook source
SELECT *
FROM brighttv_case_study.bright_tv.bright_tv_user_profiles;

SELECT *
FROM brighttv_case_study.bright_tv.bright_viewership;


WITH bright_tv_user_profiles AS(

SELECT 
    Userid,

        CASE 
             WHEN Province ='None' THEN 'Uncategorized'
             WHEN Province=' ' THEN 'Uncategorized'
             WHEN Province IS NULL THEN 'Uncategorized'
        ELSE Province
        END AS Region,

    AGE,
        CASE 
            WHEN Age = 0 THEN '01.infant: 0'
            WHEN Age BETWEEN 1 AND 12 THEN '02.Kids: 1 - 12'
            WHEN Age BETWEEN 13 AND 17 THEN '03.youth: 13 - 17'
            WHEN Age BETWEEN 18 AND 35 THEN '04.youth Adults: 18 - 35'
            WHEN Age BETWEEN 36 AND 50 THEN '05.Adults: 36 - 50'
            WHEN Age > 50 AND Age<=60 THEN '06.Elder: 51 -60'
            WHEN Age > 60 THEN '07.Pensioner: >60'
        END AS Age_Group,

        CASE
            WHEN (Email IS NOT NULL) OR (EMAIL <> '') OR (EMAIL NOT IN ('None', 'other')) THEN 1
        ELSE 0
        END AS Email_flag,
      CASE
            WHEN (`Social Media Handle` IS NOT NULL) OR (`Social Media Handle` <> '') OR (`Social Media Handle` NOT IN ('None', 'other')) THEN 1 
     ELSE 0 
     END AS socialmedia_flag,
        CASE
            WHEN Gender='None' THEN 'Unknown'
            WHEN Gender=' 'THEN 'Unknown'
            WHEN Gender IS NULL THEN 'Unknown'
     ELSE Gender
     END AS Gender,

  
CASE 
   WHEN race='other' THEN 'Unknown' 
   WHEN race= 'None' THEN 'Unknown'
   WHEN race=' 'THEN 'Unknown'
   ELSE race 
   END AS Ethnicity
FROM brighttv_case_study.bright_tv.bright_tv_user_profiles),

bright_viewership AS (
  SELECT 
    COALESCE(UserID0, userid4) AS UserID,
    DATE_FORMAT(RecordDate2, 'yyyy-MM') AS Month_id,
    TO_DATE(RecordDate2) AS watch_date,
    DATE_FORMAT(RecordDate2, 'HH:mm:ss') AS watch_time,
    DATE_FORMAT(RecordDate2, 'dd') AS day_of_the_week,
    DAYNAME(TO_DATE(RecordDate2)) AS DAY_Name,

    CASE
      WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Sat', 'Sun') THEN 'Weekend'
      ELSE 'Weekday'
    END AS Day_Classification,

    MONTHNAME(TO_DATE(RecordDate2)) AS MONTH_NAME,
    CASE 
      WHEN Channel2 IN ('Sawsee', 'Sawsee') THEN 'Sawsee'
      WHEN Channel2 IN ('Supersport Live Events', 'Live on SuperSport', 'Supersport Live Events', 'Dstv Events 1') THEN 'Live Events'
      ELSE Channel2
    END AS Tv_Channel,
    
    date_format(RecordDate2,'HH:mm:ss') AS watch_time,
    CASE 
      WHEN DATE_FORMAT(RecordDate2, 'HH:mm:ss') BETWEEN '00:00:00' AND '05:59:59' THEN '01.Midnight'
      WHEN DATE_FORMAT(RecordDate2, 'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN '02.Morning'
      WHEN DATE_FORMAT(RecordDate2, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '03.Afternoon'
      WHEN DATE_FORMAT(RecordDate2, 'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '04.Evening'
    END AS Time_of_day,

    DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,
    CASE
      WHEN `Duration 2` BETWEEN '00:05:00' AND '00:30:00' THEN '01.Low Usage:<30 min'
      WHEN `Duration 2` BETWEEN '00:30:01' AND '00:59:59' THEN '02. Med Usage:<60 min' 
      WHEN `Duration 2` > '00:59:59' THEN '03.High Usage:>60 min'
      ELSE '04. No Usage'
    END AS Screen_time_bucket,

    HOUR(RecordDate2) AS hour_of_the_day

  FROM brighttv_case_study.bright_tv.bright_viewership)

SELECT
  COALESCE(A.UserID, B.Userid) AS SUB_ID,
  month_id,
  watch_date,
  day_name,
  day_of_the_week,
  day_classification,
  month_name,
  Tv_channel,
  time_of_day,
  hour_of_the_day,
  screen_time_bucket,
  --user_flag
  duration,
  Region,
  Age_Group,
  email_flag,
  socialmedia_flag,
  Ethnicity,
  Gender
FROM bright_viewership AS A
LEFT JOIN bright_tv_user_profiles AS B
  ON A.UserID = B.Userid;

