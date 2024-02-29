# Collecting_Data_Web_Scraping_APIs_WBS
 Build a data pipeline with Python and SQL

A project within the Data Science Bootcamp at WBS Coding School

## Overview 

The project aims at collecting Data via Web Scraping and by requests over an API. The collected data is then processed over the Goolge Cloud to an SQL Database. 


## Objective

## Data Source

The cities information was scraped from Wikipedia
Weather Data comes from the API  
Flight Data from the API  
both over RapidAPI

## Tools used

- python with BeautifoulSoup & Pandas
- SQL 
- Google Cloud

For our project, we were tasked with collecting data about several cities, including weather forecasts and flight information for nearby airports. This valuable data was meant for our fictive client, GANS, a rising star in the e-scooter rental sector. GANS needed insights on how many scooters to have in each city, as this depended heavily on weather conditions and flight traffic. Additionally, we aimed to set up the entire project in Google Cloud and schedule automatic updates for the weather and flight data.

To gain a comprehensive understanding of data collection methods, we started by utilizing web scraping techniques to gather information about the cities from Wikipedia. Next, we integrated weather and flight APIs to complete the database


## Folder structure

/src  	- the python notebook to collect the data and send it to a SQL database
	- the SQL script to transform the data to a final csv to show as results
	- the python results notebook with plot
 
/data 	- result csv from SQL 