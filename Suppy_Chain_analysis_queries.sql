use supply_db;


-- Question 1: Get the number of orders by the Type of Transaction. Please exclude orders shipped from 
-- Sangli and Srinagar. Also, exclude the SUSPECTED_FRAUD cases based on the Order Status. Sort the 
-- result in the descending order based on the number of orders.

-- Expected Output: Type of Transaction | Orders; Sorted in descending order of Orders

-- Meaning :
-- Find different Types of Transactions from the orders table.
-- Example: Debit Card, Credit Card, Cash, Transfer, etc.
-- Count how many orders belong to each transaction type.
-- But before counting, remove:
-- Orders from Sangli and Srinagar
-- Orders with status SUSPECTED_FRAUD
-- Finally, show the result in descending order, meaning:
-- Highest number of orders first
-- Lowest number of orders last.

SELECT 
    type AS "Type of Transaction",
    COUNT(order_id) AS Orders
FROM orders
WHERE order_city NOT IN ('Sangli', 'Srinagar')
    AND order_status <> 'SUSPECTED_FRAUD'
GROUP BY type
ORDER BY Orders DESC;

-- Explanation
-- FROM orders
-- Take data from the orders table.
-- WHERE order_city NOT IN ('Sangli', 'Srinagar')
-- Remove orders shipped from Sangli and Srinagar.
-- AND order_status <> 'SUSPECTED_FRAUD'
-- Exclude all suspected fraud orders.
-- GROUP BY type
-- Group the records based on transaction type.
-- COUNT(order_id)
-- Count total orders for each transaction type.
-- ORDER BY Orders DESC
-- Sort the result from highest number of orders to lowest.

#*************************************************************************************************************************************


-- Question 2: Get the list of the Top 3 customers based on the completed orders along with the following details:
-- Customer Id, Customer First Name, Customer City, Customer State, Number of completed orders, Total Sales
-- Expected Output: Customer Id | Customer First Name | Customer City | Customer State | 
-- 				Completed orders | Total Sales; Retain only top 3 customer based on Completed orders

--  Meaning 

-- Find customers whose orders are completed.
-- Count how many completed orders each customer has.
-- Calculate total sales amount for each customer.
-- Show customer details:
-- Customer Id
-- First Name
-- City
-- State
-- Keep only the Top 3 customers who have the highest number of completed orders.

SELECT 
    c.id AS "Customer Id",
    c.first_name AS "Customer First Name",
    c.city AS "Customer City",
    c.state AS "Customer State",
    COUNT(o.order_id) AS "Completed Orders",
    SUM(oi.sales) AS "Total Sales"
FROM orders o
JOIN ordered_items oi
    ON o.order_id = oi.order_id
JOIN customer_info c
    ON o.customer_id = c.id
WHERE o.order_status = 'COMPLETE'
GROUP BY 
    c.id,
    c.first_name,
    c.city,
    c.state
ORDER BY "Completed Orders" DESC
LIMIT 3;

-- Explanation
-- Join orders and ordered_items
-- To get sales amount for each order.
-- Filter COMPLETE orders
-- Only keep orders where status is 'COMPLETE'.
-- Join with customer_info
-- To get customer name, city, and state.
-- GROUP BY customer details
-- Create customer-wise summary.
-- COUNT(order_id)
-- Count completed orders for each customer.
-- SUM(sales)
-- Calculate total sales for each customer.
-- ORDER BY Completed Orders DESC
-- Highest completed orders first.
-- LIMIT 3
-- Show only top 3 customers.

#**************************************************************************************************************************************

-- Question 3: Get the order count by the Shipping Mode and the Department Name. Consider departments 
-- with at least 40 closed/completed orders.

-- Expected Output: Shipping Mode | Department Name | Orders; 
-- 				 Retain departments with atleast 40 closed/completed order

-- Meaning

-- Find the number of orders for each:
-- Shipping Mode
-- Department Name

-- Only consider orders whose status is:
-- COMPLETE
-- CLOSED

-- Keep only those department + shipping mode combinations where total orders are at least 40.

SELECT
    o.Shipping_Mode,
    d.Name AS Department_Name,
    COUNT(o.Order_Id) AS Orders

FROM orders o

