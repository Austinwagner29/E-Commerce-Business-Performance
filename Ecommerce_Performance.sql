-- Project Goal:
-- Build an executive preformance report to present trends and patterns of sales and business preformance from 2022 to 2024.

/*
=======================================
Data Cleaning and Validation Process
=======================================
*/

  -- No issues were identified, checked each column with the query below for spelling errors and leading and trailing spaces:


SELECT DISTINCT
  `Product Name`
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`


  -- Checked for null or missing values

  SELECT
  COUNT(*) AS Total_Rows,
  COUNTIF(`Order Date` IS NULL) AS Missing_Order_Date,
  COUNTIF(Sales IS NULL) AS Missing_Sales,
  COUNTIF(Profit IS NULL) AS Missing_Profit,
  COUNTIF(Category IS NULL) AS Missing_Caregory,
  COUNTIF(Region IS NULL) AS Missing_Region,
  COUNTIF(Quantity IS NULL) AS Missing_Quantity
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`;

  
  -- Checking the time-frame being analyzed for business objectives

  
SELECT DISTINCT
  MIN(`Order Date`) AS MIN_Order_Date,
  MAX(`Order Date`) AS MAX_Order_Date
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`
ORDER BY
 MIN_Order_Date DESC;


/* Query Results:
  | MIN_Order_Date | MAX_Order_Date |
  |:---------------|:---------------|
  |   2022-01-01   |   2024-12-31   |


-- Confirmed the dataset spans from January 1, 2022 through December 31, 2024. No data quality issues were identified during the initial validation process.
  



    =====================================================
      Objective 1:
      Evaluate Sales and profit performance over time.
    =====================================================


  -- Lets investigate which region had the most sales and the highest profit across all three years. */

SELECT
  EXTRACT(YEAR FROM `Order Date`) AS Sales_Year,
  Region,
  ROUND(SUM(Profit), 2) AS Total_Profit,
  SUM(Sales) AS Total_Sales
FROM 
  `austin-wagner-projects.ECommerce_sales.Raw Table`
GROUP BY
  Sales_Year,
  Region
ORDER BY
  Sales_Year,
  Total_Profit DESC;


/* QUERY RESULTS for Regional Sales Performance from 2022–2024
+------------+--------+--------------+--------------+
| Sales_Year | Region | Total_Profit |  Total_Sales |
+------------+--------+--------------+--------------+
| 2022       | East   |  155471.52   |    842,336   |
| 2022       | West   |  143708.69   |    820,677   |
| 2022       | South  |  143618.92   |    821,619   |
| 2022       | North  |  130057.85   |    771,338   |
+------------+--------+--------------+--------------+
| 2023       | West   |  176199.93   |  1,002,600   |
| 2023       | South  |  175862.35   |    954,257   |
| 2023       | North  |  161174.38   |    920,084   |
| 2023       | East   |  153629.76   |    909,651   |
+------------+--------+--------------+--------------+
| 2024       | West   |  175450.11   |  1,021,173   |
| 2024       | East   |  155787.18   |    923,123   |
| 2024       | South  |  138622.00   |    883,672   |
| 2024       | North  |  135082.52   |    797,351   |
+------------+--------+--------------+--------------+

 -- -- INSIGHTS:
-- The Western Region recorded the highest performance in both 2023 and 2024, aswell as the first region to achieve over 1 million in total sales.
-- 2024 showed the largest regional performance gap with a difference of 223,822 between the highest and lowest sales totals and a $40,367.59 difference in profit.
-- Northern and southern regions had a similar pattern of growth from 2022 to 2023, Then in the year 2024, both regions experienced a decline.
-- The Eastern Region recorded consistent growth in Total Sales from 2022 to 2024, Indicating a stable and consistant financial performance.




    =======================================================
      Objective 2:
      Analyze Product and Category Profitability Trends.
    =======================================================


      SOME QUERIES BELOW WERE EXECUTED SEPARATELY FOR 2022, 2023, AND
            2024 BY MODIFYING THE DATE RANGE IN THE WHERE CLAUSE.
    ====================================================================


-- Lets take a look and see what product generates the most profit for each year  */

  SELECT
    `Product Name`,
    Category,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `austin-wagner-projects.ECommerce_sales.Raw Table`
WHERE
    `Order Date` BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY
    `Product Name`,
    Category
ORDER BY
    Total_Profit DESC;



/* QUERY RESULTS for Top Products by Total Profit in 2022
+-------------+---------------+---------------------+--------------+
| Product Name| Category      | Total_Quantity_Sold | Total_Profit |
+-------------+---------------+---------------------+--------------+
| Keyboard    | Accessories   | 555                 | 64284.47     |
| Camera      | Electronics   | 555                 | 62373.52     |
| Monitor     | Accessories   | 556                 | 59724.94     |
| Smartwatch  | Electronics   | 584                 | 58629.76     |
| Mouse       | Accessories   | 562                 | 58560.32     |
| Tablet      | Electronics   | 593                 | 56317.11     |
| Smartphone  | Electronics   | 497                 | 56153.57     |
| Headphones  | Accessories   | 510                 | 55617.85     |
| Laptop      | Electronics   | 486                 | 52762.34     |
| Printer     | Office        | 489                 | 48433.10     |
+-------------+---------------+---------------------+--------------+


QUERY RESULTS for 2023
+-------------+---------------+---------------------+--------------+
| Product Name| Category      | Total_Quantity_Sold | Total_Profit |
+-------------+---------------+---------------------+--------------+
| Camera      | Electronics   | 637                 | 82077.98     |
| Mouse       | Accessories   | 654                 | 74811.55     |
| Monitor     | Accessories   | 654                 | 74576.40     |
| Printer     | Office        | 673                 | 73969.33     |
| Laptop      | Electronics   | 617                 | 73629.14     |
| Smartwatch  | Electronics   | 593                 | 61245.46     |
| Smartphone  | Electronics   | 533                 | 60087.77     |
| Headphones  | Accessories   | 492                 | 58106.41     |
| Tablet      | Electronics   | 539                 | 54229.80     |
| Keyboard    | Accessories   | 533                 | 54132.58     |
+-------------+---------------+---------------------+--------------+


QUERY RESULTS for 2024
+-------------+---------------+---------------------+--------------+
| Product Name| Category      | Total_Quantity_Sold | Total_Profit |
+-------------+---------------+---------------------+--------------+
| Monitor     | Accessories   | 666                 | 67726.83     |
| Smartphone  | Electronics   | 587                 | 67055.63     |
| Camera      | Electronics   | 603                 | 63179.49     |
| Printer     | Office        | 572                 | 62992.45     |
| Laptop      | Electronics   | 555                 | 59365.33     |
| Smartwatch  | Electronics   | 630                 | 59120.59     |
| Headphones  | Accessories   | 602                 | 58753.94     |
| Keyboard    | Accessories   | 596                 | 57397.63     |
| Tablet      | Electronics   | 601                 | 56958.10     |
| Mouse       | Accessories   | 537                 | 52391.82     |
+-------------+---------------+---------------------+--------------+


   -- -- INSIGHTS:
  -- Profits for each product shifted noticeably between 2022 and 2024. Keyboards generated the highest total profit in 2022, Cameras became a top performing product in 2023, and Monitors ranked first in 2024.
     These changes suggest the highest preforming products evolve over time rather than remaining consistant.
  -- Cameras and Monitors are among the top 3 highest-performing products across all three years. 
*/


  -- Breaking down the top performing product for each year in every region.

SELECT
  Region,
  `Product Name`,
  Category,
  ROUND(SUM(Profit), 2) AS Total_Profit
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`
WHERE
  `Order Date` BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY
  Region,
  `Product Name`,
  Category
