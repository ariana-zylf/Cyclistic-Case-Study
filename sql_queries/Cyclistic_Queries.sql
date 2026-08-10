    -- ============================================================
-- CYCLISTIC CASE STUDY: FULL DATA PREPARATION & ANALYSIS
-- Author: Ariana
-- Tool: Google BigQuery (SQL)
-- Description: Merging 12-month trip data, cleaning, feature 
--              engineering, and behavioral analysis for Cyclistic.
-- ============================================================


-- ============================================================
-- PHASE 2: PREPARE
-- STEP 1: MERGING 12 MONTHS OF DATA (UNION ALL)
-- ============================================================

CREATE OR REPLACE TABLE `pro-hour-478519-k4.cyclistic_case_study.year_tripdata` AS
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_01`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_02`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_03`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_04`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_05`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_06`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_07`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_08`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_09`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_10`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_11`
UNION ALL
SELECT * FROM `pro-hour-478519-k4.cyclistic_case_study.tripdata_2025_12`;


-- ============================================================
-- PHASE 3: PROCESS
-- STEP 2: CHECK FOR DUPLICATE RECORDS
-- ============================================================

SELECT 
    ride_id,
    COUNT(*) AS count_duplicates
FROM `pro-hour-478519-k4.cyclistic_case_study.year_tripdata`
GROUP BY ride_id
HAVING COUNT(*) > 1;


-- ============================================================
-- STEP 3: CHECK FOR MISSING / NULL VALUES
-- ============================================================

SELECT 
    COUNT(*) - COUNT(ride_id) AS missing_ride_id,
    COUNT(*) - COUNT(rideable_type) AS missing_rideable_type,
    COUNT(*) - COUNT(started_at) AS missing_started_at,
    COUNT(*) - COUNT(ended_at) AS missing_ended_at,
    COUNT(*) - COUNT(start_station_name) AS missing_start_station_name,
    COUNT(*) - COUNT(start_station_id) AS missing_start_station_id,
    COUNT(*) - COUNT(end_station_name) AS missing_end_station_name,
    COUNT(*) - COUNT(end_station_id) AS missing_end_station_id,
    COUNT(*) - COUNT(start_lat) AS missing_start_lat,
    COUNT(*) - COUNT(start_lng) AS missing_start_lng,
    COUNT(*) - COUNT(end_lat) AS missing_end_lat,
    COUNT(*) - COUNT(end_lng) AS missing_end_lng,
    COUNT(*) - COUNT(member_casual) AS missing_member_casual
FROM `pro-hour-478519-k4.cyclistic_case_study.year_tripdata`;


-- ============================================================
-- STEP 4: CHECK FOR INVALID RIDE DURATIONS (<= 0 minutes)
-- ============================================================

SELECT 
    COUNT(*) AS invalid_duration_trips
FROM `pro-hour-478519-k4.cyclistic_case_study.year_tripdata`
WHERE ended_at <= started_at;


-- ============================================================
-- STEP 5: DATA CLEANING & FEATURE ENGINEERING
-- Calculates trip duration in minutes, extracts day of the week,
-- and filters out invalid trips with duration <=0 minutes.
-- ============================================================

CREATE OR REPLACE TABLE `pro-hour-478519-k4.cyclistic_case_study.cleaned_year_tripdata` AS
SELECT 
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minutes,
    FORMAT_DATE('%A', DATE(started_at)) AS day_of_week,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
FROM `pro-hour-478519-k4.cyclistic_case_study.year_tripdata`
WHERE ended_at > started_at;


-- ============================================================
-- PHASE 4: ANALYZE
-- STEP 6: OVERALL TRIP SUMMARY (TOTAL TRIPS & AVERAGE DURATION)
-- ============================================================

SELECT 
    member_casual,
    COUNT(ride_id) AS total_trips,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM `pro-hour-478519-k4.cyclistic_case_study.cleaned_year_tripdata`
GROUP BY member_casual;


-- ============================================================
-- STEP 7: USAGE BY DAY OF THE WEEK (TOTAL TRIPS & DURATION)
-- ============================================================

SELECT 
    member_casual,
    day_of_week,
    COUNT(ride_id) AS total_trips,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM `pro-hour-478519-k4.cyclistic_case_study.cleaned_year_tripdata`
GROUP BY member_casual, day_of_week
ORDER BY member_casual, total_trips DESC;


-- ============================================================
-- STEP 8: PREFERENCES BY BIKE TYPE (RIDEABLE TYPE)
-- ============================================================

SELECT 
    member_casual,
    rideable_type,
    COUNT(ride_id) AS total_trips,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM `pro-hour-478519-k4.cyclistic_case_study.cleaned_year_tripdata`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips DESC;


-- ============================================================
-- STEP 9: GEOGRAPHIC ANALYSIS - TOP STATIONS BY USER TYPE
-- ============================================================

SELECT 
    member_casual,
    start_station_name,
    COUNT(ride_id) AS total_trips
FROM `pro-hour-478519-k4.cyclistic_case_study.cleaned_year_tripdata`
WHERE start_station_name IS NOT NULL
GROUP BY member_casual, start_station_name
ORDER BY member_casual, total_trips DESC;


-- ============================================================
-- STEP 10: GEOGRAPHIC ANALYSIS - TARGETED TOP 5 STATIONS FOR ANNUAL MEMBERS
-- Note: Created specifically for 'member'users to quickly extract their top 5 
-- stations, avoiding excessive scrolling through 'casual' results caused 
-- by alphabetical sorting in Step 9.
-- ============================================================

SELECT 
    member_casual,
    start_station_name,
    COUNT(ride_id) AS total_trips
FROM `pro-hour-478519-k4.cyclistic_case_study.cleaned_year_tripdata`
WHERE start_station_name IS NOT NULL 
  AND member_casual = 'member'
GROUP BY member_casual, start_station_name
ORDER BY total_trips DESC
LIMIT 5;
    
