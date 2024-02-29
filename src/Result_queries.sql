/*
This SQL script retrieves data from the "cities" table and performs a join operation with the "weather_data" and "flight_data" tables. It calculates average temperature, average rainfall, average wind speed, and forecast information for each city and time period. The script then joins the result with the "cities" table to get additional city information.

*/

-- Use the "gans_locations" database
USE gans_locations;

-- Retrieve all rows from the "cities" table
SELECT * FROM cities;

-- Retrieve distinct rows from the combined result of the following subqueries
SELECT DISTINCT *  
FROM ( 
    -- Subquery 1: Calculate average temperature, average rainfall, average wind speed, and forecast information for each city and time period
    SELECT DISTINCT
        ROUND(AVG(temperature), 2) AS avg_temperature,
        ROUND(AVG(rain_in_last_3h), 2) AS avg_rainfall,
        ROUND(AVG(wind_speed), 2) AS avg_wind_speed,
        forecast_days,
        city_id,
        CASE 
            WHEN forecast_hour BETWEEN 0 AND 2 THEN "0:00-2:59"
            WHEN forecast_hour BETWEEN 3 AND 5 THEN "3:00-5:59"
            WHEN forecast_hour BETWEEN 6 AND 8 THEN "6:00-8:59"
            WHEN forecast_hour BETWEEN 9 AND 11 THEN "9:00-11:59"
            WHEN forecast_hour BETWEEN 12 AND 14 THEN "12:00-14:59"
            WHEN forecast_hour BETWEEN 15 AND 17 THEN "15:00-17:59"
            WHEN forecast_hour BETWEEN 18 AND 20 THEN "18:00-20:59"
            WHEN forecast_hour BETWEEN 21 AND 23 THEN "21:00-23:59"
        END AS "3hours_forecast_weather"
    FROM weather_data
    GROUP BY forecast_days, city_id, 3hours_forecast_weather
    ORDER BY forecast_days, city_id, FIELD(3hours_forecast_weather, "0:00-2:59", "3:00-5:59", "6:00-8:59", "9:00-11:59", "12:00-14:59", "15:00-17:59", "18:00-20:59", "21:00-23:59")
) AS weather
LEFT JOIN cities AS c ON weather.city_id = c.city_id
LEFT JOIN (
    -- Subquery 2: Calculate the sum of flights, date, city_id, and forecast information for each city and time period
    SELECT 
        SUM(number_of_flights) AS Sum_flights,
        `date`,
        f.city_id,
        CASE 
            WHEN `hour` BETWEEN 0 AND 2 THEN "0:00-2:59"
            WHEN `hour` BETWEEN 3 AND 5 THEN "3:00-5:59"
            WHEN `hour` BETWEEN 6 AND 8 THEN "6:00-8:59"
            WHEN `hour` BETWEEN 9 AND 11 THEN "9:00-11:59"
            WHEN `hour` BETWEEN 12 AND 14 THEN "12:00-14:59"
            WHEN `hour` BETWEEN 15 AND 17 THEN "15:00-17:59"
            WHEN `hour` BETWEEN 18 AND 20 THEN "18:00-20:59"
            WHEN `hour` BETWEEN 21 AND 23 THEN "21:00-23:59"
        END AS "3hours_forecast"
    FROM flight_data AS f
    GROUP BY f.`date`, f.city_id, 3hours_forecast
    ORDER BY `date`, city_id, FIELD(3hours_forecast, "0:00-2:59", "3:00-5:59", "6:00-8:59", "9:00-11:59", "12:00-14:59", "15:00-17:59", "18:00-20:59", "21:00-23:59")
) AS f ON c.city_id = f.city_id 
    AND weather.3hours_forecast_weather = f.3hours_forecast 
    AND weather.forecast_days = f.`date`;
    
    