QUALIFY
  ROW_NUMBER() OVER (PARTITION BY Region ORDER BY Total_Profit DESC) <= 1
ORDER BY
  Region;



/* QUERY RESULTS for Highest-Profit Product by Region in 2022
+--------+--------------+-------------+--------------+
| Region | Product Name | Category    | Total_Profit |
+--------+--------------+-------------+--------------+
| East   | Smartphone   | Electronics |   25316.10   |      Highest: $25,316
| North  | Laptop       | Electronics |   17132.22   |      Lowest: $17,132
| South  | Camera       | Electronics |   20107.57   |      Range: 8,184
| West   | Smartwatch   | Electronics |   18234.46   |
+--------+--------------+-------------+--------------+


QUERY RESULTS for 2023
+--------+--------------+-------------+--------------+
| Region | Product Name | Category    | Total_Profit |
+--------+--------------+-------------+--------------+
| East   | Laptop       | Electronics |   23788.81   |      Highest: $29,824
| North  | Mouse        | Accessories |   22875.52   |      Lowest: $22,876
| South  | Camera       | Electronics |   29823.72   |      Range: 6,948
| West   | Monitor      | Accessories |   26324.95   |
+--------+--------------+-------------+--------------+


QUERY RESULTS for 2024
+--------+--------------+-------------+--------------+
| Region | Product Name | Category    | Total_Profit |
+--------+--------------+-------------+--------------+
| East   | Printer      | Office      |   19244.19   |      Highest: $27,704
| North  | Camera       | Electronics |   20984.89   |      Lowest: $18,417
| South  | Printer      | Office      |   18416.93   |      Range: 9,287
| West   | Smartphone   | Electronics |   27703.82   |
+--------+--------------+-------------+--------------+

  -- -- INSIGHTS:
 -- In 2024, Printers recorded the highest profit in both the Eastern and Southern region, But those regions recorded the lowest total profit.
 -- in the Southern region, Cameras demonstrated consistancy from 2022 to 2023, with 2023 being the highest profitable item among all regions in all three years.
 -- In 2023, total profits had the smallest range between the lowest and highest profit margins for all regions.



    ====================================================================================================================================================================================================
       It could be insightful to further investigate and perform a deeper analysis to discover the factors that influence individual product performance. However, for the simplicity of this report,
       no single product consistently outperformed the others across all three years, and no clear trends were identified.
    ====================================================================================================================================================================================================



    ===============================================================
      Objective 3:
      Identify Monthly Sales Trends and Peak Performance Periods.
    ===============================================================

  -- After creating a visual in PowerBI for the month to month sales and profit in each year, I used the visual to provide me a better idea of where the trends and patterns happen to investigate further.

  -- First thing that was noticed was was each year had a drop from January to February, with 2022 and 2024 having the lowest profit out of all 12 calender months.
  -- Next, In both 2023 and 2024, there are upward trends in profit from Novermber to December, with 2023s December recording an all-time high across all three years.
  -- August 2023 outperformed the same month in both 2022 and 2024 before profit declined during September and October.        */



  -- Lets check the ranges of the difference in profits from the Month January to February for all three years.


