                                              # AmazingMartEU2 Sales Data #


#**Comprehensive Analysis of AmazingMartEU2 Sales Data: SQL Queries for Insights into Orders by Region, Segment, and Customer Trends**

create database Capstone ;
use Capstone;


# Q1) How many orders were placed in each country?
SELECT Country, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY Country
ORDER BY Total_Orders DESC;

# Q2) How many orders were placed in each region?
SELECT Region, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY Region
ORDER BY Total_Orders DESC;

# Q3) List all orders placed in the year 2011.
SELECT *
FROM amazingmarteu2
WHERE YEAR(`Order Date`) = 2011;

# Q4) List all orders shipped between January 1, 2011, and December 11, 2012
SELECT *
FROM amazingmarteu2
WHERE `Ship Date` BETWEEN '01-01-2011' AND '11-12-2012';

# Q5) How many orders were placed using each ship mode?
SELECT `Ship Mode`, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY `Ship Mode`
ORDER BY Total_Orders DESC;

# Q6) How many orders were placed in each segment?
SELECT Segment, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY Segment
ORDER BY Total_Orders DESC;

# Q7) How many orders were placed in each city?
SELECT City, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY City
ORDER BY Total_Orders DESC;

# Q8) How many orders were placed in each state?
SELECT State, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY State
ORDER BY Total_Orders DESC;

# Q9) List all orders placed in the Consumer segment and in the North region.
SELECT *
FROM amazingmarteu2
WHERE Segment = 'Consumer' AND Region = 'North';

# Q10) List all orders that were shipped using the 'Priority' ship mode.
SELECT *
FROM amazingmarteu2
WHERE `Ship Mode` = 'Priority';

# Q11) What is the total number of orders and the average ship time by country?
SELECT Country, COUNT(`Order ID`) AS Total_Orders, AVG(DATEDIFF(`Ship Date`, `Order Date`)) AS Avg_Ship_Time
FROM amazingmarteu2
GROUP BY Country
ORDER BY Total_Orders DESC;

# Q12) Which are the top 5 cities with the most orders?
SELECT City, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY City
ORDER BY Total_Orders DESC
LIMIT 5;

# Q13) How many orders were placed by each customer?
SELECT `Customer Name`, COUNT(`Order ID`) AS Total_Orders
FROM amazingmarteu2
GROUP BY `Customer Name`
ORDER BY Total_Orders DESC;

# Q14) Which customer has placed the highest number of orders, and how many orders did they place?
SELECT `Customer Name`, Total_Orders
FROM (
    SELECT `Customer Name`, COUNT(`Order ID`) AS Total_Orders
    FROM amazingmarteu2
    GROUP BY `Customer Name`
) AS CustomerOrders
ORDER BY Total_Orders DESC
LIMIT 1;

# Q15) How many orders have been placed per country, and which countries have more than 50 orders? 
-- Common Table Expression (CTE) Query
WITH CountryOrderCount AS (
    SELECT Country, COUNT(`Order ID`) AS Total_Orders
    FROM amazingmarteu2
    GROUP BY Country
)
SELECT *
FROM CountryOrderCount
WHERE Total_Orders > 50
ORDER BY Total_Orders DESC;

# Q16) For each country, what is the rank of each order based on the order date, ordered from most recent to oldest?
-- Window Function Query
SELECT `Order ID`, `Order Date`, Country, 
       ROW_NUMBER() OVER (PARTITION BY Country ORDER BY STR_TO_DATE(`Order Date`, '%d/%m/%Y') DESC) AS Order_Rank
FROM amazingmarteu2;


# Q17) How can we retrieve detailed information about each order, including the breakdown details 
#      from both the amazingmarteu2 and OrderBreakdown tables using an inner join?
-- Inner Join Query
SELECT a.`Order ID`, a.`Order Date`, a.`Customer Name`, a.`City`, a.`Country`, a.`Region`, a.`Segment`, a.`Ship Date`, a.`Ship Mode`, a.`State`, 
       o.`Product Name`, o.`Quantity`,  o.`Discount`, o.`Profit`
FROM amazingmarteu2 a
INNER JOIN OrderBreakdown o ON a.`Order ID` = o.`Order ID`;

