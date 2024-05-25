SET sql_safe_updates = 0;

SET sql_mode = "Traditional";

-- Customer Complaints Initial Data Analysis.

CREATE DATABASE customer_complaints;

-- Imported Customer Complaints data into MySQL using SQLAlchemy.

USE customer_complaints;

SELECT *
FROM complaints;

-- 1. Removing Duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Complaint ID`) AS "Row Number"
FROM complaints;

WITH Duplicates_CTE AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Complaint ID`) AS "Row Number"
FROM complaints)
SELECT *
FROM Duplicates_CTE
WHERE `Row Number` > 1;

-- 2. Data Formatting & Standardisation

DESCRIBE complaints;

SELECT DISTINCT `Company`
FROM complaints;

SELECT DISTINCT `Company public response`
FROM complaints;

SELECT DISTINCT `Company response to consumer`
FROM complaints;

SELECT DISTINCT `Complaint ID`
FROM complaints;

SELECT DISTINCT `Consumer consent provided?`
FROM complaints;

SELECT DISTINCT `Consumer disputed?`
FROM complaints;

SELECT DISTINCT `Date Received`
FROM complaints;

ALTER TABLE complaints
MODIFY COLUMN `Date Received` DATE;

SELECT DISTINCT `Date Submitted`
FROM complaints;

ALTER TABLE complaints
MODIFY COLUMN `Date Submitted` DATE;

SELECT DISTINCT `Issue`
FROM complaints;

SELECT DISTINCT `Product`
FROM complaints;

SELECT DISTINCT `State`
FROM complaints;

SELECT DISTINCT `Sub-issue`
FROM complaints;

SELECT `Sub-Issue`
FROM complaints
WHERE `Sub-Issue` = '""';

UPDATE complaints
SET `Sub-Issue` = NULL
WHERE `Sub-Issue` = '""';

SELECT DISTINCT `Sub-product`
FROM complaints;

UPDATE complaints
SET `Sub-product` = NULL
WHERE `Sub-product` = '""';


SELECT DISTINCT `Submitted via`
FROM complaints;

SELECT DISTINCT `Tags`
FROM complaints;

SELECT DISTINCT `Timely response?`
FROM complaints;

SELECT DISTINCT `ZIP code`
FROM complaints;

SELECT DISTINCT `All Complaints (Selected)`
FROM complaints;

SELECT DISTINCT `Number of Complaints`
FROM complaints;

SELECT DISTINCT `Target`
FROM complaints;

SELECT DISTINCT `Time to Receipt`
FROM complaints;

SELECT `Date Received`,
`Date Submitted`,
datediff(`Date Received`, `Date Submitted`) AS "Date Difference",
`Time to Receipt`
FROM complaints
WHERE datediff(`Date Received`, `Date Submitted`) <>  `Time to Receipt`;

-- 3. Imputing null/blank values

SELECT `State`,
`Zip Code`
FROM complaints;

-- 4. Removing unnecessary columns

ALTER TABLE complaints
DROP COLUMN `All Complaints (Selected)`,
DROP COLUMN `Number of Complaints`,
DROP COLUMN `Target`;
