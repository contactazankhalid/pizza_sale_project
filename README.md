## Pizza Sales Analysis (SQL)
 Project Overview
This project involves a comprehensive analysis of a pizza restaurant's sales data using SQL. The goal was to extract actionable insights regarding customer behavior, product performance, and revenue growth. The analysis transitions from basic data retrieval to complex analytical queries involving multi-table joins, subqueries, and window functions.

 Tech Stack
Database: PostgreSQL / SQL Server (pgAdmin 4)

Language: SQL

Concepts: Joins, CTEs, Window Functions, Aggregate Functions, Data Grouping.

 Key Business Questions Addressed
1. Basic Analysis
Order Volume: Retreived the total number of orders placed to understand store traffic.

Revenue Performance: Calculated total revenue generated from all pizza sales.

Product Insights: Identified the highest-priced pizza and the most common pizza size preferred by customers.

Popularity: Listed the top 5 most ordered pizza types based on quantity.

2. Intermediate Analysis
Category breakdown: Joined multiple tables to determine the total quantity ordered for each pizza category (e.g., Classic, Veggie, Supreme).

Hourly Distribution: Analyzed order timestamps to find the peak hours of operation.

Inventory & Variety: Determined the distribution of pizzas across different categories to understand menu balance.

Daily Averages: Grouped orders by date to calculate the average number of pizzas sold per day.

3. Advanced Insights (Business Intelligence)
Revenue Leaders: Identified the top 3 pizza types contributing most to the total revenue.

Contribution Analysis: Calculated the percentage contribution of each pizza type to the overall sales.

Cumulative Growth: Analyzed cumulative revenue generated over time to track business scaling.

Category-Specific Rankings: Used advanced SQL techniques to find the top 3 most ordered pizza types based on revenue for each specific pizza category.

 Database Schema
The analysis was performed using four primary tables:

Orders: Tracking order IDs, dates, and times.

Order_Details: Linking orders to specific pizza IDs and quantities.

Pizzas: Containing pricing and size information.

Pizza_Types: Storing names and category details.
