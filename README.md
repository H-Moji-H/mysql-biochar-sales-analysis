# mysql-biochar-sales-analysis

# Biochar Database Project

# Overview

This project involves creating and querying a database named biochar_db in MySQL. The database is designed to manage biochar sales and includes three main tables: county_lookup, agent_lookup, and biochar_sales. Queries have been written to generate insights on sales performance and revenue metrics categorized by county and agent.

# Project Setup

## Database Creation

Schema: A database named biochar_db was created in MySQL.

Tables: The following tables were created in the database:

county_lookup

agent_lookup

biochar_sales

Data Import:
The data from provided CSV files (County Lookup.csv, Agent Lookup.csv, and Biochar Sales.csv) was imported into the respective tables using MySQL Workbench or CLI.

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

SELECT
    c.county_name AS County,
    a.agent_name AS Agent,
    COUNT(b.biochar_id) AS Bags_Sold,
    SUM(b.expected_revenue) AS Total_Revenue_Expected,
    SUM(b.revenue_received) AS Total_Revenue_Received,
    SUM(b.expected_revenue - b.revenue_received) AS Remaining_Balance
FROM
    biochar_sales b
JOIN
    agent_lookup a ON b.agent_id = a.agent_id
JOIN
    county_lookup c ON a.county_id = c.county_id
GROUP BY
    c.county_name, a.agent_name
WITH ROLLUP
ORDER BY
    Bags_Sold DESC;

## Result Table



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

The SQL query used is saved as project_queries.sql.
