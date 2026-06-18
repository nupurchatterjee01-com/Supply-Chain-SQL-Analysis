PROJECT TITLE :  Supply Chain Data Analysis Using SQL


DESCRIPTION :

This project analyzes supply chain data using SQL to identify trends in inventory, orders, shipping performance, supplier efficiency, and delivery delays. The analysis helps businesses improve operational efficiency and make better supply chain decisions.

TOOLS USED :

(a)SQL (MySQL)

(b)Microsoft PowerPoint (PPT)


DATA SOURCE :

The dataset was provided by my institute and contains information related to orders, products, suppliers, shipping, and delivery performance.


FEATURES :

1)Introduction :  Supply chain management involves the movement of products from suppliers to customers. Efficient supply chain operations help businesses reduce costs, improve delivery performance, and maintain customer satisfaction. This project uses SQL to analyze supply chain data and generate business insights.

2)Business Problem :

(a)Delayed deliveries

(b)Poor inventory management

(c)Inefficient supplier performance

(d)High operational costs
 
(c)Difficulty in identifying order and shipping trends


3)Query Result & Insight:

Business Questions solved

1: Get the number of orders by the Type of Transaction. Please exclude orders shipped from Sangli and Srinagar. Also, exclude the SUSPECTED_FRAUD cases based on the Order Status. Sort the result in the descending order based on the number of orders.

How I solve-

Filtered out orders from Sangli and Srinagar and excluded suspected fraud cases using the WHERE clause. Then used GROUP BY and COUNT() to calculate the number of orders for each transaction type and sorted the results in descending order.



2.Get the list of the Top 3 customers based on the completed orders along with the following details: Customer Id, Customer First Name, Customer City, Customer State, Number of completed orders, Total Sales.

How I solve-

Joined the Orders, Ordered_Items, and Customer tables using JOIN. Filtered only completed orders, calculated the number of completed orders and total sales using COUNT() and SUM(), and selected the top 3 customers using ORDER BY and LIMIT.


3.Get the order count by the Shipping Mode and the Department Name. Consider departments  with at least 40 closed/completed orders.

How I solve-

Joined Orders, Ordered_Items, Product, and Department tables. Filtered completed and closed orders, grouped the data by shipping mode and department, and used HAVING to include only departments with at least 40 orders.


4.reate a new field as shipment compliance based on Real_Shipping_Days and Scheduled_Shipping_Days. 


How I solve-

Created shipment categories using a CASE statement based on real and scheduled shipping days. Identified delayed shipments and used a window function (COUNT() OVER) to determine the shipping mode with the highest number of delayed orders.


5. An order is cancelled when the status of the order is either CANCELED or SUSPECTED_FRAUD. 
Obtain the list of states by the order cancellation % and sort them in the descending.



How I Solved-
Used CTEs to calculate cancelled orders and total orders for each state. Computed the cancellation percentage using a formula and sorted the states in descending order to identify regions with the highest cancellation rates.



INSIGHTS:

(a)Certain transaction types contributed significantly more orders.

(b)Top customers generated high completed orders and sales revenue.

(c)Some departments showed consistently high order volumes.

(d)Standard shipping modes experienced higher shipment delays.

(e) Cancellation percentages varied across different states.


BUSINESS IMPACT

1. Helps identify the most preferred payment methods and optimize transaction processing strategies.

2. Helps identify high-value customers and supports targeted marketing and customer retention efforts.

3. Helps evaluate shipping efficiency across departments and improve logistics planning.

4. Helps monitor delivery performance, reduce shipping delays, and improve customer satisfaction.

5. Helps identify states with high cancellation rates and enables businesses to take corrective actions to reduce order    losses.





PDF LINK :

