JOIN ordered_items oi
    ON o.Order_Id = oi.Order_Id

JOIN product_info p
    ON oi.Item_Id = p.Product_Id

JOIN department d
    ON p.Department_Id = d.Id

WHERE o.Order_Status IN ('COMPLETE', 'CLOSED')

AND d.Name IN (

    SELECT d.Name

    FROM orders o

    JOIN ordered_items oi
        ON o.Order_Id = oi.Order_Id

    JOIN product_info p
        ON oi.Item_Id = p.Product_Id

    JOIN department d
        ON p.Department_Id = d.Id

    WHERE o.Order_Status IN ('COMPLETE', 'CLOSED')

    GROUP BY d.Name

    HAVING COUNT(o.Order_Id) >= 40
)

GROUP BY
    o.Shipping_Mode,
    d.Name;
    
#***************************************************************************************************
-- Question 4: Create a new field as shipment compliance based on Real_Shipping_Days and Scheduled_Shipping_Days. 
-- It should have the following values:
-- 	Cancelled shipment - If the Order Status is SUSPECTED_FRAUD or CANCELED
-- 	Within schedule - If shipped within the scheduled number of days 
-- 	On time - If shipped exactly as per schedule
-- 	Upto 2 days of delay - If shipped beyond schedule but delay upto 2 days
-- 	Beyond 2 days of delay - If shipped beyond schedule with delay beyond 2 days
--     

-- Which shipping mode was observed to have the greatest number of delayed orders?

-- Expected Output: 1) order_id | shipment_compliance; 2) shipping_mode | Number of delayed orders

# Meaning
-- Create a new column called shipment_compliance.
-- Check shipping performance by comparing:
-- real_shipping_days
-- scheduled_shipping_days
-- Give different labels based on conditions:
-- Cancelled shipment
-- Within schedule
-- On time
-- Upto 2 days of delay
-- Beyond 2 days of delay
-- Then count delayed orders for each shipping mode.
-- Find which shipping mode has the highest delayed orders.

select Order_Id,shipment_compliance,Shipping_Mode,
count(Order_Id) over (partition by Shipping_Mode) as Number_delayed_orders
from (
 select Order_Id,Shipping_Mode,
case
when Order_Status in ('SUSPECTED_FRAUD','CANCELED')
then 'Cancelled Shipment'
when Scheduled_Shipping_Days > Real_Shipping_Days 
then 'Within Schedule'
when Real_Shipping_Days =  Scheduled_Shipping_Days
then 'On time'
when Real_Shipping_Days > Scheduled_Shipping_Days +2
then 'Beyond 2 days of delay'
when Real_Shipping_Days > Scheduled_Shipping_Days 
and Real_Shipping_Days<=Scheduled_Shipping_Days+2
then 'Upto 2 days of delay'
Else 'Unknown'
end as Shipment_Compliance
from orders
) F 
where shipment_compliance IN ('Upto 2 days of delay','Beyond 2 days of delay')
order by Number_delayed_orders  desc
limit 1;

#************************************************************************************************************************
-- Question 5: An order is cancelled when the status of the order is either CANCELED or SUSPECTED_FRAUD. 
-- Obtain the list of states by the order cancellation % and sort them in the descending order of the 
-- cancellation %.         Definition: Cancellation % = Cancelled order / Total Orders

-- Expected Output: Order State | Cancellation Percentage;  Sort in descending order of cancellation %

-- Meaning
-- Look at each state (like Maharashtra, Delhi, etc.).
-- Find:
-- Total orders from that state
-- How many of those orders were cancelled

-- Cancellation means:
-- CANCELED
-- SUSPECTED_FRAUD

-- Then calculate:
-- Cancellation % = (Cancelled Orders ÷ Total Orders) × 100

-- Finally:
-- Show state-wise cancellation %
-- Sort from highest to lowest cancellation %

SELECT 
    Order_State AS "Order State",
    ROUND((SUM(CASE 
			  WHEN Order_status IN ('CANCELED', 'SUSPECTED_FRAUD') Then 1
              ELSE 0 
		    END) / COUNT(Order_Id))*100,
		    2) AS "Cancellation Percentage"
FROM 
    orders 
GROUP BY Order_state
ORDER BY "Cancellation Percentage" DESC;