SELECT
  FORMAT_DATE('%B', `Order Date`) AS Month,
  EXTRACT(YEAR FROM `Order Date`) AS Year,
  ROUND(SUM(Profit), 2) AS Profit,
  SUM(sales) AS Total_Sales
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`
WHERE
  EXTRACT(MONTH FROM `Order Date`) BETWEEN 1 AND 2
GROUP BY
  Year,
  Month,
  EXTRACT(MONTH FROM `Order Date`)
ORDER BY
  Year ASC,
  EXTRACT(MONTH FROM `Order Date`);



/* QUERY RESULTS for Profit Difference between January and Februrary (2022-2024)
+-----------+------+----------+-------------+
| Month     | Year | Profit   | Total Sales |
+-----------+------+----------+-------------+
| January   | 2022 | 63827.33 |    341544   |     Profit Difference: -29,742.43 (-46.60%)
| February  | 2022 | 34084.90 |    208775   |     Sales Difference:        -132,769
+-----------+------+----------+-------------+

+-----------+------+----------+-------------+
| Month     | Year | Profit   | Total Sales |
+-----------+------+----------+-------------+
| January   | 2023 | 63708.78 |    343256   |     Profit Difference: -10,063.35 (-15.80%)
| February  | 2023 | 53645.43 |    313931   |     Sales Difference:        -29,325
+-----------+------+----------+-------------+

+-----------+------+----------+-------------+
| Month     | Year | Profit   | Total Sales |
+-----------+------+----------+-------------+
| January   | 2024 | 49744.18 |    282814   |     Profit Difference: -18,515.79 (-37.22%)
| February  | 2024 | 31228.39 |    179708   |     Sales Difference:        -103,106
+-----------+------+----------+-------------+



   -- INSIGHTS
  -- 2022 recorded the largest difference, while 2023 had the smallest difference in total profits
  -- 2024 was the lowest performing year regarding total sales and also recorded the lowest profit across every month over all three years.


  -- Its important to note that after the sharp decline from January to February, sales immediatly increased in the following months indicating a strong recovery in 2022 and 2024.

  -- The next trend to look at are the trends from Novermeber to December



        SAME QUERY ABOVE WAS USED BELOW, CHANGED "WHERE" TO 11 and 12
     ===================================================================

QUERY RESULTS for Profit Difference between Novemeber and December (2022-2024)
+-----------+------+----------+-------------+
| Month     | Year | Profit   | Total Sales |
+-----------+------+----------+-------------+
| November  | 2022 | 50120.69 |    257111   |     Profit Difference: -5,377.11 (-10.73%)
| December  | 2022 | 44743.58 |    259041   |     Sales Difference:        +1,930
+-----------+------+----------+-------------+

+-----------+------+----------+-------------+
| Month     | Year | Profit   | Total Sales |
+-----------+------+----------+-------------+
| November  | 2023 | 52537.37 |    306195   |     Profit Difference: +22,968.39 (+43.71%)
| December  | 2023 | 75505.76 |    375064   |     Sales Difference:        +68,869
+-----------+------+----------+-------------+

+-----------+------+----------+-------------+
| Month     | Year | Profit   | Total Sales |
+-----------+------+----------+-------------+
| November  | 2024 | 42179.73 |    291769   |     Profit Difference: +11,413.06 (+27.06%)
| December  | 2024 | 53592.79 |    324997   |     Sales Difference:        +33,228
+-----------+------+----------+-------------+



  -- -- INSIGHTS
 -- In 2023, November to December recorded the largest month over month profit increase across all three years.
 -- 2022 was the only year that had a decrease in profit even with an increase in total sales.

 -- Since December of 2023 recorded the highest profit across all three years, it would be worth determing what items generated the highest profit to help replicate this performance. */



 -- Ranking top 5 products for the year 2023 AND 2024

SELECT
  FORMAT_DATE('%B', `Order Date`) AS Month,
  EXTRACT(YEAR FROM `Order Date`) AS Year,
  ROUND(SUM(Profit), 2) AS Profit,
  SUM(sales) AS Total_Sales,
  `Product Name` AS Product
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`
WHERE
  EXTRACT(MONTH FROM `Order Date`) = 12
  AND EXTRACT(YEAR FROM `Order Date`) IN (2023, 2024)
