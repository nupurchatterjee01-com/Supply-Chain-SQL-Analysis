#Data Cleaning

-- 1. Check Total Records
select count(*)
from commodities_info;

select count(*)
from region_info;

select count(*)
from price_details;


-- 2.Check Null Values

SELECT *
FROM commodities_info
WHERE Id IS NULL
   OR Commodity IS NULL
   OR Variety IS NULL;
   
SELECT *
FROM region_info
WHERE Id IS NULL
   OR State IS NULL
   OR Centre IS NULL;
   
select *
from price_details
where Retail_Price is null
   or Commodity_Id is null
   or Region_Id is null;
   
-- 3.Find duplicates

SELECT Id, COUNT(*)
FROM price_details
GROUP BY Id
HAVING COUNT(*) > 1;

SELECT Id, COUNT(*)
FROM commodities_info
GROUP BY Id
HAVING COUNT(*) > 1;

SELECT Id, COUNT(*)
FROM region_info
GROUP BY Id
HAVING COUNT(*) > 1;

-- 4.Check Blank Rows

SELECT *
FROM commodities_info
WHERE TRIM(COMMODITY) = ''
   OR TRIM(VARIETY) = ''
   OR TRIM(UNIT) = ''
   OR TRIM(CATEGORY)='';
   
# Count the Blank ---------- 31 BLANK ROWS IN THE VARIETY
select count(*) as blank_count
from commodities_info
where trim(variety)= '';

#UPDATE THE BLANK SPACES WITH TEXT " NOT AVAILABLE"

set sql_safe_updates = 0 ;   -- --FOR PROTECT THE DATA BECAUSE TRIM(VARIETY) IS NOT KEY COL.

update commodities_info
set variety = "UNKOWN"
where trim(variety)= '';

#CHECK
SELECT *
FROM commodities_info
WHERE Variety = 'UNKNOWN';

-- #6.check DUPLICATES

select commodity , variety , unit , category , count(*) as COUNT_DUPLICATE
FROM commodities_info
group by Commodity, variety , unit , Category
having count(*) >1;



-- #Final Cleaning Summary 

-- commodities_info:
-- 99 rows
-- No NULL values
-- 31 blank rows found in Variety column
-- Blank rows replaced with 'UNKNOWN'
-- No duplicates

-- region_info:
-- 77 rows
-- No NULL values
-- No blank spaces
-- No duplicates

-- price_details:
-- 9046 rows
-- No NULL values
-- No blank spaces
-- No duplicates




   