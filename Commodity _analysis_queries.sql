#Commodities

-- Question 1: Get the common commodities between the Top 10 costliest commodities of 2019 and 2020.
-- Expected Output: Commodity | price difference;  Retain the info for highest difference


# Meaning:
-- First find the common commodities between:
-- Top 10 costliest commodities of 2019
-- Top 10 costliest commodities of 2020
-- Then from those common commodities, calculate the maximum price difference in Jun 2020.
-- So to solve it using multiple CTEs.


-- Top 10 of 2019
--         ↓
-- Top 10 of 2020
--         ↓
-- Find common commodities
--         ↓
-- Take Jun 2020 data only for those commodities
--         ↓
-- Find MIN and MAX price
--         ↓
-- Calculate difference
--         ↓
-- Take highest difference

WITH top_2019 AS (                                                                                             #What this part does :
																												-- This finds: Top 10 most expensive commodities in 2019
	SELECT
        c.commodity
    FROM price_details p
    JOIN commodities_info c
        ON p.commodity_id = c.id
    WHERE YEAR(p.date) = 2019
    GROUP BY c.commodity
    ORDER BY AVG(p.retail_price) DESC
    LIMIT 10
),

top_2020 AS (

    SELECT
        c.commodity
    FROM price_details p
    JOIN commodities_info c
        ON p.commodity_id = c.id
    WHERE YEAR(p.date) = 2020
    GROUP BY c.commodity
    ORDER BY AVG(p.retail_price) DESC
    LIMIT 10
)
    SELECT t19.commodity
    FROM top_2019 t19
    INNER JOIN top_2020 t20
        ON t19.commodity = t20.commodity;


    

-- Logic Flow
-- top_2019 → top 10 expensive commodities of 2019
-- top_2020 → top 10 expensive commodities of 2020
-- common_commodities → common between both
-- june_2020_data → Jun 2020 min/max prices only for those commodities
-- Final query → highest price difference


-- 1. top_2019
-- Takes only 2019 data
-- Joins both tables
-- Groups data commodity-wise
-- Calculates average retail price
-- Selects top 10 costliest commodities

-- 2. top_2020
-- Takes only 2020 data
-- Joins both tables
-- Groups data commodity-wise
-- Calculates average retail price
-- Selects top 10 costliest commodities

-- 3. Final Query
-- Uses INNER JOIN
-- Matches commodities present in both lists
-- Returns common commodities


#************************************************************************************************************************************

-- Question 2: What is the maximum difference between the prices of a commodity at one place vs the other 
-- for the month of Jun 2020? Which commodity was it for?



WITH june_data AS (
    SELECT
        c.commodity,
        MIN(p.retail_price) AS min_price,
        MAX(p.retail_price) AS max_price
    FROM price_details p
    JOIN commodities_info c
        ON p.commodity_id = c.id
    WHERE MONTH(p.date) = 6
      AND YEAR(p.date) = 2020
    GROUP BY c.commodity
)

SELECT
    commodity,
    (max_price - min_price) AS price_difference
FROM june_data
ORDER BY price_difference DESC
LIMIT 1;

--  Explanation
-- 1st Part → jun_2020
-- Joins both tables
-- Filters only June 2020 data
-- Selects commodity and retail price

-- 2nd Part → Aggregation
-- Groups records by commodity
-- Finds:
-- Maximum price
-- Minimum price
-- Subtracts minimum from maximum
-- SQL
-- MAX(retail_price) - MIN(retail_price)
-- This gives price variation.

-- 3rd Part → Sorting
-- Sorts result in descending order
-- Highest difference comes first

-- 4th Part → LIMIT 1
-- Returns only top commodity
-- Means commodity with highest price difference

#****************************************************************************************************************************************

-- Question 3: Arrange the commodities in order based on the number of varieties in which they are available, 
-- with the highest one shown at the top. Which is the 3rd commodity in the list?

--  Meaning:
-- A commodity can have many varieties.
-- But count how many different varieties each commodity has.
-- Which commodity is in the 3rd position after sorting by variety count?

WITH variety_count AS (

    SELECT
        commodity,
        COUNT(DISTINCT variety) AS variety_count
    FROM commodities_info
    GROUP BY commodity
)

SELECT
    commodity,
    variety_count
FROM variety_count
ORDER BY variety_count DESC
LIMIT 1 OFFSET 2;