GROUP BY
  Year,
  Month,
  Product,
  EXTRACT(MONTH FROM `Order Date`)
QUALIFY
  RANK() OVER (PARTITION BY Year ORDER BY Profit DESC) <= 5
ORDER BY
  Year ASC,
  Profit DESC,
  EXTRACT(MONTH FROM `Order Date`);


/* QUERY RESULTS for Top 5 Products in December (2023 & 2024)
+----------+------+----------+-------------+-------------+
| Month    | Year | Profit   | Total Sales | Product     |
+----------+------+----------+-------------+-------------+
| December | 2023 | 12504.72 |    59534    | Laptop      |
| December | 2023 | 11337.26 |    55124    | Camera      |
| December | 2023 | 11288.95 |    52557    | Mouse       |
| December | 2023 | 8666.66  |    41950    | Headphones  |
| December | 2023 | 8417.51  |    36904    | Tablet      |
+----------+------+----------+-------------+-------------+
| December | 2024 | 9002.67  |    63347    | Headphones  |
| December | 2024 | 6876.65  |    42195    | Smartwatch  |
| December | 2024 | 6741.59  |    36296    | Monitor     |
| December | 2024 | 6544.74  |    42761    | Tablet      |
| December | 2024 | 6335.44  |    30257    | Laptop      |
+----------+------+----------+-------------+-------------+

   -- -- INSIGHTS
 -- Headphone, Laptop and Tablet are all among the top 5 products that generated the most prodit for 2023 and 2024
 -- The total sale difference in Headphones between 2023 vs 2024 is quiet significant despite having similar prodit margins.
