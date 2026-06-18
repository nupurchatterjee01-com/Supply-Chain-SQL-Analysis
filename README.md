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

(a)Coffee showed product diversification.

(b)Rice remained dominant in low-data regions.

(c)Moong in Chittoor had the highest price variation (22.22%).

(d)Certain commodities maintained consistently high prices.




Business Impact: 

(a)Improved pricing decisions.

(b)Identification of profitable commodities.

(c)Data-driven business decision-making.   












