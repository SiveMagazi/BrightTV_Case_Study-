-- Databricks notebook source
SELECT *
FROM brighttv_case_study.bright_tv.bright_tv_dataset;

SELECT DISTINCT `gender`
FROM brighttv_case_study.bright_tv.bright_tv_dataset;
-----------------------------------------------------------------------
-- USE CASE STATEMENT TO REPLACE UNCLASSIFIED WITH UNKNOWN Gender checks
-----------------------------------------------------------------------
SELECT DISTINCT
    CASE
        WHEN gender ='None' THEN 'unknown'
        WHEN gender = ' ' THEN 'unknown'
        WHEN gender IS NULL THEN 'unknown' -- replce NULL as unknown 
    ELSE gender -- if gender is male or female return it as it is
    END AS sex
FROM brighttv_case_study.bright_tv.bright_tv_dataset; 

-----------------------------------------------------------------------
-- Race Checks
-----------------------------------------------------------------------
SELECT DISTINCT `race`
FROM brighttv_case_study.bright_tv.bright_tv_dataset;
-----------------------------------------------------------------------
-- USE CASE STATEMENT TO REPLACE UNCLASSIFIED WITH UNKNOWN Race checks
-----------------------------------------------------------------------
SELECT DISTINCT
            CASE
                WHEN race = 'other'THEN 'unknown'
                WHEN race = ' ' THEN 'unknown'
                WHEN race = 'None' THEN 'unknown'
                WHEN race IS NULL THEN 'unknown'
            ELSE race
            END AS Enthnicity 
        From brighttv_case_study.bright_tv.bright_tv_dataset;
-----------------------------------------------------------------------
-- I want to understand my data as to how many are the unknown Race
-----------------------------------------------------------------------
SELECT COUNT(DISTINCT userid) AS Subs,
            CASE
                WHEN race = 'other' THEN 'unknown'
                WHEN race = ' ' THEN 'unknown'
                WHEN race = 'None' THEN 'unknown'
                WHEN race IS NULL THEN 'unknown'
            ELSE race
            END AS Enthnicity 
        From brighttv_case_study.bright_tv.bright_tv_dataset
        GROUP BY Enthnicity;

select * 
from `brighttv_case_study`.`bright_tv`.`bright_tv_dataset` 
limit 100;

SELECT DISTINCT `gender`
FROM brighttv_case_study.bright_tv.bright_tv_dataset;
-----------------------------------------------------------------------
-- USE CASE STATEMENT TO REPLACE UNCLASSIFIED WITH UNKNOWN Gender checks
-----------------------------------------------------------------------
SELECT DISTINCT
    CASE
        WHEN gender = 'None' THEN 'unknown'
        WHEN gender = ''  '' THEN 'unknown'
        WHEN gender IS NULL THEN 'unknown' 
    ELSE gender 
    END AS sex
FROM brighttv_case_study.bright_tv.bright_tv_dataset; 

-----------------------------------------------------------------------
-- Race Checks
-----------------------------------------------------------------------
SELECT DISTINCT `race`
FROM brighttv_case_study.bright_tv.bright_tv_dataset;
-----------------------------------------------------------------------
-- USE CASE STATEMENT TO REPLACE UNCLASSIFIED WITH UNKNOWN Race checks
-----------------------------------------------------------------------
SELECT DISTINCT
            CASE
                WHEN race = 'other'THEN 'unknown'
                WHEN race = ' ' THEN 'unknown'
                WHEN race = 'None' THEN 'unknown'
                WHEN race IS NULL THEN 'unknown'
            ELSE race
            END AS Enthnicity 
        From brighttv_case_study.bright_tv.bright_tv_dataset;
-----------------------------------------------------------------------
-- I want to understand my data as to how many are the unknown Race
-----------------------------------------------------------------------
SELECT COUNT(DISTINCT userid) AS Subs,
            CASE
                WHEN race = 'other' THEN 'unknown'
                WHEN race = ' ' THEN 'unknown'
                WHEN race = 'None' THEN 'unknown'
                WHEN race IS NULL THEN 'unknown'
            ELSE race
            END AS Enthnicity 
        From brighttv_case_study.bright_tv.bright_tv_dataset
        GROUP BY Enthnicity;

-----------------------------------------------------------------------
-- Province Checks
-----------------------------------------------------------------------
SELECT DISTINCT `Province`
FROM brighttv_case_study.bright_tv.bright_tv_dataset;

SELECT COUNT (DISTINCT UserID ) AS Subs,
                CASE
                    WHEN province = 'None' THEN 'unknown'
                    WHEN province = ' ' THEN 'unknown'
                    WHEN province IS NULL THEN 'unknown'
                ELSE province
                END AS Region 
            FROM brighttv_case_study.bright_tv.bright_tv_dataset
            GROUP BY Region;


-----------------------------------------------------------------------
-- Age Checks
-----------------------------------------------------------------------

SELECT MIN(age) AS Min_age, 
       MAX(age) AS Max_age, 
       AVG(age) AS Mean_age 

From brighttv_case_study.bright_tv.bright_tv_dataset;

SELECT COUNT(DISTINCT UserID) AS Subs,
      CASE 
          WHEN Age = 0 THEN 'infant'
          WHEN Age BETWEEN 1 AND 12 THEN 'Kids'
          WHEN Age BETWEEN 13 AND 17 THEN 'youth'
          WHEN Age BETWEEN 18 AND 35 THEN 'youth Adults'
          WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
          WHEN Age > 50 AND Age<=60 THEN 'Elder'
          WHEN Age > 60 THEN 'Pensioner'
    END AS Age_group
From brighttv_case_study.bright_tv.bright_tv_dataset
GROUP BY Age_group;

----------------------------------------------------------------
-- Combing Everything 
-----------------------------------------------------------------
CREATE OR REPLACE TEMPORARY TABLE processed_bright_tv_dataset As (
SELECT 
     UserID,

        CASE 
            WHEN 'Email' IS NOT NULL THEN 1
            ELSE 0
        END AS email_flag,

        CASE 
            WHEN 'Social Media Handle' IS NOT NULL THEN 1
            ELSE 0
        END AS Social_media_handle_flag,

        CASE
            WHEN gender = 'None' THEN 'unknown'
            WHEN gender = ' ' THEN 'unknown'
            WHEN gender IS NULL THEN 'unknown' 
        ELSE gender 
        END AS sex,
    
        CASE
            WHEN race = 'other' THEN 'unknown'
            WHEN race = ' ' THEN 'unknown'
            WHEN race = 'None' THEN 'unknown'
            WHEN race IS NULL THEN 'unknown'
        ELSE race
        END AS Enthnicity, 

        CASE
            WHEN province = 'None' THEN 'unknown'
            WHEN province = ' ' THEN 'unknown'
            WHEN province IS NULL THEN 'unknown'
        ELSE province
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
        END AS Age_group
        From brighttv_case_study.bright_tv.bright_tv_dataset);

        --------------------------------------------------------------------------
        CREATE OR REPLACE TEMPORARY TABLE proce
