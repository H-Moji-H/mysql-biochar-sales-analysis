# mysql-biochar-sales-analysis

# Biochar Database Project

# Overview

This project involves creating and querying a database named biochar_db in MySQL. The database is designed to manage biochar sales and includes three main tables: county_lookup, agent_lookup, and biochar_sales.The data tables (CSV files) were imported into the db. The queries were written in SQL, using MySQL as the Relational Database Management System (RDBMS), to generate insights on sales performance and revenue metrics categorized by county and agent.

# Project Setup

## Database Creation

Schema: A database named biochar_db was created in MySQL.

Tables: The following tables were created in the database:

county_lookup - has all the counties where the product is sold

agent_lookup - contains sales agent data

biochar_sales - conatains sales data

Data Import:
Data from the provided CSV files (County Lookup.csv, Agent Lookup.csv, and Biochar Sales.csv) was imported into the respective tables using MySQL Workbench and verified using the MySQL CLI.

# Queries and Analysis

 ### Query Requirements:

The goal was to write a query that produces a single table containing the following information:

Number of biochar bags sold per agent

Total revenue expected per agent

Total revenue received per agent

Remaining balance per agent

Additionally, the table should:

Be categorized by county.

Be arranged in descending order based on the number of biochar bags sold.

Include subtotals per county and a grand total.

# Query
The individual query to produce the table is stored in the agent_metrics.sql file and the overall query file namely project_queries.sql

    WITH agent_metrics AS (  

    -- Individual agent metrics
  
    SELECT 
        county_lookup.ï»¿county_name,
        agent_lookup.agent_name,
        SUM(biochar_sales.biochar_bags) as total_bags,
        SUM(biochar_sales.order_amount_total) as total_expected,
        SUM(biochar_sales.paid_today) as total_received,
        SUM(biochar_sales.order_amount_total - biochar_sales.paid_today) as remaining_balance
    FROM biochar_sales 
    JOIN agent_lookup ON biochar_sales.agent_id = agent_lookup.ï»¿agent_id
    JOIN county_lookup ON county_lookup.county_id = agent_lookup.county_id
    GROUP BY county_lookup.ï»¿county_name, agent_lookup.agent_name

    UNION ALL
    
    -- County Subtotals
    SELECT 
        county_lookup.ï»¿county_name,
        'County Total' as agent_name,
        SUM(biochar_sales.biochar_bags) as total_bags,
        SUM(biochar_sales.order_amount_total) as total_expected,
        SUM(biochar_sales.paid_today) as total_received,
        SUM(biochar_sales.order_amount_total - biochar_sales.paid_today) as remaining_balance
    FROM biochar_sales 
    JOIN agent_lookup ON biochar_sales.agent_id = agent_lookup.ï»¿agent_id
    JOIN county_lookup ON county_lookup.county_id = agent_lookup.county_id
    GROUP BY county_lookup.ï»¿county_name

    UNION ALL
    
    -- Grand Total
    SELECT 
        'Grand Total' as ï»¿county_name,
        'All Counties' as agent_name,
        SUM(biochar_sales.biochar_bags) as total_bags,
        SUM(biochar_sales.order_amount_total) as total_expected,
        SUM(biochar_sales.paid_today) as total_received,
        SUM(biochar_sales.order_amount_total - biochar_sales.paid_today) as remaining_balance
    FROM biochar_sales 
    )
    
    SELECT 

    ï»¿county_name,
    agent_name,
    total_bags,
    total_expected,
    total_received,
    remaining_balance
    
    FROM agent_metrics
    ORDER BY 
    CASE WHEN ï»¿county_name = 'Grand Total' THEN 2
         WHEN agent_name = 'County Total' THEN 1
         ELSE 0 END,
    ï»¿county_name,
    total_bags DESC;

## Result Table
The result table is contained in the agent_metrics_results.csv file


# Insights from the Results

### Top Performing County:

Machakos leads in sales with 49 bags sold, generating a total expected revenue of 88,200, out of which 79,450 has been received. However, it also has the highest remaining balance of 8,750.

### Agent Performance:

1. Jackson Wambua and Evans Murugu both have no remaining balance, indicating full payments for their sales.

2. Faith Muli has the highest remaining balance (4,350) among agents, highlighting a potential area for follow-up.

### Low Sales Counties:

Uasin Gishu had the lowest activity, with only 1 bag sold and full payment received.

### Overall Revenue Collection:

The project achieved a total revenue of 111,600, with 102,850 collected so far and a remaining balance of 8,750.

# Query and Results:

The SQL queries required to create the schema, set it as the active schema, upload individual files into it, and generate the desired results are saved in the file named project_queries.sql

The result table is stored in the agent_metrics_results.csv file and includes the following metrics:

1.Number of biochar bags sold per agent

2.Total revenue expected per agent

3.Total revenue received per agent

4.Remaining balance per agent

The data is categorized by county and sorted in descending order based on the number of biochar bags sold. Additionally, the table includes subtotals for each county and a final grand total for all data.

The CSV files county_lookup_results.csv, agent_lookup_results.csv, and biochar_sales_results.csv are generated by running individual queries on the tables county_lookup, agent_lookup, and biochar_sales, respectively
