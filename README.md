PROJECT  TITLE :
Commodity Price Analysis 

DECRIPTION OF PROJECT :
This project analyzes commodity market data using SQL to identify price trends, category-wise performance,
and patterns in commodity prices. The analysis helps understand market behavior and supports data-driven business decisions.

TOOLS USED :
.SQL (Data Cleaning, Queries, Analysis)
.Microsoft PowerPoint (Presentation of Findings)

DATA  SOURCES:
Commodity dataset collected from institute-provided datasets.

FEATURES :

1)Introduction: The project focuses on analyzing commodity data such as product categories, prices, quantities
and market trends using SQL queries.



2)Business Problem:
   
a)Monitor price fluctuations

b)Identify high-performing commodities

c)Understand market demand patterns

d)Make informed pricing decisions





3)Analysis Goals:

a)Analyze commodity price trends

b)Identify top-performing commodities

c)Compare categories based on price and quantity

d)Generate insights for business decision-making






4)Query Results & Insights:

Business Questions

1.Which commodities remained among the top 10 most expensive commodities in both 2019 and 2020?

How I Solved--

I used SQL CTEs to find the top 10 costliest commodities for 2019 and 2020 separately and 
then applied an INNER JOIN to identify the common commodities in both years.I found the products like Gents Shoes,
Black Pepper, Coffee, Meat,and Ghee remained consistently expensive, indicating strong and stable market demand.


2.Find the commodity with the maximum price difference across regions in June 2020.

How I Solved--

I calculated the minimum and maximum prices of each commodity in June 2020 and found the difference between them. 
Coffee showed the highest price difference of 2,435 across regions, indicating high price volatility and possible 
supply chain or demand issues.


3.Arrange the commodities in order based on the number of varieties in which they are available, 
  with the highest one shown at the top. Which is the 3rd commodity in the list?

  How I Solved--
  
  I counted the unique varieties of each commodity using COUNT(DISTINCT) and GROUP BY, sorted them in descending order, 
  and identified the third-ranked commodity using LIMIT and OFFSET. The result was Coffee with two varieties, 
  which indicates product diversification and market demand.
  

4.In the state with the least number of data points available. 
  Which commodity has the highest number of data points available?

 How I Solved--
 I first identified the state with the fewest records using a CTE, COUNT, and GROUP BY.
 Then, I counted commodity occurrences within that state and found that Rice had the highest number of records. 
 This suggests that Rice is an important commodity even in low-data regions and can help in demand and inventory planning.



 

5. What is the price variation of commodities for each city from Jan 2019 to Dec 2020 &
    Which commodity has seen the highest price variation and in which city?

How I Solved--

I compared January 2019 and December 2020 prices using CTEs and joins, calculated the price variation, and 
found that Moong in Chittoor had the highest increase of 22.22%. This helps identify commodities with high market volatility.
    



Insights: 

- Some commodities remained consistently expensive across multiple years.
  
- Certain commodities showed high regional price variation.
 
- Rice had one of the highest variety counts.
 
- Price fluctuations varied significantly across cities and states.
  
- Commodity trends helped identify regional market differences.




Business Impact: 

(a)Improved pricing decisions.

(b)Identification of profitable commodities.

(c)Data-driven business decision-making.   


-----------------------------------------------------------------------------------------------------------------------------
NEXT PROJECT

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


Query Result & Insight:

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





PPT LINK :


https://github.com/nupurchatterjee01-com/Commodity-and-Supply-Chain-SQL-Insights/blob/main/SQL_presentation%20by%20Nupur.pdf














