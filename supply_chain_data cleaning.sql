-- 1.Check Total Records

SELECT 'orders' AS table_name, COUNT(*) AS total_records
FROM orders

UNION ALL

SELECT 'ordered_items', COUNT(*)
FROM ordered_items

UNION ALL

SELECT 'customer_info', COUNT(*)
FROM customer_info

UNION ALL

SELECT 'product_info', COUNT(*)
FROM product_info

UNION ALL

SELECT 'department', COUNT(*)
FROM department;

-- 2. CHECK NULL VALUES

SELECT *
FROM orders
WHERE Order_Id IS NULL
   OR Order_Status IS NULL
   OR Shipping_Mode IS NULL
   OR Order_City IS NULL
   OR Order_State IS NULL;

SELECT *
FROM ordered_items
WHERE Order_Id IS NULL
	OR Order_Item_Id is null
    or Item_Id is null
    or Quantity is null
    OR Sales IS NULL;

SELECT *
FROM customer_info
WHERE Id IS NULL
   OR First_Name IS NULL
   or First_Name is null
   or Last_Name IS NULL
   OR Segment IS NULL
   OR Street IS NULL
   OR Zipcode IS NULL
   OR City IS NULL
   OR State IS NULL;

 SELECT *
FROM product_info
WHERE Product_Id IS NULL
      OR Product_Name IS NULL
      OR Category_Id IS NULL
      OR Product_Price IS NULL
      OR Department_Id IS NULL;

SELECT *
FROM department
WHERE Id IS NULL
   OR Name IS NULL;
   
 --   NO NULL VALUES ARE FOUND
 
 
-- 3. FIND DUPLICATE VALUES

-- orders
SELECT 
    Order_Id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY Order_Id
HAVING COUNT(*) > 1;     --- NO DUPLICATES FOUND

#ordered_items
SELECT 
    Order_Item_Id, COUNT(*) AS duplicate_count
FROM ordered_items
GROUP BY Order_Item_Id
HAVING COUNT(*) > 1;      --- NO DUPLICATES FOUND

SELECT *
FROM ordered_items
LIMIT 5;

#customer_info
SELECT 
    Id,
    COUNT(*) AS duplicate_count
FROM customer_info
GROUP BY Id
HAVING COUNT(*) > 1;      --- NO DUPLICATES FOUND

#product_info
SELECT 
    Product_Id,
    COUNT(*) AS duplicate_count
FROM product_info
GROUP BY Product_Id
HAVING COUNT(*) > 1;   --- NO DUPLICATES FOUND

#department
SELECT 
    Id,
    COUNT(*) AS duplicate_count
FROM department
GROUP BY Id
HAVING COUNT(*) > 1;   --- NO DUPLICATES FOUND

-- 4. Count Blank Rows

#orders
SELECT *
FROM orders
WHERE TRIM(Order_Status) = ''
   OR TRIM(Shipping_Mode) = ''
   OR TRIM(Order_City) = ''
   OR TRIM(Order_State) = '';
   
#ordered_items
SELECT *
FROM ordered_items
WHERE TRIM(CAST(Order_Id AS CHAR)) = '';

#customer_info
SELECT *
FROM customer_info
WHERE TRIM(First_Name) = ''
   OR TRIM(Last_Name) = ''
   OR TRIM(City) = ''
   OR TRIM(State) = ''
   OR TRIM(Street) = '';  --- FOUND 3 BLANK ROWS IN LAST NAME
   
#product_info
SELECT *
FROM product_info
WHERE TRIM(Product_Name) = '';


#department
SELECT *
FROM department
WHERE TRIM(Name) = '';

#Check Those 3 Rows

SELECT *
FROM customer_info
WHERE TRIM(Last_Name) = '';

#Update Blank Last_Name

UPDATE customer_info
SET Last_Name = 'UNKNOWN'
WHERE TRIM(Last_Name) = '';

#Recheck Again

SELECT *
FROM customer_info
WHERE TRIM(Last_Name) = '';

#Final Cleaning Summary 
-- orders:
-- No NULL values
-- No duplicates
-- No blank spaces

-- customer_info:
-- No NULL values
-- Blank Last Name replaced with 'UNKNOWN'
-- No duplicates

-- product_info:
-- No NULL values
-- No duplicates

-- department:
-- No NULL values
-- No duplicates

