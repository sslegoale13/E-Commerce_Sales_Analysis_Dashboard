SET sql_safe_updates = 0;

SET sql_mode = "Traditional";

-- E-Commerce Sales Initial Data Analysis.

CREATE DATABASE ecommerce_sales;

-- Imported E-Commerce Sales data into MySQL using SQLAlchemy.

USE ecommerce_sales;

SELECT *
FROM orders;

-- 1. Removing Duplicates

WITH Duplicates_CTE AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
`Additional Order items`,
`Category Name`,
`Customer City`,
`Customer Country`,
`Customer Fname`,
`Customer Id`,
`Customer Segment`,
`Customer State`,
`Customer Zipcode`,
`Market`,
`Order Customer Id`,
`Order Date`,
`Order Id`,
`Order Region`,
`Order Item Total`,
`Order Quantity`,
`Product Price`,
`Profit Margin`,
`Profit Per Order`,
`Sales`) AS "Row Number"
FROM orders)
SELECT *
FROM Duplicates_CTE
WHERE `Row Number` > 1;

-- 2. Data Formatting & Standardisation

DESCRIBE orders;

SELECT DISTINCT `Additional Order items`
FROM orders
ORDER BY `Additional Order items` ASC;


SELECT `Additional Order items`,
`Category Name`
FROM orders;

SELECT `Additional Order items`,
`Category Name`
FROM orders
WHERE `Additional Order items` <> `Category Name`;

UPDATE orders
SET `Additional Order Items` = `Category Name`
WHERE `Additional Order Items` IS NULL;

SELECT DISTINCT `Customer City`
FROM orders
ORDER BY `Customer City` ASC;

SELECT *
FROM orders
WHERE `Customer City` = "CA";

UPDATE orders
SET `Customer Zipcode` = `Customer State`
WHERE `Customer Zipcode` IS NULL;

UPDATE orders
SET `Customer State` = NULL
WHERE `Customer State` IN (91732, 95758);

UPDATE orders
SET `Customer State` = `Customer City`
WHERE `Customer State` IS NULL;

UPDATE orders
SET `Customer City` = NULL
WHERE `Customer City` = "CA";

SELECT *
FROM orders
WHERE `Customer City` IS NULL;

SELECT *
FROM orders
WHERE `Customer Zipcode` IN (91732, 95758);

SELECT ord1.`Customer City`,
ord2.`Customer City`
FROM orders ord1
JOIN orders ord2
ON ord1.`Customer Zipcode` = ord2.`Customer Zipcode`
WHERE ord1.`Customer City` IS NULL AND ord2.`Customer City` IS NOT NULL;

UPDATE orders ord1
JOIN orders ord2
ON ord1.`Customer Zipcode` = ord2.`Customer Zipcode`
SET ord1.`Customer City` = ord2.`Customer City`
WHERE ord1.`Customer City` IS NULL AND ord2.`Customer City` IS NOT NULL;

SELECT *
FROM orders
WHERE `Customer City` IS NULL;

SELECT DISTINCT `Customer Country`
FROM orders
ORDER BY `Customer Country` ASC;

SELECT DISTINCT `Customer Fname`
FROM orders
ORDER BY `Customer Fname` ASC;

SELECT DISTINCT `Customer Id`
FROM orders
ORDER BY `Customer Id` ASC;

SELECT DISTINCT `Customer Segment`
FROM orders
ORDER BY `Customer Segment` ASC;

SELECT DISTINCT `Customer State`
FROM orders
ORDER BY `Customer State` ASC;

SELECT DISTINCT `Customer Zipcode`
FROM orders
ORDER BY `Customer Zipcode` ASC;

SELECT DISTINCT `Market`
FROM orders
ORDER BY `Market` ASC;

UPDATE orders
SET `Market` = "Latin America"
WHERE `Market` = "LATAM";

UPDATE orders
SET `Market` = "North America"
WHERE `Market` = "USCA";

SELECT DISTINCT `Order Customer Id`
FROM orders
ORDER BY `Order Customer Id` ASC;

SELECT DISTINCT `Order Date`
FROM orders
ORDER BY `Order Date` ASC;

SELECT `Order Date`,
date_format(str_to_date(`Order Date`, "%d-%m-%Y"), "%Y/%m/%d")
FROM orders;

UPDATE orders
SET `Order Date` = date_format(str_to_date(`Order Date`, "%d-%m-%Y"), "%Y/%m/%d");

ALTER TABLE orders
MODIFY COLUMN `Order Date` DATE;

SELECT DISTINCT `Order Id`
FROM orders
ORDER BY `Order Id` ASC;

SELECT DISTINCT `Order Region`
FROM orders
ORDER BY `Order Region` ASC;

SELECT `Market`,
`Order Region`
FROM orders
WHERE `Market` = "North America";

SELECT DISTINCT `Order Item Total`
FROM orders
ORDER BY `Order Item Total` ASC;

SELECT DISTINCT `Order Quantity`
FROM orders
ORDER BY `Order Quantity` ASC;

SELECT DISTINCT `Product Price`
FROM orders
ORDER BY `Product Price` ASC;

SELECT DISTINCT `Profit Margin`
FROM orders
ORDER BY `Profit Margin` ASC;

SELECT DISTINCT `Profit Per Order`
FROM orders
ORDER BY `Profit Per Order` ASC;

SELECT DISTINCT `Sales`
FROM orders
ORDER BY `Sales` ASC;

-- 3. Removing unnecessary columns

SELECT `Customer Id`,
`Order Customer Id`
FROM orders
WHERE `Customer Id` <> `Order Customer Id`;

SELECT `Additional Order items`,
`Category Name`
FROM orders
WHERE `Additional Order items` <> `Category Name`;

ALTER TABLE orders
DROP COLUMN `Additional Order items`,
DROP COLUMN `Order Customer Id`;