#Explanation

-- Count the number of distinct varieties for each commodity.
-- Group the data by commodity.
-- Sort the commodities in descending order based on variety count.
-- Select the commodity appearing in the 3rd position of the sorted list.

#**************************************************************************************************************************************

-- Question 4: In the state with the least number of data points available. 
-- Which commodity has the highest number of data points available?

-- Expected Output: commodity;  Expecting only one value as output

-- Meaning of the Question
-- First :
-- Which state has the least number of total records/data points.
-- Then inside that state:
-- Find which commodity appears the most number of times.
-- Finally:
-- Return only that commodity name.


WITH state_count AS (
	SELECT r.state,
        COUNT(p.id) AS total_records
    FROM price_details p
    JOIN region_info r
        ON p.region_id = r.id
    GROUP BY r.state
    ORDER BY total_records ASC
    LIMIT 1
),
commodity_count AS (
	SELECT c.commodity,
        COUNT(p.id) AS commodity_records
    FROM price_details p
    JOIN region_info r
        ON p.region_id = r.id
    JOIN commodities_info c
        ON p.commodity_id = c.id
       
        WHERE r.state = (
        SELECT state
        FROM state_count
    )
    GROUP BY c.commodity
)
SELECT commodity
FROM commodity_count
ORDER BY commodity_records DESC
LIMIT 1;

#Explanation
-- First, the price_details table is joined with the region_info table because the state name is not directly available in price_details.
-- After joining:
-- Count how many records are available for each state.
-- Group the records by state.
-- Sort the counts in ascending order.
-- The state appearing at the top after sorting is the state with the least number of data points.

-- Part 2 — Find the commodity with highest data points in that stateS
-- After identifying the state from Part 1:
-- Filter the data only for that state.
-- Count how many times each commodity appears.
-- Group the records by commodity.
-- Sort the counts in descending order.
-- The commodity at the top has the highest number of data points in that state.

--  Final Step
-- The commodity ID is finally joined with the commodities_info table to get the commodity name as output.
#****************************************************************************************************************************************************************
-- Question 5: What is the price variation of commodities for each city from Jan 2019 to Dec 2020. 
-- 			Which commodity has seen the highest price variation and in which city?

-- Expected Output: Commodity | city | Start Price | End Price | Variation absolute | Variation Percentage;  
-- Sort in descending order of variation %.

# Meaning of Question5.
-- 1. Filter data for the state found earliar.
-- 2. Count records for each Commodity.
-- 3. Find the Commodity with Highest count.

WITH jan_2019 AS (
SELECT Region_Id, Commodity_Id, Retail_Price AS Start_Price
FROM price_details
WHERE Date BETWEEN '2019-01-01' AND '2019-01-31'),                                                  -- Step 1 & 4: Filter for Jan 2019 and name it Start Price
dec_2020 AS (                                                                                                -- 2nd temorary table
SELECT Region_Id, Commodity_Id, Retail_Price AS End_Price
FROM price_details
WHERE Date BETWEEN  '2020-12-01' AND '2020-12-31' )                                                  -- Step 2 & 4: Filter for Dec 2020 and name it End Price
SELECT 
c.Commodity,
r.Centre,
j.Start_Price AS 'Start Price',
d.End_Price AS 'End Price',
(d.End_Price - j.Start_Price) AS 'Variation Absolute',
(((d.End_Price - j.Start_Price) / j.Start_Price) * 100) AS 'Variation Percentage'
FROM jan_2019 j 
INNER JOIN dec_2020 d ON j.Region_Id = d.Region_Id AND j.Commodity_Id = d.Commodity_Id
JOIN region_info r ON j.Region_Id = r.Id
JOIN commodities_info c ON j.Commodity_Id = c.Id
ORDER BY 'Variation Percentage' DESC
LIMIT 1;


--  Part 1 — 
--  Find the state with least records
-- Join price_details with region_info
-- Count total records for each state
-- Sort counts in ascending order
-- Select the top state

--  Part 2 — 
--  Find top commodity in that state
-- Filter data for the selected state
-- Count records for each commodity
-- Group by commodity_id
-- Sort counts in descending order
-- Select top commodity ID

--  Part 3 — 
--  Get commodity name
-- Join top commodity_id with commodities_info
-- Match commodity_id with id
-- Return the commodity name as final output






























