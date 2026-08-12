-- Project Goal:
-- Build an executive preformance report to present trends of sales and business preformance.

/*
=======================================
Data Cleaning and Validation Process
=======================================
*/

  -- No issues were identified, checked each column with the query below:


SELECT DISTINCT
  `Product Name`
FROM
  `austin-wagner-projects.ECommerce_sales.Raw Table`

  
  -- Validate the time-frame being analyzed for business objectives

  
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


  -- Identified the dataset is from 2022 to 2024 and that all columns were already clean to start analyzing
  

    =====================================================
      Objective 1:
      Evaluate Sales and profit performance over time.
    =====================================================



     THE FOLLOWING QUERIES WERE EXECUTED SEPARATELY FOR 2022, 2023, AND
             2024 BY MODIFYING THE DATE RANGE IN THE WHERE CLAUSE.
    =====================================================================  


  -- Lets investigate which region had the most sales and the highest profit across all three years. */

SELECT
   Region,
   ROUND(SUM(Profit), 2) AS Total_Profit,
   SUM(Sales) AS Total_Sales
FROM
   `austin-wagner-projects.ECommerce_sales.Raw Table`
WHERE
   `Order Date` BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY
   Region
ORDER BY
   Total_Profit DESC;


/*
QUERY RESULTS for Regional Sales in 2022
+--------+--------------+-------------+
| Region | Total_Profit | Total_Sales |
+--------+--------------+-------------+
| East   |   155471.52  |    842336   |
| West   |   143708.69  |    820677   |
| South  |   143618.92  |    821619   |
| North  |   130057.85  |    771338   |
+--------+--------------+-------------+


QUERY RESULTS for 2023
+--------+--------------+-------------+
| Region | Total_Profit | Total_Sales |
+--------+--------------+-------------+
| West   |   176199.93  |   1002600   |
| South  |   175862.35  |    954257   |
| North  |   161174.38  |    920084   |
| East   |   153629.76  |    909651   |
+--------+--------------+-------------+


QUERY RESULTS for 2024
+--------+--------------+-------------+
| Region | Total_Profit | Total_Sales |
+--------+--------------+-------------+
| West   |   175450.11  |   1021173   |
| East   |   155787.18  |    923123   |
| South  |   138622.00  |    883672   |
| North  |   135082.52  |    797351   |
+--------+--------------+-------------+


 -- -- INSIGHTS:
-- The Western Region demostrates the strongest finnacial preformance from 2022 through 2024, Finishing the highest performing region in both 2023 and 2024.
-- Results for 2024 reflect the largest difference in total sales and total profit across all regions compared to 2023 and 2022.
-- Northern and southern regions had a similar pattern of significant growth from 2022 to 2023, Then in the year 2024, both regions experienced a sharp decline.
-- The Eastern Region recorded consistent growth in Total Sales from 2022 to 2024. Although Profit decline in 2023, it recovered in 2024, indicating a stable financial performance.


    =======================================================
      Objective 2:
      Analyze Product and Category Profitability Trends.
    =======================================================


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


/* QUERY RESULTS for Top Products by Total Profit 2022
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
*/

   -- -- INSIGHTS:
  -- Profits for each product shifted noticeably between 2022 and 2024. Keyboards generated the highest total profit in 2022, Camera became a top performing product in 2023, and Monitors ranked first in 2024.
     These changes suggest the highest preforming products evolve over time rather than remaining consistant.
  -- Camera and Monitor are among the top 3 highest-performing products across all three years



  -- Breaking down the top performing products for each year in every region.

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
  Region,
  Total_Profit DESC;

/* QUERY RESULTS for Highest-Profit Product by Region in 2022
+--------+--------------+-------------+--------------+
| Region | Product Name | Category    | Total_Profit |
+--------+--------------+-------------+--------------+
| East   | Smartphone   | Electronics |   25316.10   |
| North  | Laptop       | Electronics |   17132.22   |
| South  | Camera       | Electronics |   20107.57   |
| West   | Smartwatch   | Electronics |   18234.46   |
+--------+--------------+-------------+--------------+


QUERY RESULTS for 2023
+--------+--------------+-------------+--------------+
| Region | Product Name | Category    | Total_Profit |
+--------+--------------+-------------+--------------+
| East   | Laptop       | Electronics |    23788.81  |
| North  | Mouse        | Accessories |    22875.52  |
| South  | Camera       | Electronics |    29823.72  |
| West   | Monitor      | Accessories |    26324.95  |
+--------+--------------+-------------+--------------+


QUERY RESULTS for 2024
+--------+--------------+-------------+--------------+
| Region | Product Name | Category    | Total_Profit |
+--------+--------------+-------------+--------------+
| East   | Printer      | Office      | 19244.19     |
| North  | Camera       | Electronics | 20984.89     |
| South  | Printer      | Office      | 18416.93     |
| West   | Smartphone   | Electronics | 27703.82     |
+--------+--------------+-------------+--------------+

  -- -- INSIGHTS:
 -- In 2024, Printers recorded the highest profit in both the Eastern and Southern region, while Camera's and Smartphones remained the top category in the Northern and Western regions.
 -- Camera's in the Southern region demonstrated consistancy from 2022 to 2023, and with 2023 being the highest profitable item among all regions.
 -- Smartphone emerged as the highest profit product in the Eastern region in 2022 before becoming the top-performing product in the Western region in 2024.


    ==========================================================
      Objective 3:
      Discover regional performance for growth opportunities.
    ==========================================================
*/
