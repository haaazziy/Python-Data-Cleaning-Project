-- SUPERSTORE DATA ANALYSIS
-- Task 3: Short Business Insights
-- Database: superstore_analysis
-- Table: cleaned_dataset

USE superstore_analysis;

-- 1. Which market generates the highest revenue?
SELECT
    market,
    ROUND(SUM(sales), 2) AS total_revenue
FROM cleaned_dataset
GROUP BY market
ORDER BY total_revenue DESC;


-- 2. Which category is least profitable?
SELECT
    category,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_dataset
GROUP BY category
ORDER BY total_profit ASC;


-- 3. Which shipping mode is most commonly used?
SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders
FROM cleaned_dataset
GROUP BY ship_mode
ORDER BY total_orders DESC;
