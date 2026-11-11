-- SUPERSTORE DATASET: SQL ANALYSIS
-- Database: superstore_analysis
-- Expected table: cleaned_dataset
-- Run this file after importing the cleaned Superstore CSV successfully.
-- The column names below match the supplied 21-column CSV.

USE superstore_analysis;

-- Optional validation: confirm the imported table and record count.
SHOW TABLES;
SELECT COUNT(*) AS total_records
FROM cleaned_dataset;


-- 1. TOP 10 PROFITABLE PRODUCTS
-- Products ranked by total profit (highest first).
SELECT
    product_name,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_dataset
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;


-- 2. TOP 10 CUSTOMERS BY SALES
SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM cleaned_dataset
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- 3. REGION-WISE TOTAL SALES
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales
FROM cleaned_dataset
GROUP BY region
ORDER BY total_sales DESC;


-- 4. CATEGORY-WISE AVERAGE PROFIT
SELECT
    category,
    ROUND(AVG(profit), 2) AS average_profit
FROM cleaned_dataset
GROUP BY category
ORDER BY average_profit DESC;


-- 5. HIGHEST DISCOUNT CATEGORY
-- Compares average discount by category.
SELECT
    category,
    ROUND(AVG(discount), 4) AS average_discount,
    ROUND(MAX(discount), 4) AS highest_single_discount
FROM cleaned_dataset
GROUP BY category
ORDER BY average_discount DESC;


-- 6. ORDERS WITH NEGATIVE PROFIT
-- Groups line items by order and returns orders whose combined profit is negative.
SELECT
    order_id,
    ROUND(SUM(profit), 2) AS total_order_profit
FROM cleaned_dataset
GROUP BY order_id
HAVING SUM(profit) < 0
ORDER BY total_order_profit ASC;


-- 7. MONTHLY SALES TREND
-- order_date is stored as text in M/D/YY format in the imported CSV.
SELECT
    DATE_FORMAT(
        STR_TO_DATE(order_date, '%c/%e/%y'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM cleaned_dataset
WHERE STR_TO_DATE(order_date, '%c/%e/%y') IS NOT NULL
GROUP BY sales_month
ORDER BY sales_month;


-- 8. MARKET-WISE REVENUE ANALYSIS
SELECT
    market,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_dataset
GROUP BY market
ORDER BY total_revenue DESC;


-- 9. TOP-PERFORMING SUB-CATEGORIES
-- Ranked by total sales; profit is included for additional context.
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_dataset
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 10;


-- 10. SHIP MODE USAGE ANALYSIS
-- Counts distinct orders for each shipping mode.
SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0 /
        (SELECT COUNT(DISTINCT order_id) FROM cleaned_dataset),
        2
    ) AS order_percentage
FROM cleaned_dataset
GROUP BY ship_mode
ORDER BY total_orders DESC;
