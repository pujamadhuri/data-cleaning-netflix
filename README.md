
# Netflix Movies & TV Shows Titles - SQL Data Cleaning Project

Project Overview:

This project cleans and organizes the Netflix Movies & TV Shows dataset using SQL in MYSQL. I imported the raw data from kaggle into MySQL and created a staging table as a working copy to keep the original data safe. In the staging table, I handled missing values, removed duplicates, standardized text and dates, removed extra columns and made the data ready for analysis.

Dataset:

Source: Kaggle - Netflix Movies and TV Shows Titles
Link: https://www.kaggle.com/datasets/shivamb/netflix-shows
Format: CSV
Records: ~8,800 Titles
Key Columns:
show_id
type
Title
director
cast
country
date_added
release_year
rating
duration_minutes
duration_season
listed_in
description
Note: Raw dataset is not included in this repository. 

Tools & Technologies:
Datbase: MySQL
Language: SQL
Environment: MySQL Workbench,
Version Control: Git & GitHub

Project Structure:
cleaned_data_set folder contains the final cleaned dataset CSV 
netflix-data-cleaning.sql:  file contains all SQL scripts
like creating a database, importing raw data, creating the staging table and cleaning the data. 
README.md- Explains the project, workflow and instructions.

Data Cleaning Workflow:

Schema & Raw Data import: Created a dedicated schema for the project as "Netflix_titles", Imported the CSV into a raw table as "netflix_raw". Raw data remains unchanged throughout the project.

Staging Table Creation:
Created a staging table from the raw table as "netflix_staging", All cleaning and transformations were performed in thsi table. When I identified duplicates in the staging table, I used CTE and DELETE statement is not updatable in MySQL. So, I created a staging2 table as "netflix_staging2" to remove duplicates. So, the remaining cleaning process in done in staging2 table. 

Data Cleaning Steps:

The following operations were performed:
Missing values-Replaced NULLS or blank spaces with 'Unknown' where appropriate. 
Removed duplicates- Identified duplicates using ROW_NUMBER(). Standardized text columns- Removed extra spaces using TRIM(). Date formatting- Converted date_added to proper DATE format. Duration cleanup- Spilted duration into two columns as duration_season and duration_minutes.

Removed extra columns like duration and row_num. Changed 'text' datatype of all columns to appropriate ones. 

Key Outcomes:

Clean, structured dataset ready for analysis.
Reproducible SQL-based workflow.
Raw data preserved for auditing and reprocessing.
Staging table optimized for EDA and visualization.

How to Run This Project:
Clone the repository.
Download the dataset from Kaggle link above. 
Run SQL scripts from 'netflix-data-cleaning.sql'.

Future Improvements:
Perform deeper exploratory data analysis(EDA), such as trends in content added by year, popular genres and country-wise distributions.
Create visualizations like charts, graphs and dashboards using Tableau or PowerBI.

Author:
Puja Madhuri K
Aspiring Data Analyst
GitHub Link: https://github.com/pujamadhuri/data-cleaning-netflix

Acknowledgments: Netflix dataset from Kaggle
MySQL documentation.







