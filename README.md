# Gamezone_Sales_Portofolio
# 🎮 GameZone Sales Analytics – SQL Project

This SQL-based analysis explores key sales metrics for **GameZone**, a gaming e-commerce business. The objective is to uncover trends in product performance, seasonal demand, and marketing effectiveness by analyzing customer order data from 2019 to 2021.

---

## 🔍 Insights Summary

To drive business decisions, we focused on the following KPIs:

- **Total Sales**: Total revenue generated from all transactions.
- **Yearly Sales Trend**: Identifying revenue trends across years.
- **Top-Selling Products**: Highlighting products with the highest revenue.
- **Marketing Channel Performance**: Evaluating which channels bring the most sales.
- **Sales by Location**: Discovering regions with the strongest performance.
- **AOV (Average Order Value)**: Measuring average spend per order.
- **Monthly Sales Trend**: Spotting seasonality and demand fluctuations.

📈 **Key Findings**:

- **Consistent Growth**: Sales steadily increased from 2019 to 2021, with strong Q4 performance due to holiday season spikes.
- **PlayStation 5 Bundle** is a seasonal best-seller, showing exceptional growth especially toward Q4.
- **Email Marketing** and **Paid Ads** contributed the highest revenue among all channels.
- **AOV Increased**: The Average Order Value grew from **$213.96** (Jan 2019) to **$328.01** (Dec 2020), signaling customers are spending more per order over time.
- **Fluctuating Items**: Products like **Acer Nitro V Gaming Laptop** showed inconsistent demand—ideal for flash sales strategy.

---

## 🧰 Tools Used

- **SQL (MySQL):** Data exploration, aggregation, and business logic queries
- **Power BI:** Visualization of trends and dashboards
- **Excel / CSV:** Raw data formatting and inspection

---

## 🧪 SQL Query Samples

```sql
-- Query 1: Total Sales
SELECT ROUND(SUM(usd_price), 2) AS total_sales
FROM orders3;

-- Query 2: Yearly Sales
SELECT YEAR(purchase_ts) AS year, 
       ROUND(SUM(usd_price), 2) AS yearly_sales
FROM orders3
GROUP BY year
ORDER BY year;

-- Query 3: Sales by Product
SELECT product_name, 
       ROUND(SUM(usd_price), 2) AS total_sales
FROM orders3
GROUP BY product_name
ORDER BY total_sales DESC;

-- Query 4: Sales by Marketing Channel
SELECT marketing_channel, 
       ROUND(SUM(usd_price), 2) AS total_sales
FROM orders3
GROUP BY marketing_channel
ORDER BY total_sales DESC;

-- Query 5: Sales by Location
SELECT store_location, 
       ROUND(SUM(usd_price), 2) AS total_sales
FROM orders3
GROUP BY store_location
ORDER BY total_sales DESC;

-- Query 6: Monthly Sales Trend
SELECT YEAR(purchase_ts) AS year,
       MONTH(purchase_ts) AS month,
       ROUND(SUM(usd_price), 2) AS monthly_sales
FROM orders3
GROUP BY year, month
ORDER BY year, month;

-- Query 7: Sales by Product Type and Month
SELECT product_type,
       YEAR(purchase_ts) AS year,
       MONTH(purchase_ts) AS month,
       ROUND(SUM(usd_price), 2) AS monthly_sales
FROM orders3
GROUP BY product_type, year, month
ORDER BY product_type, year, month;

-- Query 8: AOV (Average Order Value)
SELECT YEAR(purchase_ts) AS year,
       MONTH(purchase_ts) AS month,
       ROUND(SUM(usd_price) / COUNT(DISTINCT order_id), 2) AS AOV
FROM orders3
GROUP BY year, month
ORDER BY year, month;
