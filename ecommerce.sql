DELETE FROM orders
WHERE CONCAT(`Order ID`,`Order Date`,CustomerName,State,City) IS NULL;

-- How many distinct category are there
SELECT COUNT(DISTINCT(Category))
FROM details;

-- How many sub-category in each category
SELECT COUNT(DISTINCT `Sub-Category`),Category
FROM details
GROUP BY Category
ORDER BY Category;

-- Different sub-category in each category
SELECT DISTINCT `Sub-Category`,Category
FROM details
ORDER BY Category;

-- Most selling Category
SELECT Category, count(Category) AS most_selling_product
FROM details 
GROUP BY Category 
ORDER BY most_selling_product DESC LIMIT 1 ;

-- Total profit in each category
SELECT Category, SUM(Profit) AS Total_Profit
FROM details GROUP BY Category ORDER BY Total_Profit DESC ;

-- Total profit in each sub-category
SELECT `Sub-Category`, SUM(Profit) AS Total_Profit
FROM details 
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC ;

-- Total profit in each city
SELECT city, SUM(Profit) as total_profit
FROM orders,details 
GROUP BY city 
ORDER BY total_profit DESC ;

-- Total amount in each sub-category
SELECT `Sub-Category`, SUM(Amount) AS total_Amount
FROM details
GROUP BY `Sub-Category`
ORDER BY total_Amount DESC;

-- Most selling sub-category
SELECT `Sub-Category`,SUM(Quantity) AS Total_quantity
FROM details
GROUP BY `Sub-Category`
ORDER BY Total_Quantity desc;

-- Total profit in each state
SELECT State, SUM(Profit) AS total_profit
FROM orders,details 
GROUP BY State 
ORDER BY total_quantity DESC ;

-- Amount earned in each category
SELECT Category, 
       SUM( Amount) AS category_Amount
  FROM details
 GROUP BY Category
 ORDER BY category_Amount DESC
;

-- Sales based on Customer
SELECT o.CustomerName, SUM( Amount) AS Amount
  FROM details d
  JOIN orders o
    ON d.`Order ID` = o.`Order ID`
 GROUP BY o.CustomerName
 ORDER BY Amount desc;
 
 -- Top 5 Customers
 
 WITH customer_table as(
 SELECT o.CustomerName, SUM(Amount) AS Amount
  FROM orders o,details d
 GROUP BY o.CustomerName
 )
 SELECT o.CustomerName,State,City, c.Amount
 FROM orders o
 JOIN customer_table c
	ON o.CustomerName=c.CustomerName
 ORDER BY c.Amount DESC
LIMIT 10;

-- STRING FORMAT TO DATE FORMAT 

ALTER TABLE orders
MODIFY `Order Date` date;

UPDATE orders
set `Order Date`=str_to_date(`Order Date`,"%d-%m-%Y");

-- Yearly sales
SELECT
  YEAR(`Order Date`) AS year,
  SUM(Amount) as Sales
FROM orders, details
GROUP BY year
;

-- Total sales in different cities in Maharashtra
SELECT city, SUM(Amount) AS Sales
FROM details,orders
WHERE State = 'Maharashtra'
GROUP BY city;

-- Monthly sales for each category
SELECT d.Category, SUM(d.Amount),YEAR(o.`Order Date`) AS year,
  MONTHNAME(o.`Order Date`) AS month
FROM details d
LEFT JOIN orders o ON o.`Order ID`=d.`Order ID`
GROUP BY d.Category,year,month
ORDER BY year,month;

SELECT o.`Order Date`,d.Category, d.`Sub-Category`,d.Amount,d.Profit,weekday(o.`Order Date`)
FROM details d
JOIN orders o
	ON d.`Order ID`=o.`Order ID`
WHERE weekday(o.`Order Date`)=1;

-- Profit or Loss for each category
SELECT Category,`Sub-Category`,Amount,Profit,
			CASE WHEN PROFIT < 0 THEN 'LOSS '
				ELSE 'PROFIT'
                END AS 'PROFIT OR LOSS'
FROM details;










