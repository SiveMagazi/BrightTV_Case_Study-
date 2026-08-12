-- Databricks notebook source
SELECT *
FROM brighttv_case_study.bright_tv.bright_viewership;

-- inspecting channel2---

SELECT DISTINCT Channel2
FROM brighttv_case_study.bright_tv.bright_viewership;

-- Clean channel2 column--

SELECT DISTINCT
            CASE 
                WHEN Channel2 = 'SawSee' THEN 'Sawsee'
                WHEN Channel2 IN ('Supersport Live Events','DStv Events 1','SuperSport Live Events','Live on SuperSport') THEN 'Live Events'
            ELSE Channel2
            END AS Tv_Channel1
FROM brighttv_case_study.bright_tv.bright_viewership;

-- Checking Tv_channel with most viwers and least viewers--

SELECT COUNT(DISTINCT UserID0) AS SUBs,
            CASE 
                WHEN Channel2 = 'SawSee' THEN 'Sawsee'
                WHEN Channel2 IN ('Supersport Live Events','DStv Events 1','SuperSport Live Events','Live on SuperSport') THEN 'Live Events'
            ELSE Channel2
            END AS Tv_Channel1
FROM brighttv_case_study.bright_tv.bright_viewership
GROUP BY Tv_channel1;
-- most viewed Tv channel1 is Live Events with 1258 and least viewed is Wimbledon with 3 viwers--



